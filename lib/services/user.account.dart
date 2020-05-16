import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

enum UpdateType { photoUrl, diplayName, bioStatus }

//! Needs to be tested
//! --> Don't use <--
//! Error handling XX
class UserAccount {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  final String _usersCollectionData = "users";

  //*
  Future<void> _updatePhotoUrl(String profilePicDownloadLink) async {
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.photoUrl = profilePicDownloadLink;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }

  //* we are using every spacific argumant to its use case
  Future<void> _updateFirestoreUserData(
      {UpdateType updateType, FirebaseUser user, String customUpdate}) async {
    try {
      final String userID = (await _firebaseAuth.currentUser()).uid;
      final DateTime infoUpdateTime = DateTime.now();
      final DocumentReference userDoc =
          _firestore.collection(_usersCollectionData).document(userID);
      switch (updateType) {
        case UpdateType.diplayName:
          await userDoc.updateData(<String, dynamic>{
            'displayName': user.displayName,
            'lastInfoUpdate': infoUpdateTime,
          });
          return;
        case UpdateType.photoUrl:
          await userDoc.updateData(<String, dynamic>{
            'profilePicUrl': user.photoUrl,
            'lastInfoUpdate': infoUpdateTime,
          });
          return;
        case UpdateType.bioStatus:
          await userDoc.updateData(<String, dynamic>{
            'bioStatus': customUpdate,
            'lastInfoUpdate': infoUpdateTime,
          });
          return;
      }
    } catch (e) {
      print(e);
    }
  }

  //! weak error handling --> needs to be improved
  Future<void> uploadUserProfilePic(File imageFile) async {
    try {
      final DateTime profileImageCreationTime = DateTime.now();
      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
      final String userID = (await _firebaseAuth.currentUser()).uid;
      StorageReference ref = FirebaseStorage.instance
          .ref()
          .child("$userID/$userID-profilePic.jpg");
      StorageUploadTask uploadTask = ref.putFile(
          imageFile,
          StorageMetadata(
            customMetadata: {
              "creationTime": profileImageCreationTime.toString(),
            },
          ));
      String profilePicDownloadLink =
          (await (await uploadTask.onComplete).ref.getDownloadURL()).toString();
      try {
        await _updatePhotoUrl(profilePicDownloadLink);
        await _updateFirestoreUserData(
            updateType: UpdateType.photoUrl, user: currentUser);
      } catch (updatingUserProfileUrl) {
        throw PlatformException(code: 'ERROR_WHILE_UPDATING_USER_INFO');
      }
      // return profilePicDownloadLink;
    } on PlatformException catch (uploadUserProfilePicError) {
      throw PlatformException(
          code: "ERROR_COULDN'T_UPLOAD_PHOTO_FROM_USER_DEVICE",
          message:
              'three was an error while taking/uploading user photo from user\'s device gallery',
          details:
              "Details --> code: ${uploadUserProfilePicError.code}: message: ${uploadUserProfilePicError.message}");
    }
  }

  Future<String> _getAPI_KEY() async {
    try {
      RemoteConfig remoteConfig = await RemoteConfig.instance;
      await remoteConfig.fetch(expiration: const Duration(hours: 1));
      await remoteConfig.activateFetched();
      return remoteConfig.getValue('firebase_api_key').asString();
    } catch (e) {
      print(e);
    }
  }

  /// Common error codes
  ///    `INVALID_ID_TOKEN`:The user's credential is no longer valid. The user must sign in again.
  ///    `WEAK_PASSWORD`: The password must be 6 characters long or more.
  Future<void> changePassword(String newPassword) async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    if (currentUser == null) {
      throw "current user can't be 'null'";
    }
    final String FIREBASE_API_KEY = await _getAPI_KEY();
    final String changePasswordUrl =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/setAccountInfo?key=$FIREBASE_API_KEY';
    final String idToken = (await currentUser.getIdToken()).token;
    final Map<String, dynamic> payload = {
      'email': idToken,
      'password': newPassword,
      'returnSecureToken': true,
    };
    try {
      await http.post(
        changePasswordUrl,
        body: json.encode(payload),
        headers: {'Content-Type': 'application/json'},
      );
    } on PlatformException catch (httpPostError) {
      throw PlatformException(
          code: 'CHANGEING_USER_PASSWORD_FAILED',
          message: httpPostError.message,
          details:
              "Details --> code: ${httpPostError.code}: message: ${httpPostError.message}");
    }
    await currentUser.reload();
  }

  //* Changging userName
  Future<void> updateDisplayName(String userName) async {
    try {
      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
      final UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = userName;
      await currentUser.updateProfile(userUpdateInfo);
      await currentUser.reload();
      await _updateFirestoreUserData(
          updateType: UpdateType.diplayName, user: currentUser);
    } catch (updateUserDisplayNameError) {
      throw PlatformException(
          code: 'CHANGING_USER_DISPLAY_NAME_FAILED',
          message:
              'check the user collection data ($_usersCollectionData/[user ID])',
          details:
              "Details --> code: ${updateUserDisplayNameError.code}: message: ${updateUserDisplayNameError.message}");
    }
  }

  //* updating bio
  //? comes only from FirebaseStore
  Future<void> updateBioStatus(String bioStatus) async {
    try {
      await _updateFirestoreUserData(
          updateType: UpdateType.bioStatus, customUpdate: bioStatus);
    } catch (updateUserBioStatusError) {
      throw PlatformException(
        code: 'CHANGING_USER_BIO_FAILED',
        message:
            'check the user collection data (usersData/[user ID]/about/user info)',
        details:
            "Details --> code: ${updateUserBioStatusError.code}: message: ${updateUserBioStatusError.message}",
      );
    }
  }

  //! [DONE]: still under developing: DELETING USER INFORMATION FROM FIRESTORE STORAGE
  //* delete account
  //? Credential operation
  /// Errors:
  ///   • `ERROR_INVALID_CREDENTIAL` - If the [authToken] or [authTokenSecret] is malformed or has expired.
  ///   • `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
  ///   • `ERROR_USER_NOT_FOUND` - If the user has been deleted (for example, in the Firebase console)
  ///   • `ERROR_OPERATION_NOT_ALLOWED` - Indicates that Email & Password accounts are not enabled.
  ///
  //? Delete operation
  /// Errors:
  ///   • `ERROR_REQUIRES_RECENT_LOGIN` - If the user's last sign-in time does not meet the security threshold. Use reauthenticate methods to resolve.
  ///  • `ERROR_INVALID_CREDENTIAL` - If the credential is malformed or has expired.
  ///   • `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
  ///   • `ERROR_USER_NOT_FOUND` - If the user has been deleted (for example, in the Firebase console)
  Future<void> deleteUser(String email, String password) async {
    try {
      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
      AuthCredential credentials =
          EmailAuthProvider.getCredential(email: email, password: password);
      AuthResult result =
          await currentUser.reauthenticateWithCredential(credentials);
      await result.user.delete();
      //* deleting from firestore
      await _firestore
          .collection(_usersCollectionData)
          .document(currentUser.uid)
          .delete();
    } catch (deleteError) {
      throw PlatformException(
          code: deleteError.code, message: deleteError.message);
    }
  }
}

/**
 Future<String> uploadImage(var imageFile ) async {
    StorageReference ref = storage.ref().child("/photo.jpg");
    StorageUploadTask uploadTask = ref.putFile(imageFile);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = dowurl.toString();

    return url; 
}
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

//! Needs to be tested
//! --> Don't use <--
//! Error handling XX
class UserAccount {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //! weak error handling --> needs to be improved
  Future<void> uploadUserProfilePic(File imageFile) async {
    try {
      final DateTime profileImageCreationTime = DateTime.now();
      final String currentUserID = (await _firebaseAuth.currentUser()).uid;
      StorageReference ref = FirebaseStorage.instance
          .ref()
          .child("users_profile_pictures")
          .child("$currentUserID-profilePic.jpg");
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
        final FirebaseUser currentUser = await _firebaseAuth.currentUser();
        var userUpdateInfo = UserUpdateInfo();
        userUpdateInfo.photoUrl = profilePicDownloadLink;
        await currentUser.updateProfile(userUpdateInfo);
        await currentUser.reload();
      } catch (updatingUserProfileUrl) {
        print("updatingUserProfileUrl:" + updatingUserProfileUrl);
      }
      // return profilePicDownloadLink;
    } catch (uploadUserProfilePicError) {
      print("uploadUserProfilePicError:" + uploadUserProfilePicError);
      print("retrying...");
      return uploadUserProfilePic(imageFile);
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
    } catch (httpPostError) {
      throw PlatformException(
          code: httpPostError.code, message: httpPostError.message);
    }
    await currentUser.reload();
  }

  //* Changging userName
  Future<void> updateUserName(String userName) async {
    try {
      FirebaseUser currentUser = await _firebaseAuth.currentUser();
      var userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = userName;
      await currentUser.updateProfile(userUpdateInfo);
      await currentUser.reload();
    } catch (updateUserDisplayNameError) {
      throw "updateUserDisplayName: $updateUserDisplayNameError";
    }
  }

  //* changing bio

  //! still under developing: DELETING USER INFORMATION FROM FIRESTORE STORAGE
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
      FirebaseUser user = await _firebaseAuth.currentUser();
      AuthCredential credentials =
          EmailAuthProvider.getCredential(email: email, password: password);
      AuthResult result = await user.reauthenticateWithCredential(credentials);
      await result.user.delete();
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

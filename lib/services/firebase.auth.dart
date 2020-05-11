// import 'package:E_Soor/services/API.keys.dart';
import 'package:E_Soor/services/users.api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestoreStore = Firestore.instance;

  //* User status/info
  bool _isUserLoggedin = false;
  int _userId;
  String _userName;
  String _userPassword;
  String _userEmailAddress;

  bool get isUserAlreadyLoggedIb => _isUserLoggedin;

  //* GET CURRENT USER
  Future getCurrentUser() async {
    return (await _firebaseAuth.currentUser());
  }

  //* GET User ID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  //* Resister a New user
  Future<String> registerNewUser(LoginData singinFormIncommingData) async {
    _userPassword = singinFormIncommingData.password;
    _userEmailAddress = singinFormIncommingData.name;
    //* checking if the text field has valied  Email and Password
    /// Errors:
    ///   • `ERROR_WEAK_PASSWORD` - If the password is not strong enough.
    ///   • `ERROR_INVALID_EMAIL` - If the email address is malformed.
    ///   • `ERROR_EMAIL_ALREADY_IN_USE` - If the email is already in use by a different account.
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: _userEmailAddress,
        password: _userPassword,
      );
      _isUserLoggedin = true;
      //* if Everything went will return `null`
      return null;
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        switch (signUpError.code) {
          case "ERROR_INVALID_EMAIL":
            return signUpError.message;
            break;
          case "ERROR_EMAIL_ALREADY_IN_USE":
            return FirebaseUserErrors.registeredEmailIsAlreadyInUse;
            break;
          //! Will be implemented seperetly
          case "ERROR_WEAK_PASSWORD":
            return signUpError.message;
            break;
        }
      }
    }
  }

  //* Login
  Future<String> loginUser(LoginData singinFormIncommingData) async {
    _userPassword = singinFormIncommingData.password;
    _userEmailAddress = singinFormIncommingData.name;
    //* checking if the text field has valied  Email and Password
    /// Errors:
    ///   • `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
    ///   • `ERROR_WRONG_PASSWORD` - If the [password] is wrong.
    ///   • `ERROR_USER_NOT_FOUND` - If there is no user corresponding to the given [email] address, or if the user has been deleted.
    ///   • `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
    ///   • `ERROR_TOO_MANY_REQUESTS` - If there was too many attempts to sign in as this user.
    ///   • `ERROR_OPERATION_NOT_ALLOWED` - Indicates that Email & Password accounts are not enabled.
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: _userEmailAddress,
        password: _userPassword,
      );
      _isUserLoggedin = true;
      return null;
    } catch (signInError) {
      if (signInError is PlatformException) {
        switch (signInError.code) {
          case "ERROR_USER_NOT_FOUND":
            return FirebaseUserErrors.wrongEmailORPassword;
            break;
          case "ERROR_WRONG_PASSWORD":
            return FirebaseUserErrors.wrongEmailORPassword;
            break;
          case "ERROR_INVALID_EMAIL":
            return FirebaseUserErrors.wrongEmailORPassword;
            break;
          case "ERROR_USER_DISABLED":
            return signInError.message;
            break;
          case "ERROR_TOO_MANY_REQUESTS":
            return signInError.message;
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
            return signInError.message;
            break;
        }
      }
    }
  }

  //* Recover user's password
  Future<String> recoverPassword(String email) async {
    /// Errors:
    ///   • `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
    ///   • `ERROR_USER_NOT_FOUND` - If there is no user corresponding to the given [email] address.
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: email,
      );
      return null;
    } catch (recoverPasswordError) {
      if (recoverPasswordError is PlatformException) {
        switch (recoverPasswordError.code) {
          case "ERROR_USER_NOT_FOUND":
            return FirebaseUserErrors.wrongRecoverEmail;
            break;
          case "ERROR_INVALID_EMAIL":
            return FirebaseUserErrors.wrongEmailORPassword;
            break;
        }
      }
    }
  }

  //* user log out
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
      _isUserLoggedin = false;
    } catch (logOutError) {
      throw "Unexpected logout error: $logOutError";
    }
  }

  //! WILL BE DELETED
  //* Adding user initail/Important data to the `about` section on Firebase
  Future<void> uploadUserInitialData(
      String userEmail, String userPassword) async {
    try {
      String userID = (await _firebaseAuth.currentUser()).uid;
      await _firestoreStore
          .collection('userData')
          .document(userID)
          .collection('about')
          .add(User(
            userEmailAddress: userEmail,
            userPassword: userPassword,
            userID: userID,
          ).userToJson());
    } catch (uploadUserInitialDataError) {
      throw uploadUserInitialDataError;
    }
  }

  Future<Null> updateUserDisplayName(String userName) async {
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

  Future<Null> changePassword(String newPassword) async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    if (currentUser == null) {
      throw "current user can't be 'null'";
    }
    //! this API key will be omitted from the Github repo
    // final String API_KEY = SECRET_FIREBASE_API_KEY ?? 'omitted';
    // final String changePasswordUrl =
    //     'https://www.googleapis.com/identitytoolkit/v3/relyingparty/setAccountInfo?key=$API_KEY';
    final String idToken = (await currentUser.getIdToken()).token;
    final Map<String, dynamic> payload = {
      'email': idToken,
      'password': newPassword,
      'returnSecureToken': true,
    };

    /// Common error codes
    ///    `INVALID_ID_TOKEN`:The user's credential is no longer valid. The user must sign in again.
    ///    `WEAK_PASSWORD`: The password must be 6 characters long or more.
    try {
      // await http.post(
      //   changePasswordUrl,
      //   body: json.encode(payload),
      //   headers: {'Content-Type': 'application/json'},
      // );
    } catch (httpPostError) {
      switch (httpPostError) {
        case 'INVALID_ID_TOKEN':
          throw "http post error while changing the user password: $httpPostError";
          break;
        case 'WEAK_PASSWORD':
          throw "http post error while changing the user password: $httpPostError";
          break;
      }
    }
    await currentUser.reload();
  }
}

class FirebaseUserErrors {
  static final String wrongEmailORPassword =
      "There was a problem logging in. Check your email and password or create an account.";
  static final String wrongRecoverEmail =
      "Only humans are allowed to submit this form.";
  static final String registeredEmailIsAlreadyInUse =
      "There was a problem creating your account. Check that your email address is spelled correctly.";
}

/*
collection (userData) -> Doc(user ID) -> -> collection(about) -> user data
*/

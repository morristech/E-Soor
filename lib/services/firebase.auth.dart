import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:E_Soor/services/users.api.dart';
import 'package:flutter/services.dart';
import 'dart:async';

//users => userID => [user data]

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  //* User status/info
  bool _isUserLoggedin = false;
  String _userPassword;
  String _userEmailAddress;
  final String _usersCollectionData = "users";

  //* check weather the user has loggeed in or not
  //!needs passing to widgets improvment
  Future<bool> isUserAllradyLoggedIn() async =>
      await _firebaseAuth.currentUser() != null ? true : false;

  bool get isUserLoggeedIn => _isUserLoggedin;

  //* GET CURRENT USER
  Future<FirebaseUser> getCurrentUser() async {
    return (await _firebaseAuth.currentUser());
  }

  //* GET User ID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  //* Resister a New user
  /// Errors:
  ///   • `ERROR_WEAK_PASSWORD` - If the password is not strong enough.
  ///   • `ERROR_INVALID_EMAIL` - If the email address is malformed.
  ///   • `ERROR_EMAIL_ALREADY_IN_USE` - If the email is already in use by a different account.
  Future<String> registerNewUser(LoginData singinFormIncommingData) async {
    _userPassword = singinFormIncommingData.password;
    _userEmailAddress = singinFormIncommingData.name;
    //* checking if the text field has valied  Email and Password
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: _userEmailAddress,
        password: _userPassword,
      );
      await _createUserData(userEmail: _userEmailAddress);
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
          case "ERROR_WEAK_PASSWORD":
            return signUpError.message;
            break;
        }
      }
    }
  }

  //* Login
  /// Errors:
  ///   • `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
  ///   • `ERROR_WRONG_PASSWORD` - If the [password] is wrong.
  ///   • `ERROR_USER_NOT_FOUND` - If there is no user corresponding to the given [email] address, or if the user has been deleted.
  ///   • `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
  ///   • `ERROR_TOO_MANY_REQUESTS` - If there was too many attempts to sign in as this user.
  ///   • `ERROR_OPERATION_NOT_ALLOWED` - Indicates that Email & Password accounts are not enabled.
  Future<String> loginUser(LoginData singinFormIncommingData) async {
    _userPassword = singinFormIncommingData.password;
    _userEmailAddress = singinFormIncommingData.name;
    //* checking if the text field has valied  Email and Password
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
  /// Errors:
  ///   • `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
  ///   • `ERROR_USER_NOT_FOUND` - If there is no user corresponding to the given [email] address.
  Future<String> recoverPassword(String email) async {
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

  //* Adding user initail/Important data to the `about` section on Firebase
  Future<void> _createUserData({String userEmail}) async {
    DateTime creationTime = DateTime.now();
    try {
      String userID = (await _firebaseAuth.currentUser()).uid;
      var userDoc =
          _firestore.collection(_usersCollectionData).document(userID);
      await userDoc.setData(
        User(
          uid: userID,
          emailAddress: userEmail,
          creationTime: creationTime,
          lastInfoUpdate: creationTime,
        ).toJson(),
      );
    } catch (uploadUserInitialDataError) {
      throw uploadUserInitialDataError;
    }
  }

  //* checking if the user has verified his account
  Future<bool> isEmailVerified() async {
    FirebaseUser currentUser = await _firebaseAuth.currentUser();
    return currentUser.isEmailVerified;
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
collection (userData) -> Doc(user ID) -> user data
*/

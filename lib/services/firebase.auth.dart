import 'package:E_Soor/models/category_model.dart';
import 'package:E_Soor/ui/screens/login_signup_reset/emailLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/flutter_login.dart';
// import 'package:flutter_login/flutter_login.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestoreStore = Firestore.instance;
  final SingInValidator _singInValidator = SingInValidator();

  //* User status/info
  bool _isUserLoggedin = false;
  int _userId;
  String _userName;
  String _userPassword;
  String _userEmailAddress;

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
          email: _userEmailAddress, password: _userPassword);
      await _firestoreStore.collection('users').add({
        'user': _userEmailAddress,
        'pass': _userPassword,
      });
      _isUserLoggedin = true;
      //* Everything went will
      return null;
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        switch (signUpError.code) {
          case "ERROR_INVALID_EMAIL":
            return signUpError.message;
            break;
          case "ERROR_EMAIL_ALREADY_IN_USE":
            return signUpError.message;
            break;
          //! Will be implemented seperetly
          case "ERROR_WEAK_PASSWORD":
            return signUpError.message;
            break;
        }
      }
    }
  }

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
            return signInError.message;
            break;
          case "ERROR_WRONG_PASSWORD":
            return signInError.message;
            break;
          case "ERROR_INVALID_EMAIL":
            return signInError.message;
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

  Future<String> recoverPassword(String email) async {
    /// Errors:
    ///   • `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
    ///   • `ERROR_USER_NOT_FOUND` - If there is no user corresponding to the given [email] address.
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } catch (recoverPasswordError) {
      if (recoverPasswordError is PlatformException) {
        switch (recoverPasswordError.code) {
          case "ERROR_USER_NOT_FOUND":
            return recoverPasswordError.message;
            break;
          case "ERROR_INVALID_EMAIL":
            return recoverPasswordError.message;
            break;
        }
      }
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
      _isUserLoggedin = false;
    } catch (logOutError) {
      throw "Unexpected logout error: $logOutError";
    }
  }

  bool get isUserAlreadyLoggedin => _isUserLoggedin;

  String emailValidator(String userEmail) =>
      _singInValidator.emailValidator(userEmail);

  String passwordValidator(String userPassword) =>
      _singInValidator.passwordValidator(userPassword);

  bool get isUserValied => _singInValidator.isFormFieldHasValied;

  Future<String> addCategory(Category category) async {
    print(category);
    _userId = category.id;
    _userName = category.name;
    try {
      await _firestoreStore.collection('categories').add({
        'id': _userId,
        'categoryName': _userName,
      });
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }
}

class SingInValidator {
  final int minPasswordLength = 8;
  final int maxPasswordLength = 50;
  bool _isFormFieldValeid = false;

  String emailValidator(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    }
    _isFormFieldValeid = true;
    return null;
  }

  String passwordValidator(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    }
    if (value.length < minPasswordLength) {
      return "Password must be at least $minPasswordLength characters long";
    }
    if (value.length > maxPasswordLength) {
      return "Password must be less than $maxPasswordLength characters long";
    }
    _isFormFieldValeid = true;
    return null;
  }

  bool get isFormFieldHasValied => _isFormFieldValeid;
}

//* Adding new password validation structure
/*
 bool validateStructure(String value){
        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        RegExp regExp = new RegExp(pattern);
        return regExp.hasMatch(value);
  }
*/

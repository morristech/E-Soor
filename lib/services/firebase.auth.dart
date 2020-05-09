import 'package:E_Soor/models/category_model.dart';
import 'package:E_Soor/ui/screens/login_signup_reset/emailLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

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

  Future<String> registerUser(LoginData singinFormIncommingData) async {
    _userPassword = singinFormIncommingData.password;
    _userEmailAddress = singinFormIncommingData.name;
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: _userEmailAddress, password: _userPassword);
      await _firestoreStore.collection('users').add({
        'user': _userEmailAddress,
        'pass': _userPassword,
      });
    } catch (e) {
      print("Signup: $e");
      return null;
    }
    _isUserLoggedin = true;
    return null;
  }

  Future<String> loginUser(LoginData singinFormIncommingData) async {
    _userPassword = singinFormIncommingData.password;
    _userEmailAddress = singinFormIncommingData.name;
    if (_singInValidator.isFormFieldHasValied) {
      try {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: _userEmailAddress,
          password: _userPassword,
        );
      } catch (e) {
        print("---->>> Signin: $e");
      }
    } else {
      print("||| Sorry User is Not Valied, Please Sign Up first |||");
    }
    _isUserLoggedin = true;
    return null;
  }

  Future<String> recoverPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (err) {
      print(err);
      return null;
    }
    _isUserLoggedin = false;
    return null;
  }

  Future<void> logOut(BuildContext context) async {
    try {
      await _firebaseAuth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } catch (e) {
      throw "Unexpected logout error: $e";
    }
    _isUserLoggedin = false;
    return null;
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

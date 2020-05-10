import 'package:E_Soor/main.dart';
import 'package:E_Soor/services/firebase.auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 1800);
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  _enterMainScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: 'allAssets/images/logo.png',
      onLogin: _firebaseAuthService.loginUser,
      onSignup: _firebaseAuthService.registerNewUser,
      onRecoverPassword: _firebaseAuthService.recoverPassword,
      emailValidator: (_) {
        return;
      },
      passwordValidator: (_) {
        return;
      },
      onSubmitAnimationCompleted:
          _firebaseAuthService.isUserValid ? _enterMainScreen(context) : () {},
      theme: LoginTheme(
        errorColor: Colors.green,
        primaryColor: Color.fromRGBO(35, 35, 35, 100),
        accentColor: Colors.white,
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.green,
          backgroundColor: Colors.grey,
        ),
        textFieldStyle: TextStyle(
          color: Colors.white,
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.black87,
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            backgroundColor: Colors.red.withOpacity(.7),
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(100),
          ),
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

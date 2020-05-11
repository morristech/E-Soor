import 'package:E_Soor/main.dart';
import 'package:E_Soor/services/firebase.auth.dart';
import 'package:E_Soor/services/singIn.validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 1800);
  final SingInValidator _singInValidator = SingInValidator();

  @override
  Widget build(BuildContext context) {
    final _firebaseAuthService = Provider.of<FirebaseAuthService>(context);
    return FlutterLogin(
      logo: 'allAssets/images/logo.png',
      onLogin: _firebaseAuthService.loginUser,
      onSignup: _firebaseAuthService.registerNewUser,
      onRecoverPassword: _firebaseAuthService.recoverPassword,
      emailValidator:
          _singInValidator.emailValidator, //_singInValidator.emailValidator,
      passwordValidator: _singInValidator.passwordValidator,
      onSubmitAnimationCompleted: () {
        //! needs to be change to a 'Named Route'
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHomePage()));
      },
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

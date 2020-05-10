import 'package:E_Soor/services/firebase.auth.dart';
import 'package:E_Soor/ui/screens/login_signup_reset/emailLogin.dart';
import 'package:E_Soor/ui/screens/social/profile.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatelessWidget {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SplashScreen(
        photoSize: 200,
        backgroundColor: Color.fromRGBO(35, 35, 35, 100),
        seconds: 5,
        navigateAfterSeconds: _firebaseAuthService.isUserAlreadyLoggedin
            ? MyHomePage()
            : LoginPage(),
        image: Image.asset("allAssets/images/logo.png"),
        loaderColor: Colors.white,
        loadingText: Text(
          "Loading",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

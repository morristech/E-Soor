import 'package:E_Soor/models/auth.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatelessWidget {
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SplashScreen(
        photoSize: 200,
        backgroundColor: Color.fromRGBO(35, 35, 35, 100),
        seconds: 5,
        navigateAfterSeconds: auth.isLoggedIn(),
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

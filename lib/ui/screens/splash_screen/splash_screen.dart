import 'package:E_Soor/services/firebase.auth.dart';
import 'package:E_Soor/ui/screens/login_signup_reset/emailLogin.dart';
import 'package:E_Soor/ui/screens/social/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userAuthProvider = Provider.of<FirebaseAuthService>(context);
    return SafeArea(
      child: SplashScreen(
        photoSize: 200,
        backgroundColor: Color.fromRGBO(35, 35, 35, 100),
        seconds: 2,
        navigateAfterSeconds:
            _userAuthProvider.isUserLoggeedIn ? ProfilePage() : LoginPage(),
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

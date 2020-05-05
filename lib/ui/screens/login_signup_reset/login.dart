import 'package:E_Soor/ui/screens/login_signup_reset/emailLogin.dart';
import 'package:E_Soor/ui/screens/login_signup_reset/fbLogin.dart';
import 'package:E_Soor/ui/screens/login_signup_reset/googleLogin.dart';
import 'package:E_Soor/ui/widgets/carousel_screens.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return CarouselScreens(
      list: [FaceBookLoginPage(), LoginPage(), GoogleLoginPage()],
    );
  }
}

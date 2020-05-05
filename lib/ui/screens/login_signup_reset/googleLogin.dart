import 'package:flutter/material.dart';

class GoogleLoginPage extends StatefulWidget {
  GoogleLoginPage({Key key}) : super(key: key);

  @override
  _GoogleLoginPageState createState() => _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<GoogleLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Google Login"),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FaceBookLoginPage extends StatefulWidget {
  FaceBookLoginPage({Key key}) : super(key: key);

  @override
  _FaceBookLoginPageState createState() => _FaceBookLoginPageState();
}

class _FaceBookLoginPageState extends State<FaceBookLoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Image.asset("allAssets/images/fb.png"),
      ),
    );
  }
}

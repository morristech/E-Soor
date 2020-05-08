import 'package:flutter/material.dart';
import 'package:E_Soor/main.dart';

class ActionsFAB extends StatefulWidget {
  @override
  _ActionsFABState createState() => _ActionsFABState();
}

class _ActionsFABState extends State<ActionsFAB> {
  @override
  Widget build(BuildContext context) {
    return actionsFabBuild();
  }

  Widget actionsFabBuild() {
    return FloatingActionButton(
      backgroundColor: themeData(context).accentColor,
      child: Icon(Icons.more_vert),
      onPressed: () {
        //TODO: Add Default Category Item
      },
    );
  }
}

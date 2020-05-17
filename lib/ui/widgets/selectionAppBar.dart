import 'package:flutter/material.dart';

AppBar selectionAppBar() {
  return AppBar(
    centerTitle: true,
    title: Text("$num category is selected"),
    actions: <Widget>[
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.edit),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.remove),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.report_problem),
      ),
    ],
  );
}

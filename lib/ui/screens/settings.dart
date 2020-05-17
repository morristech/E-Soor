import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 1),
      body: ListView(children: <Widget>[
        Column(children: <Widget>[
          Container(
            child: ListTile(
              title: Text(
                "Account Settings",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          ///Username

          Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey[600], width: 0.5)),
                color: Colors.grey[900],
              ),
              child: ListTile(
                title: Text("Username"),
                onTap: () {
                },
              )),

          //Phone Number

          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey[600], width: 0.5)),
              color: Colors.grey[900],
            ),
            child: ListTile(
              title: Text("Phone "),
              onTap: () {
              },
            ),
          ),

          ///E-mail address

          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey[600], width: 0.5)),
              color: Colors.grey[900],
            ),
            child: ListTile(
              title: Text("Email address"),
              onTap: () {
              },
            ),
          ),

          ///Password

          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey[600], width: 0.5)),
              color: Colors.grey[900],
            ),
            child: ListTile(
              title: Text("Password"),
              onTap: () {
              },
            ),
          ),

          ///Deactivate Account

          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey[600], width: 0.5)),
              color: Colors.grey[900],
            ),
            child: ListTile(
              title: Text("Deactivate your acccount"),
              onTap: () {
              },
            ),
          ),

          ///Choose prefered language
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey[600], width: 0.5)),
              color: Colors.grey[900],
            ),
            child: ListTile(
              title: Text("Language"),
              onTap: () {
              },
            ),
          )
        ])
      ]),
    );
  }
}


/*An `Alert Dialog` that warns user before Deactivating the account
void alertDialog(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text(
      'Deactivating Account',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    content: Text(
      'Are you sure that you want to deactivate your account?',
    ),
    actions: [
      FlatButton(
        child: Text(
          'Yes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          /// `Write a function that deactivates the user account`
        },
      ),
      FlatButton(
        child: Text(
          'No',
          style: TextStyle(),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}

/// A class that displays a `bottomSheet` that has the 2 `radioButtons` to choose the prefered language
class BottomSheet extends StatefulWidget {
  BottomSheet({@required this.selectedRadio, @required this.valueChanged});
  final int selectedRadio;
  final ValueChanged valueChanged;
  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  int _selectedRadio;
  @override
  void initState() {
    _selectedRadio = widget.selectedRadio;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        child: Column(
          children: <Widget>[
            RadioListTile(
              value: 1,
              groupValue: _selectedRadio,
              title: Text("English"),
              onChanged: (int val) {
                setState(() {
                  _selectedRadio = val;
                  widget.valueChanged(val);
                });
              },
            ),
            RadioListTile(
              value: 2,
              groupValue: _selectedRadio,
              title: Text("العربيه"),
              onChanged: (int val) {
                setState(() {
                  _selectedRadio = val;
                  widget.valueChanged(val);
                });
              },
            )
          ],
        ));
  }
}*/

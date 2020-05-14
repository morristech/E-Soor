import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _selectedRadio;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          /// This is all the settings before deactivating

          ///settings expansion panel list
          /*1*/ CustomExpansionPanelList(),

          /// change the language
          /*2*/ Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              color: Colors.grey[700],
            ),
            child: ListTile(
              title: Text('Deactivate Account'),
              onTap: () {
                /// call the function which displays the `Alert Dialog` to make sure that
                /// the user wants to deactivate account
                ///
                alertDialog(context);
              },
            ),
          ),

          /// Deactivate account
          /*3*/ Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              color: Colors.grey[700],
            ),
            child: ListTile(
              title: Text('Deactivate Account'),

              /// A function that deactivates the users account

              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

/// This Class was built to store the `ExpansionPanel Data` within it

class Item {
  Item({
    this.headerValue,
    this.isExpanded = false,
    this.bodyValue,
  });

  Widget headerValue;
  Widget bodyValue;
  bool isExpanded;
}

/// This is a `List of ExpansionPanels` wrapped in `Item` class which stores the data of the panels

List<Item> items = [
  /// This is for changing `UserName`

  Item(
    headerValue: ListTile(
      title: Text("Username"),
    ),
    bodyValue: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "Edit your username",
            ),
          ),
          Buttons(),
        ],
      ),
    ),
  ),

  /// This is for changing `Email`

  Item(
    headerValue: ListTile(
      title: Text("E-mail address"),
    ),
    bodyValue: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "Edit your E-mail",
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          Buttons(),
        ],
      ),
    ),
  ),

  /// This is for changing `Password`

  Item(
    headerValue: ListTile(
      title: Text("Password"),
    ),
    bodyValue: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "Edit your password",
            ),
            keyboardType: TextInputType.visiblePassword,
          ),
          Buttons(),
        ],
      ),
    ),
  ),

  /// This is for changing `Phone`

  Item(
    headerValue: ListTile(
      title: Text("Phone"),
    ),
    bodyValue: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "Edit your phone number",
            ),
          ),
          Buttons(),
        ],
      ),
    ),
  ),
];

class CustomExpansionPanelList extends StatefulWidget {
  @override
  _CustomExpansionPanelListState createState() =>
      _CustomExpansionPanelListState();
}

class _CustomExpansionPanelListState extends State<CustomExpansionPanelList> {
  @override
  Widget build(BuildContext context) {
    return _buildPanel();
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(
          () {
            items[index].isExpanded = !isExpanded;
          },
        );
      },
      children: items.map<ExpansionPanel>(
        (Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return item.headerValue;
            },
            body: item.bodyValue,
            isExpanded: item.isExpanded,
          );
        },
      ).toList(),
    );
  }
}

/// This is a class with a `ButtonBar` and I made it because it is repeated 4 times

class Buttons extends StatelessWidget {
  /// This is the function that saves the changes and can be accessed when calling the class
  Buttons({this.saveChanges});
  final VoidCallback saveChanges;
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          onPressed: () => saveChanges(),
          child: Text("save"),
        ),
        FlatButton(
          child: Text("cancel"),
          onPressed: () {
            Item(isExpanded: false);
          },
        ),
      ],
    );
  }
}

/// A class that displays a `bottomSheet` that has the `2 radioButtons` to choose the prefered language
///
class BottomSheet extends StatefulWidget {
  BottomSheet({
    @required this.selectedRadio,
    @required this.valueChanged,
  });
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      height: 200,
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
            title: Text("العربية"),
            onChanged: (int val) {
              setState(() {
                _selectedRadio = val;
                widget.valueChanged(val);
              });
            },
          ),
        ],
      ),
    );
  }
}

/// An `Alert Dialog` that warns user before Deactivating the account
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

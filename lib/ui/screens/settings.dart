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

          ///deactivate account
          /*2*/ Container(
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                color: Colors.grey[700]),
            child: ListTile(
              title: Text('Deactivate Account'),
              onTap: () {/* a function that deactivates the users account */},
            ),
          ),

          /// change the language
          /*3*/ Container(
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                color: Colors.grey[700]),
            child: ListTile(
              title: Text("Language"),
              onTap: () {
                /// calling the CLASS that displays the `BottomSheet` to choose the language settings.
                 showModalBottomSheet(
                   context: context, 
                   builder: (BuildContext context){
                  return BottomSheet(
                   selectedRadio: _selectedRadio,
                    valueChanged: (val){
                    _selectedRadio = val;
                     },
                    );
                  }
                ); 
              },         
            ),
          )
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

///this is a class with a `Column of 2 buttons` and I made it because it is repeated 4 times

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
            onPressed: () {/* a function that saves all the changes occured*/},
            child: Text("save")),
        FlatButton(
            child: Text("cancel"),
            onPressed: () {/*a function that cancel all the changes occured*/})
      ],
    );
  }
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
            groupValue:_selectedRadio,
            title: Text("English"),
            onChanged: (int val){
              setState(() {
                _selectedRadio = val;
                widget.valueChanged(val);
              });
            },
          ),

          RadioListTile(
            value: 2, 
            groupValue:_selectedRadio,
            title: Text("العربيه"),
            onChanged: (int val){
              setState(() {
                _selectedRadio = val;
                widget.valueChanged(val);
              });
            },
          )
        ],
      )
    );
  }
}



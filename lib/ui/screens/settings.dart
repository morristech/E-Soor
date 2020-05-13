import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          /// This is all the settings before deactivating

          CustomExpansionPanelList(),

          /// This is the deactivating button

          Container(
            decoration: BoxDecoration(color: Colors.grey[700]),
            child: ListTile(
              title: Text('Deactivate Account'),

              /// This is the function for `Deactivating User Account`

              onTap: () {},
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

///this is a class with a column of buttons and i made it because it is repeated 4 times

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        FlatButton(
          onPressed: () {/* a function that saves all the changes occured*/},
          child: Text("save"),
        ),
        FlatButton(
          child: Text("cancel"),
          onPressed: () {/*a function that cancel all the changes occured*/},
        )
      ],
    );
  }
}

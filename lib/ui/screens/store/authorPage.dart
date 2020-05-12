import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AuthorPage extends StatefulWidget {
  @override
  _AuthorPageState createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: ExactAssetImage("allAssets/images/omar.jpg"),
                  radius: 40,
                ),
                Column(
                  children: <Widget>[
                    Text("Author Name"),
                    Text("Written Books number"),
                    // TODO: This is gonna be a RatingBarIndicator
                    Text("Average Rate"),
                  ],
                ),
              ],
            ),
            Divider(),
            CustomExpansionPanelList(),
          ],
        ),
      ),
    );
  }
}

//! This is separating line between the below custom widget and the author page

// stores ExpansionPanel state information
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

List<Item> items = [
  Item(
    headerValue: ListTile(
      leading: Icon(Icons.info_outline),
      title: Text("Bio"),
      trailing: Icon(Icons.expand_more),
    ),
    bodyValue: Text("blablablablabla"),
  ),
  Item(
    headerValue: ListTile(
      leading: Icon(MdiIcons.bookshelf),
      title: Text("Books"),
      trailing: Icon(Icons.expand_more),
    ),
    bodyValue: Text("blablablablabla"),
  ),
  Item(
    headerValue: ListTile(
      leading: Icon(MdiIcons.commentQuoteOutline),
      title: Text("Quotes"),
      trailing: Icon(Icons.expand_more),
    ),
    bodyValue: Text("blablablablabla"),
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
      children: items.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return item.headerValue;
          },
          body: item.bodyValue,
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

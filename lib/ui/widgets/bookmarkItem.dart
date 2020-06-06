import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BookmarkItem extends StatefulWidget {
  final String keyString;
  final data;
  BookmarkItem({this.keyString, this.data});
  @override
  _BookmarkItemState createState() => _BookmarkItemState();
}

class _BookmarkItemState extends State<BookmarkItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (dir) {
        print("Dismissed");
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          /// `Book Image`

          Expanded(
            child: Image.network(
              "https://rethinkpress.com/wp-content/uploads/2016/04/9781781331880.jpg",
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// `Book Name`

              AutoSizeText(
                "Book Name",
                softWrap: true,
                wrapWords: true,
                maxLines: 2,
                maxFontSize: 30,
                minFontSize: 24,
                overflow: TextOverflow.ellipsis,
              ),

              /// `Author Name`

              FlatButton(
                onPressed: () {},
                child: AutoSizeText(
                  "Author Name",
                  maxLines: 2,
                  maxFontSize: 18,
                  minFontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {},
                    child: Text("Category"),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text("SubCategory"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  /// `Rating`

                  Row(
                    children: <Widget>[
                      Text("4.6"),
                      Icon(
                        Icons.star,
                        size: 20.0,
                      ),
                    ],
                  ),

                  /// `Price`

                  Text("\$60"),
                ],
              ),
            ],
          ),
        ],
      ),
      key: Key(widget.keyString),
    );
  }

  void dismissAlert(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Delete Book Item"),
      content: Text("Are you sure you want to delete book item?"),
      actions: <Widget>[
        FlatButton(
          child: Text("Yes"),
          onPressed: () {},
        ),
        FlatButton(
          child: Text("No"),
          onPressed: () {
            /*Navigator.pop(context);*/
          },
        )
      ],
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}

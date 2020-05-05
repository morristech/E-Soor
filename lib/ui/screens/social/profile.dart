import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'editProfile.dart';

class Profile extends StatefulWidget {
  final String name;
  final String bio;
  Profile({Key key, this.name, this.bio}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width * 1,
            padding: EdgeInsets.all(0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('allAssets/images/mmm.jpg'),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 45,
                          horizontal: 0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 40,
                          horizontal: 15,
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                height: 30,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(color: Colors.black),
                                child: Center(
                                  child: AutoSizeText(
                                    "${widget.name}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            FlatButton(
                              color: Colors.blue[700],
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width / 5,
                                vertical: 9,
                              ),
                              splashColor: Colors.grey[800],
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditPage(
                                      widget.name,
                                      widget.bio,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              children: <Widget>[
                Card(
                  color: Colors.grey[800],
                  child: Container(
                    height: 250,
                    width: 150,
                    child: Card(
                      margin: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 3.5,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(
                            "https://images-na.ssl-images-amazon.com/images/I/51m3dGvkshL.jpg"),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.grey[800],
                  child: Container(
                    height: 250,
                    width: 150,
                    child: Card(
                      margin: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 3.5,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(
                            "https://pbs.twimg.com/media/DisKV0YXcAANjtL.jpg"),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.grey[800],
                  child: Container(
                    height: 250,
                    width: 150,
                    child: Card(
                      margin: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 3.5,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(
                            "https://covers.openlibrary.org/b/id/9280427-L.jpg"),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.grey[800],
                  child: Container(
                    height: 250,
                    width: 150,
                    child: Card(
                      margin: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 3.5,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(
                            "https://images-na.ssl-images-amazon.com/images/I/61jlCHYp3ZL.jpg"),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.black,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 250,
                    width: 150,
                    child: Card(
                      color: Colors.blue[800],
                      margin: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 3.5,
                      ),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.library_books,
                                size: 35,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              'Add Book Highlight',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              scrollDirection: Axis.horizontal,
              addAutomaticKeepAlives: false,
              reverse: true,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[900],
            ),
            width: MediaQuery.of(context).size.width,
            height: 250,
          ),
        ],
      ),
    );
  }
}

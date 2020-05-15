import 'package:E_Soor/ui/screens/store/authorPage.dart';
import 'package:E_Soor/ui/widgets/AppSearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BookPage extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<BookPage> {
  int price = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: AppSearch());
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Chip(
                  backgroundColor: Colors.blueGrey,
                  label: Text("Report"),
                  avatar: Icon(Icons.flag),
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () {
            return;
          },
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[BookInfo(), BookFeedBack(), BookRating()],
          )),
    );
  }
}

/// THIS IS THE CLASS THAT HOLDS THE `book Info`
class BookInfo extends StatefulWidget {
  @override
  _BookInfoState createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  ///Essential `variables`
  int price = 60;
  String authorName;
  String bookName;
  int rating;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 300,
      width: MediaQuery.of(context).size.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ///The column Which holds the `Book INFO`
          Padding(
            padding: const EdgeInsets.all(0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ///This is the `BOOK NAME`
                  AutoSizeText(
                      "David copper field",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      maxFontSize: 30,
                    ),
                  
                  ////This is the `Author Name`
                  AutoSizeText(
                      "by:-Charles dickens",
                      maxLines: 2,
                      maxFontSize: 30,
                    ),
                  

                  ///This is the `Rating of the book`
                  RatingBarIndicator(
                    rating: 4,
                    itemSize: 30,
                    unratedColor: Colors.white,
                    itemCount: 5,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),

                  ///This is the `CATEGORY BUTTON`
                  RaisedButton(
                    elevation: 0.0,
                    child: Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {},
                  ),

                  ///This is the `PRICE`
                  Text("price:-$price")
                ],
              ),
            ),
          ),

          ///The `Book Image`
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                width: MediaQuery.of(context).size.width*0.5,
                height: 250,
                decoration: BoxDecoration(color: Colors.green)),
          )
        ],
      ),
    );
  }
}

////THIS IS A CLASS WHICH `BOOK RATING BAR`
class BookRating extends StatefulWidget {
  @override
  _BookRatingState createState() => _BookRatingState();
}

class _BookRatingState extends State<BookRating> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        children: <Widget>[
          Text("Rate The Book"),
          Padding(
            padding: const EdgeInsets.all(20),
            child: RatingBar(
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
        ],
      ),
    );
  }
}

///THIS IS THE CLASS THAT HOLDS THE `TEXT FIELD FOR WRITING BOOK FEEDBACK`
class BookFeedBack extends StatefulWidget {
  @override
  _BookFeedBackState createState() => _BookFeedBackState();
}

class _BookFeedBackState extends State<BookFeedBack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width * 1,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: TextField(
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              suffixIcon: IconButton(icon: Icon(Icons.send), onPressed: (){}),
                labelText: "Write your feedback about the book")),
      ),
    );
  }
}

/// THIS IS THE CLASS THAT HOLDS `THE EXPANSIION PANNEL LIST OF BOOK FEEDBACKS FROM DIFFERENT USERES`
class PeopelBookFeedBack extends StatefulWidget {
  @override
  _PeopelBookFeedBackState createState() => _PeopelBookFeedBackState();
}

class _PeopelBookFeedBackState extends State<PeopelBookFeedBack> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

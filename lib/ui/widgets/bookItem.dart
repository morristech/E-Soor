import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookItem extends StatelessWidget {
  //final Function onTap;
 // BookItem(this.onTap);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: onTap,
      child: AspectRatio(
        aspectRatio: 0.75,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// `Book Image`

                      Expanded(
                        child: Container(
                          child: Image.network(
                            "https://rethinkpress.com/wp-content/uploads/2016/04/9781781331880.jpg",
                          ),
                        ),
                      ),

                      /// `Book Name`

                      AutoSizeText(
                        "Book Name",
                        softWrap: true,
                        wrapWords: true,
                        maxLines: 2,
                        maxFontSize: 16,
                        minFontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),

                      /// `Author Name`

                      AutoSizeText(
                        "Author Name",
                        maxLines: 2,
                        maxFontSize: 16,
                        minFontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  /// `Rating`

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RatingBarIndicator(
                        rating: 4.5,
                        direction: Axis.vertical,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                      Text("\$60"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

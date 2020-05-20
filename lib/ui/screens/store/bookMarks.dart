import 'package:flutter/material.dart';
import 'package:E_Soor/ui/widgets/bookItem.dart';


class bookMarks extends StatefulWidget {
  @override
  _bookMarksState createState() => _bookMarksState();
}

class _bookMarksState extends State<bookMarks> {
  /// the List tht hols the Saved Book Items
  /*List <Widget> items = [
    BookItem((){}),
  ];*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Book Marks",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300
          )
        )
      ),

      body: ListView.builder(
        itemCount: 5,
        ///gridDelegate:
            ///new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index){
            return Dismissible(
              child: BookItem((){}),
              key: UniqueKey(),
              onDismissed: (direction){
                /*setState(() {
                  items.removeAt(index);
                });*/
              },
          );
        },
      )
    );
  }
}




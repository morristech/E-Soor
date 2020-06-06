import 'package:E_Soor/ui/widgets/bookmarkItem.dart';
import 'package:flutter/material.dart';

class BookMarks extends StatefulWidget {
  @override
  _BookMarksState createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Book Marks",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Margin(
            margin: const EdgeInsets.all(20.0),
            child: BookmarkItem(keyString: "$index"),
          );
        },
      ),
    );
  }
}

class Margin extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final Widget child;
  final Key key;
  const Margin({
    this.key,
    @required this.margin,
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      margin: margin,
      child: child,
    );
  }
}

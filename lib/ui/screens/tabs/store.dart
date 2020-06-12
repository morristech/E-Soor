import 'package:E_Soor/models/category_model.dart';
import 'package:E_Soor/ui/screens/store/book_page.dart';
import 'package:E_Soor/ui/screens/store/categoryScreen.dart';
import 'package:E_Soor/ui/screens/store/checkout.dart';
import 'package:E_Soor/ui/widgets/storeContent.dart';
import 'package:flutter/material.dart';
import 'package:sliding_card/components/expandablecard.dart';
import 'package:sliding_card/components/expandablecardpage.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    final int price = 75;
    int total = 2 * price;
    final List<Category> categories = List<Category>.generate(
      5,
      (i) {
        return Category(name: "Category $i");
      },
    );

    return SafeArea(
      child: RefreshIndicator(
        displacement: 10,
        onRefresh: () {
          return;
        },
        child: ExpandableCardPage(
          expandableCard: ExpandableCard(
            backgroundColor: Theme.of(context).primaryColor,
            hasRoundedCorners: true,
            minHeight: 130,
            hasShadow: true,
            children: <Widget>[
              ListTile(
                title: Text(
                  "Your Order",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                ),
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text(
                  "David Copperfield",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  "By. Charles Dickens",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "\$" + "$price",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text(
                  "Great Expectations",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  "By. Charles Dickens",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "\$" + "$price",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Total:",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                trailing: Text(
                  "\$" + "$total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: RaisedButton(
                    child: Text("Order"),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckOutPage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          page: storeContent(
            context,
            openBookPage,
            openCategoryPage,
            categories,
          ),
        ),
      ),
    );
  }

  void openBookPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BookPage()));
  }

  void openCategoryPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CategoryScreen()));
  }
}

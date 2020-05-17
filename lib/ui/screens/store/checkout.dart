import 'package:flutter/material.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  int totalPrice = 84756;
  int booksAmmount = 46375;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        elevation: 1,
        title: Text(
          "Credit Card Payment",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.7,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
              ),
              height: 300,
              width: MediaQuery.of(context).size.width * 1,
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Total Price:",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              'Books Ammount:',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "$totalPrice LE",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              '$booksAmmount',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          child: RaisedButton(
                            onPressed: () {},
                            elevation: 0,
                            child: Text(
                              "Confirm Order",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

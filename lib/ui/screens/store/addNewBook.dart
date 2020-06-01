import 'package:flutter/material.dart';

class Item {
  const Item(this.name);
  final String name;
}

class AddNewBookScreen extends StatefulWidget {
  @override
  _AddNewBookScreenState createState() => _AddNewBookScreenState();
}

class _AddNewBookScreenState extends State<AddNewBookScreen> {
  Item selectedChoice;
  List<Item> names = <Item>[
    Item("Sci Fiction"),
    Item("Adventure"),
    Item("Horror"),
    Item("Manga"),
    Item("Comics"),
    Item("Bla1"),
    Item("Bla2"),
    Item("Bla3"),
  ];
  TextEditingController titleController;
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final snackBar = SnackBar(
      content: Text(
        "Added successfully",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      backgroundColor: Colors.green,
    );
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {
              globalKey.currentState.showSnackBar(snackBar);
              // TODO: Add FireStore functionality
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Add New Book"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //! TODO:- To be implemented
              /// `Book Pic`

              CircleAvatar(
                radius: width * 0.25,
              ),

              /// `Book Name`

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 15.0,
                    ),
                    child: Text(
                      "Book name :-",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      controller: titleController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: "Ex :- David Copperfield",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {
                          titleController.text = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              /// `Author Name`

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 15.0,
                    ),
                    child: Text(
                      "Author name :-",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: "Ex :- Charles Dickens",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              /// `Enter Price`

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 15.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Enter price :-",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Ex :- 60\$",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        onFieldSubmitted: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// `Select Category`

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Select Category :-",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  DropdownButton<Item>(
                    hint: Text("Choose.."),
                    value: selectedChoice,
                    items: names.map((Item item) {
                      return DropdownMenuItem<Item>(
                        value: item,
                        child: Text(item.name),
                      );
                    }).toList(),
                    onChanged: (Item value) {
                      setState(() {
                        selectedChoice = value;
                      });
                    },
                  ),
                ],
              ),

              /// `Select SubCategory`

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Select SubCategory :-",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  DropdownButton<Item>(
                    hint: Text("Choose.."),
                    value: selectedChoice,
                    items: names.map((Item item) {
                      return DropdownMenuItem<Item>(
                        value: item,
                        child: Text(item.name),
                      );
                    }).toList(),
                    onChanged: (Item value) {
                      setState(() {
                        selectedChoice = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

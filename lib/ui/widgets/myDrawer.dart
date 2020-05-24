import 'package:E_Soor/services/firebase.auth.dart';
import 'package:E_Soor/ui/screens/login_signup_reset/emailLogin.dart';
import 'package:E_Soor/ui/screens/other/about_us.dart';
import 'package:E_Soor/ui/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:E_Soor/ui/screens/store/bookMarks.dart';

class MyDrawer extends StatelessWidget {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    void goToSettings() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Settings(),
        ),
      );
    }

    void goToAboutUs() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AboutUs(),
        ),
      );
    }

    return Container(
      color: ThemeData.dark().primaryColor,
      height: double.infinity,
      width: 300.0,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 0.22 * screenHeight,
                width: 0.22 * screenHeight,
                child: Card(
                    elevation: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.network(
                              'https://placekitten.com/200/200',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            "Account Name",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "@meshmeshCat123",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text("Book Marks"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookMarks()
                  ));
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About us"),
                onTap: goToAboutUs,
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: goToSettings,
              ),
              ListTile(
                leading: Icon(Icons.backspace),
                title: Text("Log out"),
                onTap: () {
                  _firebaseAuthService.logOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

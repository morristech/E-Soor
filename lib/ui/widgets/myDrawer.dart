import 'package:E_Soor/models/CatMode.dart';
import 'package:E_Soor/services/firebase.auth.dart';
import 'package:E_Soor/ui/screens/login_signup_reset/emailLogin.dart';
import 'package:E_Soor/ui/screens/other/about_us.dart';
import 'package:E_Soor/ui/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:E_Soor/ui/screens/store/bookMarks.dart';
import 'package:http/http.dart' as http;

class MyDrawer extends StatelessWidget {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  // Future<List<Cat>> _getCatPic() async {
  //   try {
  //     final request = await http.get(
  //         "https://api.thecatapi.com/v1/images/search?limit=1&format=json",
  //         headers: {
  //           'x-api-key': "dc480b93-fbae-418c-8884-c7906a7a031a",
  //         });
  //     if (request.statusCode == 200) {
  //       return catFromJson(request.body);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
                                "https://cdn2.thecatapi.com/images/2a1.jpg"),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => bookMarks()));
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

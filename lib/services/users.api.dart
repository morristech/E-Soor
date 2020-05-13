import 'dart:convert' as convert;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class User {
  final String userID;
  final String userBio;
  final String userName;
  final String userEmailAddress;
  final String userProfilePicture;

  User({
    this.userID,
    @required this.userEmailAddress,
    this.userName,
    this.userBio,
    this.userProfilePicture,
  });

  // formatting for upload to Firbase when creating the new User
  Map<String, dynamic> toJson() => {
        'ID': userID,
        'Bio': userBio,
        'userName': userName,
        'E-mail': userEmailAddress,
        'profile picture': userProfilePicture,
      };

  // creating a User object from a firebase snapshot
  User.fromSnapshot(DocumentSnapshot snapshot)
      : userID = snapshot['ID'],
        userBio = snapshot['Bio'],
        userName = snapshot['userName'],
        userEmailAddress = snapshot['E-mail'],
        userProfilePicture = snapshot['profile picture'];
}

// getUsers() async {
//   List<User> users = [];
//   //var req = await http.get("http://my-json-server.typicode.com/OmarYehiaDev/E-Soor/db");
//   var headers = await http
//       .get("https://api.jsonbin.io/b/5e58fd4b1534d9052ce38751", headers: {
//     'Content-Type': 'application/json',
//   });
//   if (headers.statusCode == 200) {
//     print(headers.statusCode);
//     String jsonString = headers.body.toString();
//     print(jsonString);
//     final decodedUsers = convert.jsonDecode(jsonString);
//     decodedUsers.forEach((v) {
//       users.add(User.fromJson(v));
//     });
//     print(users);
//     users.forEach((user) {
//       return user;
//     });
//   } else {
//     print(headers.statusCode);
//   }
// }

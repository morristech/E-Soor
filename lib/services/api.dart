import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Old_User {
  final int id;
  final String name;
  final String password;
  final String profileImage;
  final String username;
  Old_User({
    @required this.name,
    @required this.password,
    this.id,
    this.profileImage,
    this.username,
  });

  factory Old_User.fromJson(Map<String, dynamic> json) {
    return Old_User(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      profileImage: json['profileImage'] as String,
    );
  }

  factory Old_User.toJson(dynamic data) {
    return Old_User(
      id: data['id'] as int,
      name: data['name'] as String,
      username: data['username'] as String,
      password: data['password'] as String,
      profileImage: data['profileImage'] as String,
    );
  }
}

getUsers() async {
  List<Old_User> users = [];
  //var req = await http.get("http://my-json-server.typicode.com/OmarYehiaDev/E-Soor/db");
  var headers = await http
      .get("https://api.jsonbin.io/b/5e58fd4b1534d9052ce38751", headers: {
    'Content-Type': 'application/json',
  });
  if (headers.statusCode == 200) {
    print(headers.statusCode);
    String jsonString = headers.body.toString();
    print(jsonString);
    final decodedUsers = convert.jsonDecode(jsonString);
    decodedUsers.forEach((v) {
      users.add(Old_User.fromJson(v));
    });
    print(users);
    users.forEach((user) {
      return user;
    });
  } else {
    print(headers.statusCode);
  }
}

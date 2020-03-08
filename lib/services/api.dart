import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class User {
  final String name;
  final String password;
  final Image profileImage;
  final String username;
  User({
    @required this.name,
    @required this.password, 
    this.profileImage,
    this.username, 
  });

  factory User.fromJson(Map<String,dynamic> json) {
    return User(
      name: json['name'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      profileImage: json['profileImage'] as Image,
    );
  }

  factory User.toJson(Map<String,dynamic> data) {
    return User(
      name: data['name'] as String,
      username: data['username'] as String,
      password: data['password'] as String,
      profileImage: data['profileImage'] as Image,
    );
  }

  
}


getUsers () async {
  List<User> users = [];
	//var req = await http.get("http://my-json-server.typicode.com/OmarYehiaDev/E-Soor/db");
	var headers = await http.get("https://api.jsonbin.io/b/5e58fd4b1534d9052ce38751", headers: {
		'Content-Type': 'application/json',
	});
  if (headers.statusCode == 200) {
      print(headers.statusCode);
      String jsonString = headers.body.toString();
      print(jsonString);
	    final decodedUsers = convert.jsonDecode(jsonString);
      decodedUsers.forEach((v){
        users.add(User.fromJson(v));
      });
      print(users);
	    users.forEach((user) {
		    return user;
	    });
    } else {
      print(headers.statusCode);
    }
  
}

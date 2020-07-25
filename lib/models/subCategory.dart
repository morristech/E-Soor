import 'package:E_Soor/models/BookModel.dart';

class SubCategory {
  String id;
  String name;
  List<Book> books;

  SubCategory({
    this.id,
    this.name,
    this.books,
  });

  String get _id => id;
  String get _name => name;
  List get _books => books;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['name'] = _name;
    map['books'] = _books;
    if (_id != null) {
      map['id'] = _id;
    }

    return map;
  }

  SubCategory.fromObject(dynamic object) {
    this.id = object['id'];
    this.name = object['name'];
    this.books = object['books'];
  }
}

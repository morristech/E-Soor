import 'subCategory.dart';

class Category {
  String id;
  String name;
  List<SubCategory> subCategories;

  Category({
    this.id,
    this.name,
    this.subCategories,
  });

  String get _id => id;
  String get _name => name;
  List get _subCategories => subCategories;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['name'] = _name;
    map['subCategories'] = _subCategories;
    if (_id != null) {
      map['id'] = _id;
    }

    return map;
  }

  Category.fromObject(dynamic object) {
    this.id = object['id'];
    this.name = object['name'];
    this.subCategories = object['subCategories'];
  }
}

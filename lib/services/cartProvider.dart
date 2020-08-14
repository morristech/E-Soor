import 'package:flutter/material.dart';
import 'package:E_Soor/models/BookModel.dart';

class CartItem extends ChangeNotifier {
  List<Book> products = [];
  addProduct(Book product) {
    products.add(product);
    notifyListeners();
  }

  deleteProduct(Book product) {
    products.remove(product);
    notifyListeners();
  }
}

import 'BookModel.dart';
import 'UserModel.dart';

class Order {
  String orderId;
  User client;
  List<Book> products;
  String address;
  DateTime orderTime;

  Order({
    this.orderId,
    this.client,
    this.products,
    this.address,
    this.orderTime,
  });
}

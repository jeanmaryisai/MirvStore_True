// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'Product.dart';
import 'chat.dart';
import 'user.dart';

class Trade extends Identifiable {
  User sender;
  User receiver;
  bool? isAccepted;
  Product product;
  double amout;
  DateTime created;
  User buyer;
  Trade({
    required this.sender,
    required this.receiver,
    this.isAccepted,
    required this.product,
    required this.amout,
    required this.created,
    required this.buyer,
  });
}

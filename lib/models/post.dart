// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'Product.dart';
import 'chat.dart';
import 'user.dart';

class Post extends Identifiable {
  Product product;
  String caption;
  User author;
  bool isRepost;
  List<User> liked;
  Post({
    required this.product,
    required this.caption,
    required this.author,
    required this.isRepost,
    required this.liked,
  });
}

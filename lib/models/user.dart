// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'chat.dart';
import 'post.dart';

class User extends Identifiable {
  String username;
  String password;
  String bio;
  String profile;
  bool? isSeller;
  String address;
  User(
      {required this.username,
      required this.password,
      required this.profile,
      isSeller = false,
        this.address='',
      this.bio = "Hello I am user Mirv_store"});
  bool isSellerTrue() {
    return isSeller ?? false;
  }
}

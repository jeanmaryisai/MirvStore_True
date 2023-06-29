// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'post.dart';
import 'user.dart';

class postPerQuota {
  User user;
  Post post;
  int quota;
  postPerQuota({
    required this.user,
    required this.post,
    this.quota=0,
  });
}

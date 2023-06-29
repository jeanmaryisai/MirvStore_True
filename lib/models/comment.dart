// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'chat.dart';
import 'post.dart';
import 'user.dart';

class Comment extends Identifiable {
  String comment;
  User author;
  Post post;
  DateTime created;
  Comment({
    required this.comment,
    required this.author,
    required this.post,
    required this.created,
  });
}

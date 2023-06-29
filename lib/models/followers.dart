// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'chat.dart';
import 'user.dart';

class Followers extends Identifiable {
  User first;
  User followedBack;
  bool isFollowBack;
  Followers({
    required this.first,
    required this.followedBack,
    required this.isFollowBack,
  });
}

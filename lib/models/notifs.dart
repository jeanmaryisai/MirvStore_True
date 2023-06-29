// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'chat.dart';
import 'user.dart';

class NotificationCustom extends Identifiable {
  User receiver;
  String message;
  User? isAbout;
  NotificationCustom({
    required this.receiver,
    required this.message,
    this.isAbout,
  });
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../components/data.dart';
import 'chat.dart';
import 'trade.dart';
import 'user.dart';
import 'package:timeago/timeago.dart' as timeago;

class Message extends Identifiable {
  String message;
  DateTime send;
  Trade? trade;
  User sender;
  Message({
    this.message = '',
    required this.send,
    this.trade,
    required this.sender,
  });

  bool isTrade() {
    return trade == null ? false : true;
  }

  bool isMe() {
    return sender.id == currentUser.id ? true : false;
  }

  String timeAgo() {
    return timeago.format(send);
  }

  String captionSTR() {
    return isTrade() ? "Trade: \$${trade!.amout.toStringAsFixed(2)} for ${trade!.product.title}" : message;
  }
}

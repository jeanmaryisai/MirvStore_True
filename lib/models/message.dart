// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:timeago/timeago.dart' as timeago;

import '../components/data.dart';
import 'chat.dart';
import 'trade.dart';
import 'user.dart';

class Message {
  String message;
  DateTime send;
  String? trade;
  String myId;
  String sender;
  Message({
    this.message = '',
    required this.send,
    this.trade,
    required this.myId,
    required this.sender,
  });

  bool isTrade() {
    return trade == null ? false : true;
  }

  bool isMe() {
    return sender == currentUser.myId ? true : false;
  }

  String timeAgo() {
    return timeago.format(send);
  }

  String captionSTR() {
    return isTrade() ? "Trade: \$${trades.firstWhere((element) => element.myId==trade)!.amout.toStringAsFixed(2)} for ${products.firstWhere((element) => element.myId==trades.firstWhere((element) => element.myId==trade)!.product).title}" : message;
  }





  Message copyWith({
    String? message,
    DateTime? send,
    String? trade,
    String? myId,
    String? sender,
  }) {
    return Message(
      message: message ?? this.message,
      send: send ?? this.send,
      trade: trade ?? this.trade,
      myId: myId ?? this.myId,
      sender: sender ?? this.sender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'send': send.millisecondsSinceEpoch,
      'trade': trade,
      'myId': myId,
      'sender': sender,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'] as String,
      send: DateTime.fromMillisecondsSinceEpoch(map['send'] as int),
      trade: map['trade'] != null ? map['trade'] as String : null,
      myId: map['myId'] as String,
      sender: map['sender'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(message: $message, send: $send, trade: $trade, myId: $myId, sender: $sender)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message &&
      other.send == send &&
      other.trade == trade &&
      other.myId == myId &&
      other.sender == sender;
  }

  @override
  int get hashCode {
    return message.hashCode ^
      send.hashCode ^
      trade.hashCode ^
      myId.hashCode ^
      sender.hashCode;
  }
}

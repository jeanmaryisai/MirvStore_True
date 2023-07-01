// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'chat.dart';
import 'user.dart';

class NotificationCustom {
  String receiver;
  String message;
  String? isAbout;
  String myId;
  NotificationCustom({
    required this.receiver,
    required this.message,
    this.isAbout,
    required this.myId,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receiver': receiver,
      'message': message,
      'isAbout': isAbout,
      'myId': myId,
    };
  }

  factory NotificationCustom.fromMap(Map<String, dynamic> map) {
    return NotificationCustom(
      receiver: map['receiver'] as String,
      message: map['message'] as String,
      isAbout: map['isAbout'] != null ? map['isAbout'] as String: null,
      myId: map['myId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationCustom.fromJson(String source) => NotificationCustom.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationCustom(receiver: $receiver, message: $message, isAbout: $isAbout, myId: $myId)';
  }

  @override
  bool operator ==(covariant NotificationCustom other) {
    if (identical(this, other)) return true;
  
    return 
      other.receiver == receiver &&
      other.message == message &&
      other.isAbout == isAbout &&
      other.myId == myId;
  }

  @override
  int get hashCode {
    return receiver.hashCode ^
      message.hashCode ^
      isAbout.hashCode ^
      myId.hashCode;
  }
}

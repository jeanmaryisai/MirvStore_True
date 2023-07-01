// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../components/data.dart';
import 'message.dart';
import 'user.dart';

class Chat {
  String user1;
  String user2;
  List<Message> messages;
  String myId;

List<Message> getMessagesOrderedByMostRecent() {
  messages.sort((a, b) => b.send.compareTo(a.send));
  return messages.toList();
}

  Chat({
    required this.user1,
    required this.user2,
    required this.messages,
    required this.myId,
  });

  String theOrther() {
    return user1 == currentUser.myId ? user2 : user1;
  }



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user1': user1,
      'user2': user2,
      'messages': messages.map((x) => x.toMap()).toList(),
      'myId': myId,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      user1: map['user1'] as String,
      user2: map['user2'] as String,
      messages: List<Message>.from((map['messages'] as List<int>).map<Message>((x) => Message.fromMap(x as Map<String,dynamic>),),),
      myId: map['myId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chat(user1: $user1, user2: $user2, messages: $messages, myId: $myId)';
  }

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;
  
    return 
      other.user1 == user1 &&
      other.user2 == user2 &&
      listEquals(other.messages, messages) &&
      other.myId == myId;
  }

  @override
  int get hashCode {
    return user1.hashCode ^
      user2.hashCode ^
      messages.hashCode ^
      myId.hashCode;
  }
}
List<Chat> getChatsOrderedByMostRecent() {
  chats
      .where((element) => element.user1==currentUser.myId||element.user2==currentUser.myId)
      .toList()

      .sort((a,b)=>a.getMessagesOrderedByMostRecent().first.send.compareTo(b.getMessagesOrderedByMostRecent().first.send));
  return chats.reversed.toList();
}
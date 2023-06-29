// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

import '../components/data.dart';
import 'message.dart';
import 'user.dart';

abstract class Identifiable {
  String id;
  Identifiable() : id = Uuid().v4();
}

class Chat extends Identifiable {
  User user1;
  User user2;
  List<Message> messages;

List<Message> getMessagesOrderedByMostRecent() {
  messages.sort((a, b) => b.send.compareTo(a.send));
  return messages.toList();
}

  Chat({
    required this.user1,
    required this.user2,
    required this.messages,
  });

  User theOrther() {
    return user1.id == currentUser.id ? user2 : user1;
  }
}
List<Chat> getChatsOrderedByMostRecent() {
  chats.sort((a,b)=>a.getMessagesOrderedByMostRecent().first.send.compareTo(b.getMessagesOrderedByMostRecent().first.send));
  return chats.reversed.toList();
}
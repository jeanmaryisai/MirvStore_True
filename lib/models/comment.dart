// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'chat.dart';
import 'post.dart';
import 'user.dart';

class Comment {
  String comment;
  String author;
  // User author;
  String post;
  String myId;
  DateTime created;
  Comment({
    required this.comment,
    required this.author,
    required this.post,
    required this.myId,
    required this.created,
  });




  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comment': comment,
      'author': author,
      'post': post,
      'myId': myId,
      'created': created.millisecondsSinceEpoch,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      comment: map['comment'] as String,
      author: map['author'] as String,
      post: map['post'] as String,
      myId: map['myId'] as String,
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Comment(comment: $comment, author: $author, post: $post, myId: $myId, created: $created)';
  }

  @override
  bool operator ==(covariant Comment other) {
    if (identical(this, other)) return true;
  
    return 
      other.comment == comment &&
      other.author == author &&
      other.post == post &&
      other.myId == myId &&
      other.created == created;
  }

  @override
  int get hashCode {
    return comment.hashCode ^
      author.hashCode ^
      post.hashCode ^
      myId.hashCode ^
      created.hashCode;
  }
}

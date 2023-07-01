// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'post.dart';
import 'user.dart';

class postPerQuota {
  String user;
  String post;
  int quota;
  String myId;
  postPerQuota({
    required this.user,
    required this.post,
    this.quota=0,
    required this.myId,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'post': post,
      'quota': quota,
      'myId': myId,
    };
  }

  factory postPerQuota.fromMap(Map<String, dynamic> map) {
    return postPerQuota(
      user: map['user'] as String,
      post: map['post'] as String,
      quota: map['quota'] as int,
      myId: map['myId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory postPerQuota.fromJson(String source) => postPerQuota.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'postPerQuota(user: $user, post: $post, quota: $quota, myId: $myId)';
  }

  @override
  bool operator ==(covariant postPerQuota other) {
    if (identical(this, other)) return true;
  
    return 
      other.user == user &&
      other.post == post &&
      other.quota == quota &&
      other.myId == myId;
  }

  @override
  int get hashCode {
    return user.hashCode ^
      post.hashCode ^
      quota.hashCode ^
      myId.hashCode;
  }
}

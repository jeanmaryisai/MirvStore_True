// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'chat.dart';
import 'user.dart';

class Followers {
  User first;
  User followedBack;
  bool isFollowBack;
  String myId;
  Followers({
    required this.first,
    required this.followedBack,
    required this.isFollowBack,
    required this.myId,
  });

 

  Followers copyWith({
    User? first,
    User? followedBack,
    bool? isFollowBack,
    String? myId,
  }) {
    return Followers(
      first: first ?? this.first,
      followedBack: followedBack ?? this.followedBack,
      isFollowBack: isFollowBack ?? this.isFollowBack,
      myId: myId ?? this.myId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first': first.toMap(),
      'followedBack': followedBack.toMap(),
      'isFollowBack': isFollowBack,
      'myId': myId,
    };
  }

  factory Followers.fromMap(Map<String, dynamic> map) {
    return Followers(
      first: User.fromMap(map['first'] as Map<String,dynamic>),
      followedBack: User.fromMap(map['followedBack'] as Map<String,dynamic>),
      isFollowBack: map['isFollowBack'] as bool,
      myId: map['myId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Followers.fromJson(String source) => Followers.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Followers(first: $first, followedBack: $followedBack, isFollowBack: $isFollowBack, myId: $myId)';
  }

  @override
  bool operator ==(covariant Followers other) {
    if (identical(this, other)) return true;
  
    return 
      other.first == first &&
      other.followedBack == followedBack &&
      other.isFollowBack == isFollowBack &&
      other.myId == myId;
  }

  @override
  int get hashCode {
    return first.hashCode ^
      followedBack.hashCode ^
      isFollowBack.hashCode ^
      myId.hashCode;
  }
}

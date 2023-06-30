// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'chat.dart';
import 'post.dart';

class User {
  String username;
  String password;
  String bio;
  String myId;
  String profile;
  bool? isSeller;
  String address;
  User({
    required this.username,
    required this.password,
    this.bio = "Hello I am user Mirv_store",
    required this.myId,
    required this.profile,
    this.isSeller,
    this.address='',
  });
  bool isSellerTrue() {
    return isSeller ?? false;
  }

  


 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'bio': bio,
      'myId': myId,
      'profile': profile,
      'isSeller': isSeller,
      'address': address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username:map['username'] as String,
      password:map['password'] as String,
      bio:map['bio'] as String,
      myId:map['myId'] as String,
      profile:map['profile'] as String,
      isSeller:map['isSeller'] != null ? map['isSeller'] as bool : null,
      address:map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(username: $username, password: $password, bio: $bio, myId: $myId, profile: $profile, isSeller: $isSeller, address: $address)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.username == username &&
      other.password == password &&
      other.bio == bio &&
      other.myId == myId &&
      other.profile == profile &&
      other.isSeller == isSeller &&
      other.address == address;
  }

  @override
  int get hashCode {
    return username.hashCode ^
      password.hashCode ^
      bio.hashCode ^
      myId.hashCode ^
      profile.hashCode ^
      isSeller.hashCode ^
      address.hashCode;
  }
}

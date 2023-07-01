// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'Product.dart';
import 'chat.dart';
import 'user.dart';

class Post {
  String product;
  String caption;
  String author;
  bool isRepost;
  String myId;
  List<User> liked;
  Post({
    required this.product,
    required this.caption,
    required this.author,
    required this.isRepost,
    required this.myId,
    required this.liked,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product,
      'caption': caption,
      'author': author,
      'isRepost': isRepost,
      'myId': myId,
      'liked': liked.map((x) => x.toMap()).toList(),
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      product: map['product'] as String,
      caption: map['caption'] as String,
      author: map['author'] as String,
      isRepost: map['isRepost'] as bool,
      myId: map['myId'] as String,
      liked: List<User>.from((map['liked'] as List<dynamic>).map<User>((x) => User.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(product: $product, caption: $caption, author: $author, isRepost: $isRepost, myId: $myId, liked: $liked)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;
  
    return 
      other.product == product &&
      other.caption == caption &&
      other.author == author &&
      other.isRepost == isRepost &&
      other.myId == myId &&
      listEquals(other.liked, liked);
  }

  @override
  int get hashCode {
    return product.hashCode ^
      caption.hashCode ^
      author.hashCode ^
      isRepost.hashCode ^
      myId.hashCode ^
      liked.hashCode;
  }
}

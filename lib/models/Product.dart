// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'chat.dart';
import 'user.dart';

class Product {
  String title;
  String description;
  String image;
  double? staticPrice;
  User owner;
  bool isSold;
  String myId;
  bool isAvailable;
  Product({
    required this.title,
    required this.description,
    required this.image,
    this.staticPrice = 0.0,
    required this.owner,
    this.isSold = false,
    required this.myId,
    this.isAvailable=true,
  });


  Product copyWith({
    String? title,
    String? description,
    String? image,
    double? staticPrice,
    User? owner,
    bool? isSold,
    String? myId,
    bool? isAvailable,
  }) {
    return Product(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      staticPrice: staticPrice ?? this.staticPrice,
      owner: owner ?? this.owner,
      isSold: isSold ?? this.isSold,
      myId: myId ?? this.myId,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'image': image,
      'staticPrice': staticPrice,
      'owner': owner.toMap(),
      'isSold': isSold,
      'myId': myId,
      'isAvailable': isAvailable,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      staticPrice: map['staticPrice'] != null ? map['staticPrice'] as double : null,
      owner: User.fromMap(map['owner'] as Map<String,dynamic>),
      isSold: map['isSold'] as bool,
      myId: map['myId'] as String,
      isAvailable: map['isAvailable'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(title: $title, description: $description, image: $image, staticPrice: $staticPrice, owner: $owner, isSold: $isSold, myId: $myId, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.description == description &&
      other.image == image &&
      other.staticPrice == staticPrice &&
      other.owner == owner &&
      other.isSold == isSold &&
      other.myId == myId &&
      other.isAvailable == isAvailable;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      description.hashCode ^
      image.hashCode ^
      staticPrice.hashCode ^
      owner.hashCode ^
      isSold.hashCode ^
      myId.hashCode ^
      isAvailable.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// import 'package:firebase_database/firebase_database.dart';

import 'Product.dart';
import 'chat.dart';
import 'user.dart';

class Trade {
  String sender;
  String receiver;
  bool? isAccepted;
  String product;
  double amout;
  String myId;
  DateTime created;
  String buyer;
  Trade({
    required this.sender,
    required this.receiver,
    this.isAccepted,
    required this.product,
    required this.amout,
    required this.myId,
    required this.created,
    required this.buyer,
  });

  // factory Trade.fromDataSnapshot(DataSnapshot snapshot) {
  //   Map<dynamic, dynamic> tradeData = snapshot.;
  //
  //   return Trade(
  //     sender: User.fromMap(tradeData['sender']),
  //     receiver: User.fromMap(tradeData['receiver']),
  //     isAccepted: tradeData['isAccepted'],
  //     product: Product.fromMap(tradeData['product']),
  //     amout: tradeData['amount'],
  //     myId: snapshot.key,
  //     created: DateTime.parse(tradeData['created']),
  //     buyer: User.fromMap(tradeData['buyer']),
  //   );
  // }





  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'receiver': receiver,
      'isAccepted': isAccepted,
      'product': product,
      'amout': amout,
      'myId': myId,
      'created': created.millisecondsSinceEpoch,
      'buyer': buyer,
    };
  }

  factory Trade.fromMap(Map<String, dynamic> map) {
    return Trade(
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      isAccepted: map['isAccepted'] != null ? map['isAccepted'] as bool : null,
      product: map['product'] as String,
      amout: map['amout'] as double,
      myId: map['myId'] as String,
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] as int),
      buyer: map['buyer'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Trade.fromJson(String source) => Trade.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Trade(sender: $sender, receiver: $receiver, isAccepted: $isAccepted, product: $product, amout: $amout, myId: $myId, created: $created, buyer: $buyer)';
  }

  @override
  bool operator ==(covariant Trade other) {
    if (identical(this, other)) return true;
  
    return 
      other.sender == sender &&
      other.receiver == receiver &&
      other.isAccepted == isAccepted &&
      other.product == product &&
      other.amout == amout &&
      other.myId == myId &&
      other.created == created &&
      other.buyer == buyer;
  }

  @override
  int get hashCode {
    return sender.hashCode ^
      receiver.hashCode ^
      isAccepted.hashCode ^
      product.hashCode ^
      amout.hashCode ^
      myId.hashCode ^
      created.hashCode ^
      buyer.hashCode;
  }
}

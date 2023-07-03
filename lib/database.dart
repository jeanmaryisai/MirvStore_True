// import 'package:firebase_database/firebase_database.dart';

import 'dart:async';

import 'package:hello/models/comment.dart';
import 'package:hello/models/followers.dart';

import 'components/data.dart';
import 'models/Product.dart';
import 'models/chat.dart';
import 'models/message.dart';
// import 'models/notifs.dart';
import 'models/post.dart';
import 'models/trade.dart';
import 'models/user.dart';import 'package:cloud_firestore/cloud_firestore.dart';


abstract class UserDb {
  static Future<void> add(User user) async {
    final db = FirebaseFirestore.instance;
    final users = db.collection("users");
    users.doc(user.myId).set(user.toMap());
  }

  static Future<void> delete(String userId) async {
    try {
      // Get a reference to the user document in Firestore
      DocumentReference userRef =
      FirebaseFirestore.instance.collection('users').doc(userId);

      // Delete the user document
      await userRef.delete();
      print('User deleted successfully');
    } catch (error) {
      print('Failed to delete user: $error');
    }
  }

  static Future<void> update(User updatedUser, String userId) async {
    try {
      DocumentReference userRef =
      FirebaseFirestore.instance.collection('users').doc(userId);

      // Convert the updatedUser object to a Map
      Map<String, dynamic> userData = updatedUser.toMap();

      // Update the user document with the new data
      await userRef.update(userData);
      print('User updated successfully');
    } catch (error) {
      print('Failed to update user: $error');
    }
  }

  static Future<void> get() async {
    final db = FirebaseFirestore.instance;
    List<User> c=[];
    db.collection("users").get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          c.add(User.fromMap(data));
        }
        users=c;usersStream.add(users);
        print(users);
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}

abstract class TradeDb{
static Future<void> add(Trade trade) async{
  final db = FirebaseFirestore.instance;
  final trades = db.collection("trades");
  trades.doc(trade.myId).set(trade.toMap());
}



static Future<void> delete(String tradeId) async {
  try {
    // Get a reference to the trade document in Firestore
    DocumentReference tradeRef =
    FirebaseFirestore.instance.collection('trades').doc(tradeId);

    // Delete the trade document
    await tradeRef.delete();
    print('Trade deleted successfully');
  } catch (error) {
    print('Failed to delete trade: $error');
  }
}


static Future<void> update(Trade updatedTrade, String tradeId) async {
  try {
    DocumentReference tradeRef =
    FirebaseFirestore.instance.collection('trades').doc(tradeId);

    // Convert the updatedTrade object to a Map
    Map<String, dynamic> tradeData = updatedTrade.toMap();

    // Update the trade document with the new data
    await tradeRef.update(tradeData);
    print('Trade updated successfully');
  } catch (error) {
    print('Failed to update trade: $error');
  }
}

  static Future<void> get() async{
    final db = FirebaseFirestore.instance;

    db.collection("trades").get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          trades.add(Trade.fromMap(data));
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

  }

}

abstract class ProductDb {
  static Future<void> add(Product product) async {
    final db = FirebaseFirestore.instance;
    final products = db.collection("products");
    products.doc(product.myId).set(product.toMap());
  }

  static Future<void> delete(String productId) async {
    try {
      // Get a reference to the product document in Firestore
      DocumentReference productRef =
      FirebaseFirestore.instance.collection('products').doc(productId);

      // Delete the product document
      await productRef.delete();
      print('Product deleted successfully');
    } catch (error) {
      print('Failed to delete product: $error');
    }
  }

  static Future<void> update(Product updatedProduct, String productId) async {
    try {
      DocumentReference productRef =
      FirebaseFirestore.instance.collection('products').doc(productId);

      // Convert the updatedProduct object to a Map
      Map<String, dynamic> productData = updatedProduct.toMap();

      // Update the product document with the new data
      await productRef.update(productData);
      print('Product updated successfully');
    } catch (error) {
      print('Failed to update product: $error');
    }
  }

  static Future<void> get() async {
    final db = FirebaseFirestore.instance;

    db.collection("products").get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          products.add(Product.fromMap(data));
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}

abstract class PostDb {
  static Future<void> add(Post post) async {
    final db = FirebaseFirestore.instance;
    final posts = db.collection("posts");
    posts.doc(post.myId).set(post.toMap());
  }

  static Future<void> delete(String postId) async {
    try {
      // Get a reference to the post document in Firestore
      DocumentReference postRef =
      FirebaseFirestore.instance.collection('posts').doc(postId);

      // Delete the post document
      await postRef.delete();
      print('Post deleted successfully');
    } catch (error) {
      print('Failed to delete post: $error');
    }
  }

  static Future<void> update(Post updatedPost, String postId) async {
    try {
      DocumentReference postRef =
      FirebaseFirestore.instance.collection('posts').doc(postId);

      // Convert the updatedPost object to a Map
      Map<String, dynamic> postData = updatedPost.toMap();

      // Update the post document with the new data
      await postRef.update(postData);
      print('Post updated successfully');
    } catch (error) {
      print('Failed to update post: $error');
    }
  }

  static Future<void> get() async {
    final db = FirebaseFirestore.instance;
    List<Post> c=[];
    db.collection("posts").get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          c.add(Post.fromMap(data));print(Post.fromMap(data));
        }
        posts=c;postsStream.add(posts);

      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}

abstract class MessageDb {
  static Future<void> add(Message message) async {
    final db = FirebaseFirestore.instance;
    final messages = db.collection("messages");
    messages.doc(message.myId).set(message.toMap());
  }

  static Future<void> delete(String messageId) async {
    try {
      // Get a reference to the message document in Firestore
      DocumentReference messageRef =
      FirebaseFirestore.instance.collection('messages').doc(messageId);

      // Delete the message document
      await messageRef.delete();
      print('Message deleted successfully');
    } catch (error) {
      print('Failed to delete message: $error');
    }
  }

  static Future<void> update(Message updatedMessage, String messageId) async {
    try {
      DocumentReference messageRef =
      FirebaseFirestore.instance.collection('messages').doc(messageId);

      // Convert the updatedMessage object to a Map
      Map<String, dynamic> messageData = updatedMessage.toMap();

      // Update the message document with the new data
      await messageRef.update(messageData);
      print('Message updated successfully');
    } catch (error) {
      print('Failed to update message: $error');
    }
  }

  static Future<void> get() async {
    final db = FirebaseFirestore.instance;
    List<Message> c=[];
    db.collection("messages").get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          c.add(Message.fromMap(data));
        }
        messagesGenerales=c;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}

abstract class FollowersDb {
  static Future<void> add(Followers followers) async {
    final db = FirebaseFirestore.instance;
    final messages = db.collection("followers");
    messages.doc(followers.myId).set(followers.toMap());
  }

  static Future<void> delete(String followersId) async {
    try {
      // Get a reference to the message document in Firestore
      DocumentReference messageRef =
      FirebaseFirestore.instance.collection('followers').doc(followersId);

      // Delete the message document
      await messageRef.delete();
      print('Followers deleted successfully');
    } catch (error) {
      print('Failed to delete follower: $error');
    }
  }

  static Future<void> update(Followers updatedMessage, String messageId) async {
    try {
      DocumentReference messageRef =
      FirebaseFirestore.instance.collection('followers').doc(messageId);

      // Convert the updatedMessage object to a Map
      Map<String, dynamic> messageData = updatedMessage.toMap();

      // Update the message document with the new data
      await messageRef.update(messageData);
      print('Message updated successfully');
    } catch (error) {
      print('Failed to update message: $error');
    }
  }

  static Future<void> get() async {
    final db = FirebaseFirestore.instance;
    List<Followers> c=[];
    db.collection("followers").get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          c.add(Followers.fromMap(data));
        }
        followersGenerale=c;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}

abstract class CommentDb {
  static Future<void> add(Comment comment) async {
    final db = FirebaseFirestore.instance;
    final messages = db.collection("comments");
    messages.doc(comment.myId).set(comment.toMap());
  }

  static Future<void> delete(String commentId) async {
    try {
      // Get a reference to the message document in Firestore
      DocumentReference messageRef =
      FirebaseFirestore.instance.collection('comments').doc(commentId);

      // Delete the message document
      await messageRef.delete();
      print('Followers deleted successfully');
    } catch (error) {
      print('Failed to delete comment: $error');
    }
  }

  static Future<void> update(Comment updatedComment, String commentId) async {
    try {
      DocumentReference messageRef =
      FirebaseFirestore.instance.collection('comments').doc(commentId);

      // Convert the updatedMessage object to a Map
      Map<String, dynamic> messageData = updatedComment.toMap();

      // Update the message document with the new data
      await messageRef.update(messageData);
      print('Comment updated successfully');
    } catch (error) {
      print('Comment to update message: $error');
    }
  }

  static Future<void> get() async {
    final db = FirebaseFirestore.instance;
    List<Comment> c=[];
    db.collection("comments").get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          c.add(Comment.fromMap(data));
        }comments=c;commentsStream.add(comments);
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}

abstract class ChatDb {
  static Future<void> addChat(Chat chat) async {
    final db = FirebaseFirestore.instance;
    final chatsCollection = db.collection("chats");

    await chatsCollection.doc(chat.myId).set(chat.toMap());
  }

  static Future<void> deleteChat(String chatId) async {
    final db = FirebaseFirestore.instance;
    final chatsCollection = db.collection("chats");

    await chatsCollection.doc(chatId).delete();

  }

  static Future<void> updateChat(Chat updatedChat, String chatId) async {
    final db = FirebaseFirestore.instance;
    final chatsCollection = db.collection("chats");
    await chatsCollection.doc(chatId).delete();
    chatsCollection.doc(updatedChat.myId).set(updatedChat.toMap());

  }

  static Future<void> get() async {
    final db = FirebaseFirestore.instance;
    List<Chat> c=[];
    db.collection("chats").get().then(
          (querySnapshot) {
        print("Successfully completed");
        for (var doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          c.add(Chat.fromMap(data));
        }
        chats=c;
        chatsStream.add(chats);
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}

StreamSubscription<QuerySnapshot> listenToChats() {
  final db = FirebaseFirestore.instance;
  final chatsCollection = db.collection("chats");

  return chatsCollection.snapshots().listen((snapshot) {
    // Trigger the reloadData() function whenever there is a change in the database
    ChatDb.get();
  });
}

StreamSubscription<QuerySnapshot> listenToTrades() {
  final db = FirebaseFirestore.instance;
  final tradesCollection = db.collection("trades");

  return tradesCollection.snapshots().listen((snapshot) {
    // Trigger the reloadData() function whenever there is a change in the database
    TradeDb.get();
  });
}

StreamSubscription<QuerySnapshot> listenToFollowers() {
  final db = FirebaseFirestore.instance;
  final followersCollection = db.collection("followers");

  return followersCollection.snapshots().listen((snapshot) {
    // Trigger the reloadData() function whenever there is a change in the database
    FollowersDb.get();
  });
}

StreamSubscription<QuerySnapshot> listenToUsers() {
  final db = FirebaseFirestore.instance;
  final usersCollection = db.collection("users");

  return usersCollection.snapshots().listen((snapshot) {
    // Trigger the reloadData() function whenever there is a change in the database
    UserDb.get();
  });
}

StreamSubscription<QuerySnapshot> listenToProducts() {
  final db = FirebaseFirestore.instance;
  final productsCollection = db.collection("products");

  return productsCollection.snapshots().listen((snapshot) {
    // Trigger the reloadData() function whenever there is a change in the database
    ProductDb.get();
  });
}

StreamSubscription<QuerySnapshot> listenToPosts() {
  final db = FirebaseFirestore.instance;
  final postsCollection = db.collection("posts");

  return postsCollection.snapshots().listen((snapshot) {
    // Trigger the reloadData() function whenever there is a change in the database
    PostDb.get();
  });
}

StreamSubscription<QuerySnapshot> listenToComments() {
  final db = FirebaseFirestore.instance;
  final commentsCollection = db.collection("comments");

  return commentsCollection.snapshots().listen((snapshot) {
    // Trigger the reloadData() function whenever there is a change in the database
    CommentDb.get();
  });
}


void retrieveAllData(){
  UserDb.get();
  TradeDb.get();
  PostDb.get();
  FollowersDb.get();
  CommentDb.get();
  ChatDb.get();
}

// class AuthService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   // Stream to listen for changes in the authentication state
//   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
//
//   // Register a new user with email and password
//   Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
//     try {
//       final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential;
//     } catch (e) {
//       throw Exception('Registration failed: $e');
//     }
//   }
//
//   // Sign in with email and password
//   Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential;
//     } catch (e) {
//       throw Exception('Sign in failed: $e');
//     }
//   }
//
//   // Sign out the current user
//   Future<void> signOut() async {
//     try {
//       await _firebaseAuth.signOut();
//     } catch (e) {
//       throw Exception('Sign out failed: $e');
//     }
//   }
// }
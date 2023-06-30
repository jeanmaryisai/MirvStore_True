import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:hello/database.dart';
import 'package:hello/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'components/data.dart';
import 'models/Product.dart';
import 'models/chat.dart';
import 'models/comment.dart';
import 'models/followers.dart';
import 'models/message.dart';
import 'models/post.dart';
import 'models/trade.dart';

User? getUserByName(String name) {
  for (var element in users) {
    if (element.username == name) {
      return element;
    }
  }
  return null;
}

Product? getProductByTitle(String caption) {
  return products.firstWhere((element) => element.description == caption);
}

void addCommentToPost(String caption, Post post) {
  Comment comment = Comment(
    author: currentUser,
    myId: Uuid().v4(),
    post: post,
    comment: caption,
    created: DateTime.now(),
  );

  comments.add(comment);

  Fluttertoast.showToast(msg: 'sending');
  CommentDb.add(comment);
  commentsStream.add(getCommentsByPost(post));
  Fluttertoast.showToast(msg: 'Posted');
}

Map<String, bool> getFollowerInfo(User me, User you) {
  Map<String, bool> map = {
    'iFollow': false,
    'youFollow': false,
  };
  followersGenerale.forEach((element) {
    if (element.first.myId == me.myId &&
        element.followedBack.myId == you.myId) {
      map['iFollow'] = true;
      element.isFollowBack ? map['youFollow'] = true : map['youFollow'] = false;
      print(12);
    }
    if (element.first.myId == you.myId &&
        element.followedBack.myId == me.myId) {
      map['youFollow'] = true;
      element.isFollowBack ? map['iFollow'] = true : map['iFollow'] = false;
      print(13);
    }
  });
  return map;
}

List<User> getFollowers(User user) {
  List<User> follower = [];
  users.forEach((element) {
    getFollowerInfo(user, element)['youFollow']! ? follower.add(element) : null;
  });
  return follower;
}

List<Comment> getCommentsByPost(Post post) {
  List<Comment> c =
  comments.where((element) => element.post.myId == post.myId).toList();
  c.sort(((a, b) => a.created.compareTo(b.created)));
  return c.reversed.toList();
}

void repost(Post post, String caption) {
  Post post2 = Post(
      product: post.product,
      myId: Uuid().v4(),
      caption: caption,
      author: currentUser,
      isRepost: true,
      liked: List.generate(5, (index) => users[random.nextInt(10)]));


  Fluttertoast.showToast(msg: 'Sending');
  PostDb.add(post2);
  posts.add(post2);
  postsStream.add(posts);
  Fluttertoast.showToast(msg: 'Reposted');
}

List<User> getFollowing(User user) {
  List<User> follower = [];
  users.forEach((element) {
    getFollowerInfo(user, element)['iFollow']! ? follower.add(element) : null;
  });
  return follower;
}

void confirmTrade(Trade trade, bool accept) {
  trades
      .firstWhere((element) => element.myId == trade.myId)
      .isAccepted = accept;
  TradeDb.update(trades
      .firstWhere((element) => element.myId == trade.myId), trade.myId);
  Chat chat = chats.firstWhere((element) =>
      element.messages.any((element) => element.trade!.myId == trade.myId));

  chatsStream.add(chats);
  Fluttertoast.showToast(
      msg: 'sending');
  ChatDb.updateChat(chat, chat.myId);
  Fluttertoast.showToast(
      msg: accept
          ? 'The trade has been accepted'
          : 'The trade has been decline');
}

String generateUniqueId() {
  var uuid = Uuid();
  return uuid.v4();
}

bool isTradeUnactive(Trade trade) {
  bool cc(bool? x) {
    return x ?? false;
  }

  return trade.isAccepted != null ||
      trade.product.isSold ||
      !trade.product.isAvailable ||
      trades.any((element) =>
      element.product.myId == trade.product.myId && cc(element.isAccepted));
}

void updateChat(Chat chat, Message message) {
  if (chats.contains(chat)) {
    chats
        .firstWhere((element) => element.myId == chat.myId)
        .messages
        .add(message);
  } else {
    chat.messages.add(message);
    chats.add(chat);
  }
  chatsStream.add(chats);
  ChatDb.updateChat(chat, chat.myId);
}

void unFollow(User me, User you) {
  for (var element in followersGenerale) {
    if (element.first.myId == me.myId &&
        element.followedBack.myId == you.myId &&
        element.isFollowBack) {
      Followers f = Followers(
          first: you, myId: Uuid().v4(), followedBack: me, isFollowBack: false);

      followersGenerale
          .add(f);
      followersGenerale.remove(element);
      FollowersDb.add(f);
      FollowersDb.delete(element.myId);
      break;
    }
    if (element.first.myId == me.myId &&
        element.followedBack.myId == you.myId &&
        !element.isFollowBack) {
      followersGenerale.remove(element);

      FollowersDb.delete(element.myId);
      break;
    }
    if (element.first.myId == you.myId &&
        element.followedBack.myId == me.myId &&
        element.isFollowBack) {
      element.isFollowBack = false;
      FollowersDb.update(element, element.myId);
      break;
    }
  }
}

void follow(User me, User you) {
  bool b = false;
  // if (!(followersGenerale.any((element) =>
  //     element.first.myId == me.myId && element.followedBack.myId == you.myId))) {
  //   print(1);
  for (var element in followersGenerale) {
    if (element.first.myId == you.myId &&
        element.followedBack.myId == me.myId &&
        !element.isFollowBack) {
      element.isFollowBack = true;
      FollowersDb.update(element, element.myId);
      b = true;
      print(2);
      break;
    }
  }
  if (!b) {
    Followers f = Followers(
        first: me, myId: Uuid().v4(), followedBack: you, isFollowBack: false);
    followersGenerale
        .add(f);
    FollowersDb.add(f);
  }
}

List<User> searchUsers(List<User> _users, String query) {
  if (query.isEmpty) {
    // If the search query is empty, return the original list
    return _users;
  }

  query = query.toLowerCase();

  return _users.where((user) {
    // Convert all user properties to lowercase for case-insensitive search
    String username = user.username.toLowerCase();
    // String name = user.name.toLowerCase();
    String bio = user.bio.toLowerCase();
    // String lastName = user.lastName.toLowerCase();

    // Check if any of the user properties contain the search query
    return username.contains(query) ||
        // name.contains(query) ||
        bio.contains(query) ||
        // lastName.contains(query) ||
        username.split(' ').any((part) => part.startsWith(query)) ||
        bio.split(' ').any((word) => word.startsWith(query));
  }).toList();
}

void changeSellerState(User user, bool bol) {
  users
      .firstWhere((element) => user.myId == element.myId)
      .isSeller = bol;
  User u = users.firstWhere((element) => user.myId == element.myId);

  usersStream.add(users);
  UserDb.update(user, user.myId);
}

void changeBio(String bio) {
  users
      .firstWhere((element) => element.myId == currentUser.myId)
      .bio = bio;
  User u = users.firstWhere((element) => element.myId == currentUser.myId);

  Fluttertoast.showToast(msg: "Request on the way");
  UserDb.update(u, u.myId);
  Fluttertoast.showToast(msg: "Your bio has been changed");
  usersStream.add(users);
}

void changeAddress(String bio) {
  users
      .firstWhere((element) => element.myId == currentUser.myId)
      .address = bio;

  User u = users.firstWhere((element) => element.myId == currentUser.myId);

  Fluttertoast.showToast(msg: "Request on the way");
  UserDb.update(u, u.myId);
  Fluttertoast.showToast(msg: "Your address has been changed");
  usersStream.add(users);
}

int getLikeCount(Post post) {
  return post.liked.length;
}

int getLikeCountUser(User user) {
  int total = 0;
  posts
      .where((element) => element.author.myId == currentUser.myId)
      .toList()
      .forEach((element) {
    total += getLikeCount(element);
  });
  return total;
}

bool isLike(Post post) {
  return post.liked.any((element) => element.myId == currentUser.myId);
}

void like(Post post) {
  !isLike(post)
      ? posts
      .firstWhere((element) => element.myId == post.myId)
      .liked
      .add(currentUser)
      : posts
      .firstWhere((element) => element.myId == post.myId)
      .liked
      .remove(currentUser);
  postsStream.add(posts);
  PostDb.update(posts
      .firstWhere((element) => element.myId == post.myId), post.myId);

  postsStream.add(posts);
}

List<Post> getUserPosts(User user) {
  return posts.where((element) => element.author.myId == user.myId).toList();
}

void newTrade(double price, String chat, Trade trade) {
  if (trade.amout == price) {
    Fluttertoast.showToast(msg: "This trade already exist");
  } else {
    Chat c = chats.firstWhere((element) => element.myId == chat);
    Trade newTrade = Trade(
      amout: price,
      myId: Uuid().v4(),
      sender: currentUser,
      receiver: c.theOrther(),
      product: trade.product,
      buyer: trade.buyer,
      created: DateTime.now(),
    );
    c.messages.add(
        Message(send: DateTime.now(),
            myId: Uuid().v4(),
            sender: currentUser,
            trade: newTrade));

    chatsStream.add(chats);
    TradeDb.update(newTrade, newTrade.myId);
    ChatDb.updateChat(c, c.myId);
    Fluttertoast.showToast(msg: "New Trade send");
  }
}

void tradeConfirm(String trade, context, address) {
  trades
      .firstWhere((element) => trade == element.myId)
      .product
      .isSold = true;
  trades
      .firstWhere((element) => trade == element.myId)
      .isAccepted = true;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('The product has been booked '),
        content: Text(
            'This product is been booked by you, it will be unavailable on the app, we are waiting for you\n At our address:${address}\n we will stay in touch by then.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  chatsStream.add(chats);
  TradeDb.update(trades
      .firstWhere((element) => element.myId == trade), trade);
  Chat chat = chats.firstWhere((element) =>
      element.messages.any((element) => element.trade!.myId == trade));
  ChatDb.updateChat(chat, chat.myId);
}

void ProductChangeSate(Product product) {
  if (!product.isSold) {
    products
        .firstWhere((element) => element.myId == product.myId)
        .isAvailable =
    !product.isAvailable;
    productsStream.add(products);
    Fluttertoast.showToast(
        msg: product.isAvailable
            ? "The post has been enabled"
            : "The product has been disable");
  }
  ProductDb.update(products
      .firstWhere((element) => element.myId == product.myId), product.myId);
}

void deletePost(Post post, BuildContext context) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return ClassicGeneralDialogWidget(
        titleText: 'Delete Post',
        contentText: post.isRepost
            ? 'Are you sure you want to delete this post?'
            : 'Are you sure you want to delete this post?This post is an original post Deleting this post will also delete the product and all associated reposts.',
        positiveText: 'Delete',
        positiveTextStyle: TextStyle(color: Colors.red),
        onPositiveClick: () {
          post.isRepost
              ? PostDb.delete(post.myId)
              : posts.forEach((element) { if(post.product.myId == element.product.myId){
              PostDb.delete(element.myId);}
          });


          post.isRepost
              ? posts.remove(post)
              ? Fluttertoast.showToast(msg: "Post deleted")
              : Fluttertoast.showToast(msg: 'Failed to delete')
              : posts.removeWhere(
                  (element) => post.product.myId == element.product.myId);

          postsStream.add(posts); // Replace this with your delete post logic

          // Show a toast or snackbar indicating successful deletion
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Post deleted'),
            ),
          );

          Navigator.pop(context); // Close the dialog
        },
        negativeText: 'Cancel',
        negativeTextStyle: TextStyle(color: Colors.black),
        onNegativeClick: () {
          Navigator.pop(context); // Close the dialog
        },
      );
    },
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 500),
  );
}

Future<void> signup(User user) async{
  Fluttertoast.showToast(msg: 'Creating profile');
   UserDb.add(user);
  users.add(user);
  Fluttertoast.showToast(msg: 'Profile created');
}
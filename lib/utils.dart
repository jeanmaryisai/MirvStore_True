import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
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
    post: post,
    comment: caption,
    created: DateTime.now(),
  );
  comments.add(comment);
  commentsStream.add(getCommentsByPost(post));
  Fluttertoast.showToast(msg: 'Posted');
}

Map<String, bool> getFollowerInfo(User me, User you) {
  Map<String, bool> map = {
    'iFollow': false,
    'youFollow': false,
  };
  followersGenerale.forEach((element) {
    if (element.first.id == me.id && element.followedBack.id == you.id) {
      map['iFollow'] = true;
      element.isFollowBack ? map['youFollow'] = true : map['youFollow'] = false;
      print(12);
    }
    if (element.first.id == you.id && element.followedBack.id == me.id) {
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
      comments.where((element) => element.post.id == post.id).toList();
  c.sort(((a, b) => a.created.compareTo(b.created)));
  return c.reversed.toList();
}

void repost(Post post, String caption) {
  Post post2 = Post(
      product: post.product,
      caption: caption,
      author: currentUser,
      isRepost: true,
      liked: List.generate(5, (index) => users[random.nextInt(10)]));
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
  trades.firstWhere((element) => element.id == trade.id).isAccepted = accept;
  chatsStream.add(chats);
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
          element.product.id == trade.product.id && cc(element.isAccepted));
}

void updateChat(Chat chat, Message message) {
  if (chats.contains(chat)) {
    chats.firstWhere((element) => element.id == chat.id).messages.add(message);
  } else {
    chat.messages.add(message);
    chats.add(chat);
  }
  chatsStream.add(chats);
}

void unFollow(User me, User you) {
  for (var element in followersGenerale) {
    if (element.first.id == me.id &&
        element.followedBack.id == you.id &&
        element.isFollowBack) {
      followersGenerale
          .add(Followers(first: you, followedBack: me, isFollowBack: false));
      followersGenerale.remove(element);
      break;
    }
    if (element.first.id == me.id &&
        element.followedBack.id == you.id &&
        !element.isFollowBack) {
      followersGenerale.remove(element);
      break;
    }
    if (element.first.id == you.id &&
        element.followedBack.id == me.id &&
        element.isFollowBack) {
      element.isFollowBack = false;
      break;
    }
  }
}

void follow(User me, User you) {
  bool b = false;
  print(getFollowerInfo(me, you));
  // if (!(followersGenerale.any((element) =>
  //     element.first.id == me.id && element.followedBack.id == you.id))) {
  //   print(1);
  for (var element in followersGenerale) {
    if (element.first.id == you.id &&
        element.followedBack.id == me.id &&
        !element.isFollowBack) {
      element.isFollowBack = true;
      b = true;
      print(2);
      break;
    }
  }
  !b
      ? followersGenerale
          .add(Followers(first: me, followedBack: you, isFollowBack: false))
      : null;
  print(3);
  print(getFollowerInfo(me, you));
  // }
  if (!(followersGenerale.any((element) =>
      element.first.id == you.id && element.followedBack.id == me.id))) {}
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
  users.firstWhere((element) => user.id == element.id).isSeller = bol;
  usersStream.add(users);
}

void changeBio(String bio) {
  users.firstWhere((element) => element.id == currentUser.id).bio = bio;
  Fluttertoast.showToast(msg: "Your bio has been changed");
  usersStream.add(users);
}

void changeAddress(String bio) {
  users.firstWhere((element) => element.id == currentUser.id).address = bio;
  Fluttertoast.showToast(msg: "Your address has been changed");
  usersStream.add(users);
}

int getLikeCount(Post post) {
  return post.liked.length;
}

int getLikeCountUser(User user) {
  int total = 0;
  posts
      .where((element) => element.author.id == currentUser.id)
      .toList()
      .forEach((element) {
    total += getLikeCount(element);
  });
  return total;
}

bool isLike(Post post) {
  return post.liked.any((element) => element.id == currentUser.id);
}

void like(Post post) {
  !isLike(post)
      ? posts
          .firstWhere((element) => element.id == post.id)
          .liked
          .add(currentUser)
      : posts
          .firstWhere((element) => element.id == post.id)
          .liked
          .remove(currentUser);
  postsStream.add(posts);
}

List<Post> getUserPosts(User user) {
  return posts.where((element) => element.author.id == user.id).toList();
}

void newTrade(double price, String chat, Trade trade) {
  if (trade.amout == price) {
    Fluttertoast.showToast(msg: "This trade already exist");
  } else {
    Chat c = chats.firstWhere((element) => element.id == chat);
    Trade newTrade = Trade(
      amout: price,
      sender: currentUser,
      receiver: c.theOrther(),
      product: trade.product,
      buyer: trade.buyer,
      created: DateTime.now(),
    );
    c.messages.add(
        Message(send: DateTime.now(), sender: currentUser, trade: newTrade));
    chatsStream.add(chats);
    Fluttertoast.showToast(msg: "New Trade send");
  }
}

void tradeConfirm(String trade, context, address) {
  trades.firstWhere((element) => trade == element.id).product.isSold = true;
  trades.firstWhere((element) => trade == element.id).isAccepted = true;

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
}

void ProductChangeSate(Product product) {
  if (!product.isSold) {
    products.firstWhere((element) => element.id == product.id).isAvailable =
        !product.isAvailable;
    productsStream.add(products);
    Fluttertoast.showToast(
        msg: product.isAvailable
            ? "The post has been enabled"
            : "The product has been disable");
  }
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
              ? posts.remove(post)
                  ? Fluttertoast.showToast(msg: "Post deleted")
                  : Fluttertoast.showToast(msg: 'Failed to delete')
              : posts.removeWhere(
                  (element) => post.product.id == element.product.id);
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

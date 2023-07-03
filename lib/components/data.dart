import 'dart:async';
import 'dart:math';

// import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

import '../models/Product.dart';
import '../models/chat.dart';
import '../models/comment.dart';
import '../models/followers.dart';
import '../models/message.dart';
import '../models/notifs.dart';
import '../models/post.dart';
import '../models/trade.dart';
import '../models/user.dart';
import '../utils.dart';





List<User> users = [];
StreamController<List<User>> usersStream = StreamController<List<User>>.broadcast();

List<Product> products = [];
StreamController<List<Product>> productsStream = StreamController<List<Product>>.broadcast();



List<Post> posts = [];
StreamController<List<Post>> postsStream = StreamController<List<Post>>.broadcast();


List<Message> messagesGenerales = [];
List<Chat> chats = [];

StreamController<List<Chat>> chatsStream = StreamController<List<Chat>>.broadcast();

List<Trade> trades = [];


List<Followers> followersGenerale =[];

List<Comment> comments=[];
StreamController<List<Comment>> commentsStream = StreamController<List<Comment>>.broadcast();


User currentUser = User(username: 'anonymous', password: 'admin', myId: 'aiaia');

enum quota {
  Like,
  Followed,
  Comment,
}

extension quotaValue on quota {
  int get value {
    switch (this) {
      case quota.Like:
        return 40;
      case quota.Followed:
        return 330;
      case quota.Comment:
        return 300;
    }
  }
}
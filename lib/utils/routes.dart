import 'package:flutter/material.dart';
import 'package:hello/models/message.dart';
import 'package:hello/utils/index.dart';
import 'package:hello/views/addPost.dart';
import 'package:hello/views/message.dart';
import 'package:hello/views/messages.dart';
import 'package:hello/views/newsfeed.dart';
import 'package:hello/views/notification.dart';
import 'package:hello/views/profile.dart';
import 'package:hello/views/signin.dart';
import 'package:hello/views/signup.dart';

const String SignInViewRoute = '/signin';
const String SignUpViewRoute = '/signup';
const String NewsFeedViewRoute = '/feed';
const String MessagesViewRoute = '/messages';
const String MessageViewRoute = '/message';
const String ProfileViewRoute = '/profile';
const String NotificationViewRoute = '/notification';
const String IndexViewRoute = '/index';
const String AddPostViewRoute = '/addpost';

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case NewsFeedViewRoute:
      return MaterialPageRoute(builder: (BuildContext context) => NewsFeed());
      break;
    case IndexViewRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Index());
      break;
    case AddPostViewRoute:
      return MaterialPageRoute(builder: (BuildContext context) => AddPost());
      break;
    case SignInViewRoute:
      return MaterialPageRoute(builder: (BuildContext context) => SignIn());
      break;
    case SignUpViewRoute:
      return MaterialPageRoute(builder: (BuildContext context) => SignUp());
      break;
    case MessagesViewRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Messages());
      break;
    case ProfileViewRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Profile());
      break;
    case NotificationViewRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => Notifications());
      break;
    default:
      return MaterialPageRoute(builder: (BuildContext context) => NewsFeed());
  }
}

import 'package:hello/Screens/DisCover/DiscoverScreen.dart';
import 'package:hello/Screens/Home/HomeScreen.dart';
import 'package:hello/Screens/Inbox/InboxScreen.dart';
import 'package:hello/Screens/profile/ProfileScreen.dart';
import 'package:flutter/material.dart';

import 'components/data.dart';

final Map<String, WidgetBuilder> routes = {
  // SplashPage.routeName: (context) => SplashPage(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(user:currentUser),
  InboxScreen.routeName: (context) => InboxScreen(),
  Discover.routeName: (context) => Discover(),
};

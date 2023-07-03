import 'dart:async';
import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello/NavigationRoutes.dart';
import 'package:hello/Screens/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:hello/database.dart';

import 'Screens/sign_in/sign_in_screen.dart';
import 'components/data.dart';
import 'models/user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ChatDb.get();
  // await dummydata();
  // await UserDb.get();
  // await PostDb.get();
  // TradeDb.retrieveTradesData();
  // TradeDb.addTrade(trades[0]);
  // TradeDb.getTrades();
  // postsStream.add(posts);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final MaterialColor colorCustom = MaterialColor(0xff651CE5, color);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mirv_Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 234, 234, 234),
        fontFamily: "Sans serif",
        visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.fromSwatch(primarySwatch: colorCustom).copyWith(secondary: color[80]),
      ),
      // initialRoute: HomeScreen.routeName,
      // routes: routes,
      home: LoadingScreen(),
    );
  }
}

Map<int, Color> color = {
  50: Color.fromRGBO(102, 28, 229, .1),
  100: Color.fromRGBO(102, 28, 229, .2),
  200: Color.fromRGBO(102, 28, 229, .3),
  300: Color.fromRGBO(102, 28, 229, .4),
  400: Color.fromRGBO(102, 28, 229, .5),
  500: Color.fromRGBO(102, 28, 229, .6),
  600: Color.fromRGBO(102, 28, 229, .7),
  700: Color.fromRGBO(102, 28, 229, .8),
  800: Color.fromRGBO(102, 28, 229, .9),
  900: Color.fromRGBO(102, 28, 229, 1),
};

// class MyApp extends StatelessWidget {
// final AuthService authService = AuthService(); // Instantiate your authentication service
//
// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     title: 'Your App',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//     home: StreamBuilder<User?>(
//       stream: authService.currentUserStream, // Replace with your authentication service's currentUser stream
//       builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           final User? currentUser = snapshot.data;
//
//           // Check if currentUser is null
//           if (currentUser == null) {
//             // Navigate to the login screen
//             Future.microtask(() => Navigator.of(context).pushReplacementNamed('/login'));
//             return Container(); // Placeholder widget while navigating
//           }
//
//           // Return your app's main content or other widgets
//           return MaterialApp(
//             title: 'Mirv_Store',
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//               primaryColor: Color.fromARGB(255, 234, 234, 234),
//               fontFamily: "Sans serif",
//               visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.fromSwatch(primarySwatch: colorCustom).copyWith(secondary: color[80]),
//             ),
//             initialRoute: HomeScreen.routeName,
//             routes: routes,
//           );
//         }
//
//         return CircularProgressIndicator(); // Placeholder widget while loading
//       },
//     ),
//     routes: {
//       '/login': (context) => SignInScreen(), // Define your login screen route
//     },
//   );
// }
// }

Future<void> dummydata() async{

  users.forEach((element) { UserDb.add(element); });
  trades.forEach((element) { TradeDb.add(element); });
  products.forEach((element) { ProductDb.add(element); });
  posts.forEach((element) { PostDb.add(element); });
  chats.forEach((element) { ChatDb.addChat(element); });
  followersGenerale.forEach((element) { FollowersDb.add(element); });
  messagesGenerales.forEach((element) { MessageDb.add(element); });
  // notifs.forEach((element) { No.add(element); });
  // products.forEach((element) { ProductDb.add(element); });
  // trades.forEach((element) { TradeDb.add(element); });
  // users.forEach((element) { UserDb.add(element); });
  // posts.forEach((element) { PostDb.add(element); });
  // posts.forEach((element) { PostDb.add(element); });
}

// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:connectivity/connectivity.dart';
//
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;final List<String> cuteArtMessages = [
    'Exploring the world of art...',
    'Embracing creativity and imagination...',
    'Unlocking the magic of colors...',
    'Admiring the beauty of brushstrokes...',
    'Discovering the power of artistic expression...',
    'Bringing art to life...',
  ];



  String currentMessage = '';

  @override
  void initState() {
    super.initState();
    startLoading();
    _startConnectivitySubscription();
  }
var _t;
  @override
  void dispose() {
    _cancelConnectivitySubscription();
    timer?.cancel();
    timer=null;
    super.dispose();
  }
var timer;
  void startLoading() {

    timer=Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        currentMessage = cuteArtMessages[Random().nextInt(cuteArtMessages.length)];
      });
    });
    // Simulate data loading by delaying the navigation
    Timer(Duration(seconds: 5), () {
      Future.wait([
        UserDb.get(),
        PostDb.get(),
        ChatDb.get(),
        CommentDb.get(),
        FollowersDb.get(),
        ProductDb.get(),
        TradeDb.get(),
      ]).then((_) {
        // Data retrieval complete, navigate to sign-in screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      }).catchError((error) {
        // Handle error if any
        Fluttertoast.showToast(msg:'Error retrieving data: $error');
      });
      // navigateToSignInScreen();
    });
  }

  void navigateToSignInScreen() {
    // Perform navigation logic to the sign-in screen
  }

  void _startConnectivitySubscription() {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
          if (result == ConnectivityResult.none) {
            showNoInternetDialog();
          }
        });
  }

  void _cancelConnectivitySubscription() {
    _connectivitySubscription.cancel();
  }

  void showNoInternetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Internet Connection'),
          content: Text('Please check your internet connection and try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                navigateToSignInScreen();
              },
              child: Text('Retry'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              currentMessage,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


void getAllData(BuildContext context) {
  // Show loading screen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoadingScreen()),
  );

  // Retrieve all data
  Future.wait([
    UserDb.get(),
    PostDb.get(),
    ChatDb.get(),
    CommentDb.get(),
    FollowersDb.get(),
    ProductDb.get(),
    TradeDb.get(),
  ]).then((_) {
    // Data retrieval complete, navigate to sign-in screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }).catchError((error) {
    // Handle error if any
    Fluttertoast.showToast(msg:'Error retrieving data: $error');
  });
}
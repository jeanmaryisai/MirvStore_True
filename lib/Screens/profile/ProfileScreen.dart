// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hello/components/Custom_NavBar.dart';
import 'package:hello/components/enums.dart';
import 'package:intl/intl.dart';

import '../../components/data.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../../utils.dart';
import '../Home/components/RepostDialog.dart';
import '../Home/home_card.dart';
import '../notifications/notificationScreen.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";
  final User user;
  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static Random random = Random();
  NumberFormat numberFormat = NumberFormat.compact();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Stack(children: [
          Container(
            // temp
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              "assets/icons/back-arrow.svg",
                              color: Colors.black,
                              height: 25,
                            ),
                          ),
                          Text(
                            widget.user.username,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      height: 200,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: 
                        // Stack(
                          // children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(widget.user.profile),
                              radius: 25,
                            ),
                        //     widget.user.isSellerTrue()
                        //         ? Positioned(
                        //             bottom: 0,
                        //             right: 0,
                        //             child: Container(
                        //               decoration: BoxDecoration(
                        //                 color: Colors.blue,
                        //                 shape: BoxShape.circle,
                        //               ),
                        //               padding: EdgeInsets.all(2),
                        //               child: Icon(
                        //                 Icons.check,
                        //                 color: Colors.white,
                        //                 size: 20,
                        //               ),
                        //             ),
                        //           )
                        //         : SizedBox(),
                        //   ],
                        // ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.user.isSeller??false?"This user is a seller ":"This user is a regular user.",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 55,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Text(
                                numberFormat
                                    .format(getFollowing(widget.user).length),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text(
                                "Following",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text(
                                numberFormat
                                    .format(getFollowers(widget.user).length),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text(
                                "Followers",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              child: Text(
                                numberFormat
                                    .format(getLikeCountUser(widget.user)),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text(
                                "Like",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  currentUser.myId == widget.user.myId
                      ? SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             getFollowerInfo(currentUser, widget.user)['iFollow']!
                          ? Container(
                              width: 100.0,
                              height: 38.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff651CE5).withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                                gradient: LinearGradient(
                                  // Where the linear gradient begins and ends
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  // Add one stop for each color. Stops should increase from 0 to 1
                                  stops: [0.1, 0.9],
                                  colors: [
                                    // Colors are easy thanks to Flutter's Colors class.

                                    Colors.black.withOpacity(0.5),
                                    Colors.grey,
                                  ],
                                ),
                              ),
                              child: TextButton(
                                child: Text(
                                  'UnFollow',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  unFollow(currentUser, widget.user);
                                  setState(() {});
                                },
                              ),
                              // FlatButton(
                              //   child: Text(
                              //     'Unfollow',
                              //     style: TextStyle(
                              //       fontSize: 16.0,
                              //       fontWeight: FontWeight.w600,
                              //     ),
                              //   ),
                              //   textColor: Colors.white,
                              //   color: Colors.transparent,
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(30.0)),
                              //   onPressed: () {},
                              // ),
                            )
                          : Container(
                              width: 100.0,
                              height: 38.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff651CE5).withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: Offset(
                                        0, 5), // changes position of shadow
                                  ),
                                ],
                                gradient: LinearGradient(
                                  // Where the linear gradient begins and ends
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  // Add one stop for each color. Stops should increase from 0 to 1
                                  stops: [0.1, 0.9],
                                  colors: [
                                    // Colors are easy thanks to Flutter's Colors class.
                                    Color(0xff651CE5),
                                    Color(0xff811ce5),
                                  ],
                                ),
                              ),
                              child: TextButton(
                                child: Text(
                                  'Follow',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  follow(currentUser, widget.user);
                                  setState(() {});
                                },
                              ),
                              // FlatButton(
                              //   child: Text(
                              //     'Follow',
                              //     style: TextStyle(
                              //       fontSize: 16.0,
                              //       fontWeight: FontWeight.w600,
                              //     ),
                              //   ),
                              //   textColor: Colors.white,
                              //   color: Colors.transparent,
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(30.0)),
                              //   onPressed: () {},
                              // ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                height: 50,
                                width: 50,
                                child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                      "assets/icons/mail-outline.svg",
                                    )),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Post",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    padding: EdgeInsets.all(5),
                    itemCount: getUserPosts(widget.user).length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 200 / 300,
                    ),

                    itemBuilder: (BuildContext context, int index) {
                      Post post = getUserPosts(widget.user)[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeS(selectedPost: post),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset(
                                  post.product.image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 20,
                                    ),
                                    child: Container(
                                      height: 40,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            numberFormat.format(getLikeCount(post)),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 300,
                  )
                ],
              ),
            ),
          ),
          widget.user.myId==currentUser.myId?
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomNavBar(
                selectedMenu: MenuState.profile,
              ),
            ),
          ):SizedBox(),
        ]),
      ),
    ));
  }
}




class HomeS extends StatefulWidget {
  final Post selectedPost;

  const HomeS({Key? key, required this.selectedPost}) : super(key: key);

  @override
  _HomeSState createState() => _HomeSState();
}

class _HomeSState extends State<HomeS> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      scrollSelectedPostIntoView();
    });
  }

  void scrollSelectedPostIntoView() {
    if (widget.selectedPost != null) {
      final index = posts.indexOf(widget.selectedPost);
      if (index != -1) {
        _scrollController.animateTo(
          index * MediaQuery.of(context).size.width * 1.45, // Replace `postCardHeight` with the height of each post card
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: StreamBuilder<List<Post>>(
                    stream: postsStream.stream,
                    initialData: posts,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Post>> snapshot) {
                      if (snapshot.hasData) {
                        List<Post> posts = snapshot.data!;
                        return Column(
                          children: [
                            ...List.generate(
                              posts.length,
                                  (index) {
                                Post post = posts[index];
                                return HomeCard(
                                  onRepost: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return RepostDialog(
                                        post: post,
                                      );
                                    },
                                  ),
                                  onComment: () {
                                    showCommentDialog(context, post);
                                  },
                                  post: post,
                                );
                              },
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: CustomNavBar(
                  selectedMenu: MenuState.home,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// class HomeS2 extends StatelessWidget {
//   final Post selectedPost;
//
//   const HomeS({super.key, required this.selectedPost});
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle(
//           statusBarColor: Colors.white,
//           statusBarBrightness: Brightness.dark,
//           statusBarIconBrightness: Brightness.dark),
//     );
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           child: Stack(
//             children: [
//               Container(
//                 color: Colors.white,
//                 child: SingleChildScrollView(
//                   child:
//
//                       StreamBuilder<List<Post>>(
//                         stream: postsStream.stream,
//                         initialData: posts,
//                         builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
//                           if (snapshot.hasData) {
//                             List<Post> posts = snapshot.data!;
//                             return Column(
//                               children: [
//                                 ...List.generate(
//                                   posts.length,
//                                       (index) {
//                                     Post post = posts[index];
//                                     return HomeCard(
//                                       onRepost: () => showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return RepostDialog(
//                                             post: post,
//                                           );
//                                         },
//                                       ),
//                                       onComment: () {
//                                         showCommentDialog(context, post);
//                                       },
//                                       post: post,
//                                     );
//                                   },
//                                 ),
//                               ],
//                             );
//                           } else if (snapshot.hasError) {
//                             return Text('Error: ${snapshot.error}');
//                           } else {
//                             return CircularProgressIndicator();
//                           }
//                         },
//                       )
//
//
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 child: CustomNavBar(
//                   selectedMenu: MenuState.home,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



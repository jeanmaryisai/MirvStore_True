import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hello/components/data.dart';
import 'package:intl/intl.dart';

import '../../models/chat.dart';
import '../../models/message.dart';
import '../../models/post.dart';
import '../../models/trade.dart';
import '../../utils.dart';
import '../Inbox/conversation.dart';
import 'HomeScreen.dart';

class HomeCard extends StatefulWidget {
  final Post post;
  final VoidCallback onRepost;
  final VoidCallback onComment;

  HomeCard({Key? key,
    required this.onRepost,
    required this.post,
    required this.onComment})
      : super(key: key);

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  // Example value for the number of likes
  // bool isLiked = false; // Example value for the like status
  NumberFormat numberFormat = NumberFormat.compact();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ).createShader(
                    Rect.fromLTRB(0, 300, rect.width, rect.height - 1));
              },
              blendMode: BlendMode.darken,
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .width * 1.45,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(widget.post.product.image),
                  ),
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
            ),
          ),
          //Side-bar Container
          Positioned(
            top: 30,
            left: 30,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(81, 0, 0, 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.post.product.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(102, 217, 75, 252),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: !widget.post.product.isSold
                        ? widget.post.product.staticPrice != null
                        ? Text(
                      "\$ ${widget.post.product.staticPrice!.toStringAsFixed(
                          2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                      ),
                    )
                        : Text(
                      'Open Price',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(181, 120, 255, 163),
                        fontSize: 20,
                      ),
                    )
                        : Text(
                      'Sold',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(181, 237, 241, 239),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -5,
            top: MediaQuery
                .of(context)
                .size
                .shortestSide < 600
                ? (MediaQuery
                .of(context)
                .size
                .width * 1.45 -
                MediaQuery
                    .of(context)
                    .size
                    .width * 1.25) /
                2
                : (MediaQuery
                .of(context)
                .size
                .width * 1.45 -
                MediaQuery
                    .of(context)
                    .size
                    .width * 0.7) /
                2,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .shortestSide < 600
                      ? 115
                      : 180,
                  height: MediaQuery
                      .of(context)
                      .size
                      .shortestSide < 600
                      ? MediaQuery
                      .of(context)
                      .size
                      .width * 1.25
                      : MediaQuery
                      .of(context)
                      .size
                      .width * 0.7,

                  // child: ClipPath(
                  //   clipper: MyCustomClipper(),
                  //   child: BackdropFilter(
                  //     filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  //     child: SvgPicture.asset(
                  //       "assets/icons/side-bar.svg",
                  //       color: Color(0xffc9c9c9).withOpacity(0.5),
                  //       fit: BoxFit.fill,
                  //     ),
                  //   ),
                  // ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: (MediaQuery
                            .of(context)
                            .size
                            .width * 1.25) / 8.1,
                        bottom:
                        (MediaQuery
                            .of(context)
                            .size
                            .width * 1.25) / 8.1,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                                  height: 60,
                                  width: 60,
                                  child: Padding(
                                      padding: const EdgeInsets.all(17.0),
                                      child: SvgPicture.asset(
                                        isLike(widget.post)
                                            ? "assets/icons/heart-shape-silhouette.svg"
                                            : "assets/icons/heart-shape-outine.svg",
                                        color: Color(0xffffffff),
                                      )),
                                ),
                                onTap: () {
                                  setState(() {
                                    like(widget.post);
                                  });
                                },
                              ),
                              Text(
                                numberFormat.format(getLikeCount(widget.post)),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: widget.onComment,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white.withOpacity(0.4),
                              ),
                              height: 60,
                              width: 60,
                              child: Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: SvgPicture.asset(
                                  "assets/icons/comment-option.svg",
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: widget.onRepost,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white.withOpacity(0.4),
                              ),
                              height: 60,
                              width: 60,
                              child: Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: SvgPicture.asset(
                                  "assets/icons/repost.svg",
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                          widget.post.product.isSold
                          // !widget.post.product.isAvailable

                              ? SizedBox()
                              : widget.post.product.owner.id == currentUser.id
                              ? !widget.post.product.isAvailable
                              ? InkWell(
                            onTap: () {
                              ProductChangeSate(widget.post.product);
                              setState(() {

                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(100),
                                color:
                                Colors.white.withOpacity(0.4),
                              ),
                              height: 60,
                              width: 60,
                              child: Padding(
                                padding:
                                const EdgeInsets.all(17.0),
                                child: SvgPicture.asset(
                                  "assets/icons/disable.svg",
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          )
                              : InkWell(
                            onTap: () {
                              ProductChangeSate(widget.post.product);
                              setState(() {

                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(100),
                                color:
                                Colors.white.withOpacity(0.4),
                              ),
                              height: 60,
                              width: 60,
                              child: Padding(
                                padding:
                                const EdgeInsets.all(17.0),
                                child: SvgPicture.asset(
                                  "assets/icons/enable.svg",
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          )
                              : !widget.post.product.isAvailable
                              ? SizedBox()
                              : InkWell(
                            onTap: () {
                              showAnimatedDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context)
                              {
                                return ClassicGeneralDialogWidget(
                                  titleText: 'Send a Trade offer',
                                  contentText:
                                  'You are asking for the an offer',
                                  positiveText: 'Send',
                                  positiveTextStyle: TextStyle(
                                      color: Colors.red),
                                  onPositiveClick: () {
                                    bool s = widget.post.product.staticPrice !=
                                        null;
                                    Message msg = Message(send: DateTime.now(),
                                        trade: Trade(sender: s
                                            ? widget.post.product.owner
                                            : currentUser,
                                          receiver: s ? currentUser : widget
                                              .post.product.owner,
                                          product: widget.post.product,
                                          amout: s ? widget.post.product
                                              .staticPrice! : 0,
                                          created: DateTime.now(),
                                          buyer: currentUser,
                                        ),
                                        sender: currentUser);
                                    Chat chat = Chat(
                                        user1: currentUser,
                                        user2: widget
                                            .post
                                            .product
                                            .owner,
                                        messages: []);

                                    if (chats.any((element) =>
                                    element
                                        .theOrther()
                                        .id == widget.post.product.owner.id)) {
                                      chat = chats.firstWhere((element) =>
                                      element
                                          .theOrther()
                                          .id == widget.post.product.owner.id);
                                    }
                                    updateChat(chat, msg);
                                    Navigator.of(context).pop;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Conversation(chat: chat),
                                      ),
                                    );
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     content: Text('Post deleted'),
                                    //   ),
                                    // );

                                    // Close the dialog
                                  },
                                  negativeText: 'Cancel',
                                  negativeTextStyle: TextStyle(
                                      color: Colors.black),
                                  onNegativeClick: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                );
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(100),
                                color:
                                Colors.white.withOpacity(0.4),
                              ),
                              height: 60,
                              width: 60,
                              child: Padding(
                                padding:
                                const EdgeInsets.all(17.0),
                                child: SvgPicture.asset(
                                  "assets/icons/plane.svg",
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                          widget.post.product.owner.id == currentUser.id ?
                          InkWell(
                            onTap: () {

                              deletePost(widget.post, context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(100),
                                color:
                                Colors.white.withOpacity(0.4),
                              ),
                              height: 60,
                              width: 60,
                              child: Padding(
                                padding:
                                const EdgeInsets.all(17.0),
                                child: SvgPicture.asset(
                                  "assets/icons/delete.svg",
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ) : SizedBox(),

                        ],
                      ),
                    ))
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                            AssetImage(widget.post.author.profile),
                            radius: 25,
                          ),
                          widget.post.author.isSellerTrue()
                              ? Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(2),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          )
                              : SizedBox(),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.author.username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            widget.post.isRepost
                                ? 'Repost from ${widget.post.product.owner
                                .username}'
                                : 'Original Owner',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.post.caption,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.post.product.description,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff00d289),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

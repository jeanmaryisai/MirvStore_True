// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../components/data.dart';
// import '../../models/comment.dart';
// import '../../models/notifs.dart';
// import '../../models/post.dart';
// import '../../utils.dart';
//
// class NotificationPage extends StatefulWidget {
//   @override
//   _NotificationPageState createState() => _NotificationPageState();
// }
//
// class _NotificationPageState extends State<NotificationPage> {
//   // List<NotificationCustom> notifications = [];
//   // ScrollController _scrollController = ScrollController();
//   // int pageSize = 20;
//   // bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // // Fetch initial notifications
//     // fetchNotifications();
//     // // Add scroll listener
//     // _scrollController.addListener(scrollListener);
//   }
//
//   // @override
//   // void dispose() {
//   //   _scrollController.dispose();
//   //   super.dispose();
//   // }
//
//   // void scrollListener() {
//   //   if (_scrollController.offset >=
//   //           _scrollController.position.maxScrollExtent &&
//   //       !_scrollController.position.outOfRange) {
//   //     // User reached the bottom of the list
//   //     loadMoreNotifications();
//   //   }
//   // }
//
//   // Future<void> fetchNotifications() async {
//   //   // Simulate API request
//   //   await Future.delayed(Duration(seconds: 2));
//
//   //   setState(() {
//   //     notifications.addAll(notifs.getRange(1, pageSize));
//   //   });
//   // }
//
//   // Future<void> loadMoreNotifications() async {
//   //   if (!isLoading) {
//   //     setState(() {
//   //       isLoading = true;
//   //     });
//
//   //     // Simulate API request
//   //     await Future.delayed(Duration(seconds: 2));
//
//   //     setState(() {
//   //       notifications.addAll(notifs.getRange(
//   //           notifications.length, notifications.length + pageSize));
//   //       isLoading = false;
//   //     });
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 3,
//         title:Text('Notification'),
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: SvgPicture.asset(
//               "assets/icons/back-arrow.svg",
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//
//       body: ListView.builder(
//         // controller: _scrollController,
//         itemCount: notifs.length,
//         itemBuilder: (context, index) {
//
//             NotificationCustom notif = notifs[index];
//             // Display notification item
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListTile(
//                 leading: Container(
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(50),
//                     color: Colors.white,
//                   ),
//                   height: 55,
//                   width: 55,
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: CircleAvatar(
//                       backgroundImage: AssetImage(
//                         notif.isAbout == null
//                             ? defaultimg
//                             : notif.isAbout!.profile,
//                       ),
//                     ),
//                   ),
//                 ),
//                 contentPadding: EdgeInsets.all(0),
//                 title: Text(
//                   notif.isAbout == null ? 'Mirv_Store' : notif.isAbout!.username,
//                 ),
//                 subtitle: Text(notif.message),
//                 onTap: () {},
//               ),
//             );
//
//         },
//       ),
//     );
//   }
// }
//
// // In this example, the comments list contains instances of the Comment class. Each comment h
//
import 'package:flutter/material.dart';

import '../../components/data.dart';
import '../../models/comment.dart';
import '../../models/post.dart';
import '../../utils.dart';

void showCommentDialog(BuildContext context, Post post) {
  showModalBottomSheet(
    showDragHandle: true,
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16.0),
      ),
    ),
    builder: (BuildContext context) {
      TextEditingController _controller = TextEditingController();
      return Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      addCommentToPost(_controller.text, post.myId);
                      _controller.clear();
                      // Add comment functionality
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Comment>>(
                stream: commentsStream.stream,
                initialData: getCommentsByPost(post.myId),// Replace `commentStream` with your actual comment stream
                builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
                  if (snapshot.hasData) {
                    List<Comment> comments = snapshot.data!;
                    return ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (BuildContext context, int index) {
                        Comment comment = comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(users.firstWhere((element) => element.myId==comment.author).profile),
                          ),
                          title: Text(
                            users.firstWhere((element) => element.myId==comment.author).username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            comment.comment,
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ),
          ],
        ),
      );
    },
  );
}

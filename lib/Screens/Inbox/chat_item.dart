import 'package:hello/Screens/Inbox/conversation.dart';
import 'package:flutter/material.dart';

import '../../components/data.dart';
import '../../models/chat.dart';

class ChatItem extends StatefulWidget {
  final Chat chat;

  ChatItem({
    Key? key,
    required this.chat
    ,
  }) : super(key: key);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    // print('elll');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
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
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                height: 55,
                width: 55,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "${users.firstWhere((element) => element.myId==widget.chat.theOrther()).profile}",
                    ),
                  ),
                ),
              ),
            ),
            // Positioned(
            //   bottom: 0.0,
            //   left: 6.0,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(6),
            //     ),
            //     height: 13,
            //     width: 13,
            //     child: Center(
            //       child: Container(
            //         decoration: BoxDecoration(
            //           color: widget.isOnline! ? Color(0xff651CE5) : Colors.grey,
            //           borderRadius: BorderRadius.circular(6),
            //         ),
            //         height: 9,
            //         width: 9,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        title: Text(
          "${users.firstWhere((element) => element.myId==widget.chat.theOrther()).username}",
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.chat.getMessagesOrderedByMostRecent().first.captionSTR(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              "${widget.chat.messages.first.timeAgo()}",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 11,
              ),
            ),
            SizedBox(height: 5),
                SizedBox()
                // : Container(
                //     padding: EdgeInsets.all(1),
                //     decoration: BoxDecoration(
                //       color: Color(0xff00d289),
                //       borderRadius: BorderRadius.circular(6),
                //     ),
                //     constraints: BoxConstraints(
                //       minWidth: 11,
                //       minHeight: 11,
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.only(top: 1, left: 5, right: 5),
                //       child: Text(
                //         "${widget.counter}",
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 10,
                //         ),
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   ),
          ],
        ),
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Conversation(
                  chat:widget.chat
                );
              },
            ),
          );
        },
      ),
    );
  }
}

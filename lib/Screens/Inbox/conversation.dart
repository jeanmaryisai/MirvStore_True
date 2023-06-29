import 'dart:math';
import 'package:hello/Screens/Inbox/chat_bubble.dart';
import 'package:hello/components/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/chat.dart';
import '../../models/message.dart';
import '../../utils.dart';

class Conversation extends StatefulWidget {
  final Chat chat;

  Conversation({
    Key? key,
    required this.chat,
  }) : super(key: key);
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  static Random random = Random();
  String name = names[random.nextInt(10)];
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String _userInput = '';
    TextEditingController controller = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(
                "assets/icons/back-arrow.svg",
                color: Colors.black,
              ),
            ),
          ),
          titleSpacing: 0,
          title: InkWell(
            child: Row(
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
                    height: 45,
                    width: 45,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          "${widget.chat.theOrther().profile}",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.chat.theOrther().username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          actions: <Widget>[
            SvgPicture.asset(
              "assets/icons/dots.svg",
              height: 5,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Flexible(
                child:
                StreamBuilder<List<Chat>>(
                  stream: chatsStream.stream,
                  initialData: chats,
                  builder: (BuildContext context, AsyncSnapshot<List<Chat>> snapshot) {
                    if (snapshot.hasData) {
                      List<Chat> chats = snapshot.data!;

                      if (chats.isNotEmpty) {
                        Chat? chat;
                        try {
                          chat = chats.firstWhere((element) => element.id == widget.chat.id);
                        } catch (e) {
                          // Handle case when chat is not found
                          return Center(
                            child: Text('Respect privacy'),
                          );
                        }

                        if (chat != null && chat.messages.isNotEmpty) {
                          List<Message> messages = chat.messages;

                          return ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            itemCount: messages.length,
                            reverse: true,
                            itemBuilder: (BuildContext context, int index) {
                              Message msg = messages[index];
                              return ChatBubble(msg: msg, chatid: widget.chat.id, refresh: () => setState(() {}));
                            },
                          );
                        } else {
                          // Handle case when chat or messages list is empty
                          return Center(
                            child: Text('No messages found.'),
                          );
                        }
                      } else {
                        // Handle case when chats list is empty
                        return Center(
                          child: Text('Respect privacy'),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )


                //       StreamBuilder<List<Chat>>(
          // stream: chatsStream.stream,
          //   initialData: chats,
          //   builder: (BuildContext context, AsyncSnapshot<List<Chat>> snapshot) {
          //
          //     if (snapshot.hasData) {
          //       List<Message> messages = snapshot.data!.firstWhere((element) => element.id==widget.chat.id).messages;
          //       return ListView.builder(
          //         controller: _scrollController,
          //         padding: EdgeInsets.symmetric(horizontal: 10),
          //         itemCount: messages.length,
          //         reverse: true,
          //         itemBuilder: (BuildContext context, int index) {
          //           Message msg = messages[index];
          //           return ChatBubble(msg: msg,chatid: widget.chat.id, refresh: () => setState(() {}));
          //         },
          //       );
          //     } else if (snapshot.hasError) {
          //       return Text('Error: ${snapshot.error}');
          //     } else {
          //       return CircularProgressIndicator();
          //     }
          //   },
          // ),
            // In this example, we introduced the getMessagesOrderedByMostRecentStream() function, which retrieves the message stream ordered by the most recent for a specific chat. We then use this stream in the StreamBuilder to update the chat messages automatically.

      // Make sure to adjust the code according to your actual data structure and implementation.







      ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomAppBar(
                  elevation: 10,
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: 100,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            // color: Theme.of(context).accentColor,
                          ),
                          onPressed: () {},
                        ),
                        Flexible(
                          child: TextField(
                            controller: controller,
                            style: TextStyle(
                              fontSize: 15.0,
                              color:
                                  Theme.of(context).textTheme.headline6!.color,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: "Write your message...",
                              hintStyle: TextStyle(
                                fontSize: 15.0,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .color,
                              ),
                            ),
                            onChanged: (value) {
                              // Update the userInput variable whenever the text field value changes
                              _userInput = value;
                            },
                            maxLines: null,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                          ),
                          onPressed: () {
                            if (_userInput == '') {
                              Fluttertoast.showToast(
                                  msg:
                                      'Vous pouvez pas envoyer un message vide');
                            } else {
                              Message _message = Message(
                                sender: currentUser,
                                message: _userInput,
                                send: DateTime.now(),
                              );
                              controller.clear();
                              updateChat(widget.chat, _message);
                              setState(() {});
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

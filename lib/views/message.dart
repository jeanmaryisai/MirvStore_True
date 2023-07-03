import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello/utils/myTextStyle.dart';
import 'package:hello/widgets/messageWidget.dart';

import '../size_config.dart';

class Message extends StatefulWidget {
  final String sender;
  final String avatarUrl;
  final String time;
  final String content;
  final int number;
  final bool online;

  const Message(
      {required this.sender,
      required this.avatarUrl,
      required this.time,
      required this.content,
      required this.number,
      required this.online});

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //scren util initialization
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;


    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      //
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      ),
                      CircleAvatar(
                          backgroundImage: NetworkImage(widget.avatarUrl)),
                      SizedBox(width: 5.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.sender,
                            style: myStyle(
                                fontSize: 15.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4.0),
                          Text(widget.online ? 'online' : 'offline',
                              style: myStyle(color: Colors.grey))
                        ],
                      )
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert, size: 30, color: Colors.grey),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          Container(
            height: size.height * 0.87,
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(22),
                    vertical: getProportionateScreenWidth(10)),
                child: Wrap(
                  children: [
                    MessageWidget(
                        alignment: Alignment.topLeft,
                        size: size,
                        content: widget.content,
                        color: Colors.blue[50]),
                    SizedBox(
                      height: 3,
                    ),
                    MessageWidget(
                      alignment: Alignment.topLeft,
                      size: size,
                      content:
                          'i am thinking to take it!!.Like sooooe wiowedoeodoskdo',
                      color: Colors.blue[50],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(widget.time,
                            style:
                                myStyle(fontSize: 11.0, color: Colors.grey))),
                    SizedBox(
                      height: 30,
                    ),
                    MessageWidget(
                        content: 'Heynckm mewimd p oewe ew igrj opooo',
                        size: size,
                        textColor: Colors.white,
                        alignment: Alignment.topRight,
                        color: Theme.of(context).primaryColor),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(widget.time,
                            style: myStyle(fontSize: 11.0, color: Colors.grey)),
                        FaIcon(FontAwesomeIcons.checkDouble,
                            color: Theme.of(context).primaryColor, size: 15.0)
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                // top:0.0,
                // bottom:0.0,
                left: 0.0, right: 0.0,
                child: Container(
                  height: 60,
                  color: Colors.grey[300],
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Icon(Icons.add, color: Colors.grey, size: 30.0),
                        ),
                        MessageTextWidget(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: IconButton(
                              icon: Icon(Icons.send,
                                  color: Colors.white, size: 20),
                              onPressed: () {},
                            ),
                          ),
                        )
                      ]),
                ),
              )
            ]),
          )
        ],
      ),
    ));
  }
}

class MessageTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      // width: size.width - 200,
      // height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
            color: Colors.white,
            height: 40,
            child: TextField(
                decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ))),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hello/models/message.dart';
import 'package:hello/utils/myTextStyle.dart';
import 'package:hello/utils/routes.dart';
import 'package:hello/widgets/messagesCard.dart';

import '../size_config.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;


    return Scaffold(
        appBar: AppBar(
          title: Text('Inbox', style: myStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: Icon(Icons.search, color: Colors.grey, size: 30),
                  onPressed: () {}), 
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(10),
              vertical: getProportionateScreenWidth(10)),
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(),
              shrinkWrap: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                return GestureDetector(
                    onTap: () => gotoMessage(context, message),
                    child: MessagesCard(size: size, message: message));
              }),
        ));
  }

  gotoMessage(context, message) {
    Navigator.of(context).pushNamed(MessageViewRoute,
        arguments: Message1(
            sender: message.sender,
            avatarUrl: message.avatarUrl,
            time: message.time,
            content: message.content,
            number: message.number,
            online: message.online));
  }
}

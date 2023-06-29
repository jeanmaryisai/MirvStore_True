import 'package:flutter/material.dart';
import 'package:hello/models/notification.dart';
import 'package:hello/utils/myTextStyle.dart';
import 'package:hello/widgets/notificationCard.dart';

import '../size_config.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;


    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: myStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(8),
              vertical: getProportionateScreenWidth(10)),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  var notification = notifications[index];
                  return NotificationCard(
                      size: size, notification: notification);
                },
              ),
              Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.grey[100],
                    height: size.height * 0.07,
                    // width: size.width -200,
                    child: Text(
                      'Older Notification',
                      style: myStyle(fontSize: 13.0),
                    ),
                  ),
                ),
              ),
            ],
          )),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: Container(
      //     width: size.width - 200,
      //     child:
      //         FlatButton(child: Text('Older Notification'), onPressed: () {}),
      //   ),
      // ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hello/models/newsfeed.dart';
import 'package:hello/utils/myTextStyle.dart';
import 'package:hello/widgets/newsFeedCard.dart';

import '../size_config.dart';

class NewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;


    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.blueGrey[100],
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('All Categories',
                                  style: myStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600)),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                          SizedBox(height: 5),
                          Text('Chicago, IL 60611, USA',
                              style: myStyle(color: Colors.grey))
                        ],
                      ),
                      Icon(Icons.search, size: 30, color: Colors.grey)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: newsfeed.length,
                    itemBuilder: (context, index) {
                      var nf = newsfeed[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(8)),
                        child: NewsFeedCard(
                          size: size,
                          nf: nf,
                          index: index,
                        ),
                      );
                    }),
              )
            ],
          )),
    );
  }
}

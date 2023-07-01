import 'package:flutter/material.dart';
import 'package:hello/components/data.dart';

import '../../../models/post.dart';
import '../../../utils.dart';

class RepostDialog extends StatelessWidget {
  final Post post;

  RepostDialog({required this.post});
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(users.firstWhere((element) => element.myId== products.firstWhere((element) => element.myId== post.product).owner).profile),
                        radius: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            users.firstWhere((element) => element.myId==products.firstWhere((element) => element.myId ==post.product).owner).username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            "This is the ${products.firstWhere((element) => element.myId ==post.product).title} put on the market by ${users.firstWhere((element) => element.myId==products.firstWhere((element) => element.myId ==post.product).owner).username}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 189, 187, 187),
                              fontSize: 10,
                            ),
                          ),
                          products.firstWhere((element) => element.myId ==post.product).isSold
                              ? Text(
                                  "This product is already sold by ${users.firstWhere((element) => element.myId==products.firstWhere((element) => element.myId ==post.product).owner).username}, you can wiew it but no one can but it annymore",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 189, 187, 187),
                                    fontSize: 10,
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "When you repost a Product, anyone who is interested by it will be automatically be redirected by the owner, but you will keep the likes on your page",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 189, 187, 187),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Thumbnail of the post
            Container(
              height: 120,
              child: Image.asset(
                products.firstWhere((element) => element.myId ==post.product).image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            // Caption input field

            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Write a caption...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            // Repost icon and button
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      repost(post.myId, _controller.text);
                      // TODO: Handle post logic
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text('Repost'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

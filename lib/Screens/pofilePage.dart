import 'package:flutter/material.dart';

import '../components/data.dart';

class Post1 {
  final String myId;
  // Add more properties as needed

  Post1({required this.myId});
}

class PostGridPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post Grid')),
      body: GridView.count(
        crossAxisCount: 3,
        children: posts.map((post) {
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => FeedPage(selectedPost: post),
              //   ),
              // );
            },
            child: Container(
              // Customize the grid item's appearance as needed
              margin: EdgeInsets.all(10),
              color: Colors.grey,
              child: Center(child: Text(post.myId)),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class FeedPage extends StatelessWidget {
  final Post1 selectedPost;

  FeedPage({required this.selectedPost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feed')),
      body: ListView.builder(
        itemCount: 20, // Example count, replace with actual count
        itemBuilder: (context, index) {
          // Generate a unique key for each list item
          Key itemKey = UniqueKey();

          if (index == 0) {
            // Show the selected post at the specified position
            if (selectedPost != null) {
              return Column(
                children: [
                  ListTile(
                    key: itemKey,
                    title: Text('Post ${selectedPost.myId}'),
                    // Customize the post item's appearance as needed
                    // You can use the selectedPost object to display the relevant data
                  ),
                  // Other list items
                ],
              );
            }
          }

          // Other list items
          return ListTile(key: itemKey, title: Text('Post $index'));
        },
      ),
    );
  }
}

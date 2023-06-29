import 'package:hello/utils.dart';
import 'package:flutter/material.dart';

import 'components/data.dart';
import 'models/user.dart';

Future<List<User>> fetchUsers() async {
  // Simulating an asynchronous operation
  await Future.delayed(Duration(seconds: 2));

  // Return a list of users
  return users;
}

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: fetchUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to complete, show a spinner
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
          );
        } else if (snapshot.hasError) {
          // If there was an error while fetching the data, show an error message
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          // If the future completed successfully, display the list of users
          final List<User> users = snapshot.data ?? [];
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              User friend = users[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 10),
                child: ListTile(
                  leading: Container(
                    // Customize the leading container's appearance as needed
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
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
                        backgroundImage: AssetImage(friend.profile),
                      ),
                    ),
                  ),
                  contentPadding: EdgeInsets.all(0),
                  title: Text(friend.username),
                  subtitle: Text(friend.bio),
                  trailing: getFollowerInfo(currentUser, friend)['iFollow']!
                      ? Container(
                          // Customize the trailing container's appearance as needed
                          width: 100.0,
                          height: 38.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff651CE5).withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(0, 5),
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: [0.1, 0.9],
                              colors: [
                                Colors.black.withOpacity(0.5),
                                Colors.grey,
                              ],
                            ),
                          ),
                          child: TextButton(
                            child: Text(
                              'UnFollow',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.transparent),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            onPressed: () {},
                          ),
                        )
                      : Container(
                          // Customize the trailing container's appearance as needed
                          width: 100.0,
                          height: 38.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff651CE5).withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(0, 5),
                              ),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: [0.1, 0.9],
                              colors: [
                                Color(0xff651CE5),
                                Color(0xff811ce5),
                              ],
                            ),
                          ),
                          child: TextButton(
                            child: Text(
                              'Follow',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.transparent),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                  onTap: () {},
                ),
              );
            },
          );
        }
      },
    );
  }
}

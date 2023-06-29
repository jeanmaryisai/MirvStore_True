import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:hello/Screens/Inbox/chat_item.dart';
import 'package:hello/Screens/Inbox/conversation.dart';
import 'package:hello/components/Custom_NavBar.dart';
import 'package:hello/components/data.dart';
import 'package:hello/components/enums.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../models/chat.dart';
import '../../models/user.dart';

class InboxScreen extends StatefulWidget {
  static String routeName = "/inbox";

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<InboxScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: InkWell(
                      onTap: (){showUserListDialog(context);},
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              height: 55,
                              width: 55,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff651CE5),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Text(
                            "Start Conversation",
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: StreamBuilder<List<Chat>>(
                    initialData: getChatsOrderedByMostRecent(),
                    stream: chatsStream.stream,
                    // Replace `chatStream` with your actual chat stream
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Chat>> snapshot) {
                      if (snapshot.hasData) {
                        List<Chat> chats = getChatsOrderedByMostRecent();
                        return ListView.builder(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          itemCount: chats.length,
                          itemBuilder: (BuildContext context, int index) {
                            Chat chat = chats[index];
                            return ChatItem(
                              chat: chat,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  )),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: CustomNavBar(
                selectedMenu: MenuState.inbox,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class UserListDialog extends StatefulWidget {
  final List<User> users;

  UserListDialog({required this.users});

  @override
  _UserListDialogState createState() => _UserListDialogState();
}

class _UserListDialogState extends State<UserListDialog>
    with SingleTickerProviderStateMixin {
  List<User> filteredUsers = [];
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    filteredUsers = widget.users;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  void _filterUsers(String query) {
    setState(() {
      filteredUsers = widget.users.where((user) {
        final username = user.username.toLowerCase();
        return username.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: AnimatedBuilder(
        animation: _slideAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0.0, (1 - _slideAnimation.value) * 300),
            child: Opacity(
              opacity: _slideAnimation.value,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: _filterUsers,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        User user = filteredUsers[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(user.profile),
                          ),
                          title: Text(user.username),
                          onTap: () {
                            Chat chat = Chat(
                                user1: currentUser, user2: user, messages: []);
                            chats.any((element) =>
                                    element.theOrther().id == user.id)
                                ? chat = chats.firstWhere((element) =>
                                    element.theOrther().id == user.id)
                                : print('no ${chat.messages.length}');
                            Navigator.of(context).pop;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Conversation(chat: chat),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
void showUserListDialog(BuildContext context) {
  showAnimatedDialog(
    context: context,
    builder: (context) => UserListDialog(users: users),
    animationType: DialogTransitionType.slideFromBottomFade,
    curve: Curves.easeInOut,
    duration: Duration(milliseconds: 500),
  );
}
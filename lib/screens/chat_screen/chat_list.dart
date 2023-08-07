import 'package:flutter/material.dart';
import 'package:talkaro/screens/chat_screen/widgets.dart';
import 'package:talkaro/utils/colors.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            color: ktheme,
            child: CircleAvatar(radius: 80, backgroundColor: kblack),
          )
        ],
      )),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: kblack,
            )),
        backgroundColor: kAppbarWhite,
        title: AppBarTitle(title: 'Talkaro'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
              color: kblack,
            ),
            onPressed: () {},
          ),
        ],
      ),
      
    );
  }
}

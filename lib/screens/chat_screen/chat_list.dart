import 'package:flutter/material.dart';
import 'package:talkaro/screens/chat_screen/widgets/tab1_widgets.dart';
import 'package:talkaro/screens/chat_screen/widgets/tab2_widgets.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/main_widgets.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        floatingActionButton: Align(
          widthFactor: 2.1,
          heightFactor: 3.8,
          child: FloatingActionButton(
              backgroundColor: ktheme,
              onPressed: () {},
              child: Icon(
                Icons.add,
                size: 30,
              )),
        ),
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  size: 30,
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
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: kblack,
                    size: 30,
                  ))
            ],
            bottom: TabBar(
                unselectedLabelColor: ktheme,
                isScrollable: true,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: ktheme),
                tabs: const [
                  Tab(
                    child: SizedBox(
                      height: 50,
                      width: 150,
                      child: Center(
                        child: Text(
                          "Chats",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: Center(
                      child: Tab(
                        child: Text(
                          "group",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  )
                ]),
          ),
        ),
        body: TabBarView(children: const [
          Tab1(),
          Tab2(),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:talkaro/screens/chat_screen/widgets/drawer.dart';
import 'package:talkaro/screens/chat_screen/widgets/tab1_widgets.dart';
import 'package:talkaro/screens/chat_screen/widgets/tab2_widgets.dart';
import 'package:talkaro/screens/chat_screen/widgets/tabs_style.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/main_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        floatingActionButton: Align(
          heightFactor: 2.8,
          widthFactor: 2,
          child: FloatingActionButton(
              backgroundColor: ktheme,
              onPressed: () {},
              child: Icon(
                Icons.add_comment,
                size: 30,
                color: kwhite,
              )),
        ),
        drawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            backgroundColor: kAppbarWhite,
            title: AppBarTitle(title: 'Talkaro'),
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: kblack,
                ),
                onPressed: () {},
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: kblack,
                  ))
            ],
            bottom: TabBar(
                unselectedLabelColor: ktheme,
                isScrollable: true,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: ktheme),
                tabs: const [
                  CustomTab(tabtitle: "Chats"),
                  CustomTab(tabtitle: "Calls")
                ]),
          ),
        ),
        body: TabBarView(children: const [
          ChatsTab(),
          CallsTab(),
        ]),
      ),
    );
  }
}

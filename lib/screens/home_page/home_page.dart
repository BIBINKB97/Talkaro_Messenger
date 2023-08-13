import 'package:flutter/material.dart';
import 'package:talkaro/screens/home_page/widgets/drawer.dart';
import 'package:talkaro/screens/home_page/widgets/tab1_widgets.dart';
import 'package:talkaro/screens/home_page/widgets/tab2_widgets.dart';
import 'package:talkaro/screens/home_page/widgets/tabs_style.dart';
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
          preferredSize: Size.fromHeight(110),
          child: AppBar(
            backgroundColor: ktheme,
            title: AppBarTitle(title: 'Talkaro'),
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: kwhite,
                ),
                onPressed: () {},
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: kwhite,
                  ))
            ],
            bottom: TabBar(
                unselectedLabelColor: kblack,
                isScrollable: true,
                indicatorColor: kwhite,
                tabs: const [
                  CustomTab(tabtitle: "Chats"),
                  CustomTab(tabtitle: "Calls"),
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

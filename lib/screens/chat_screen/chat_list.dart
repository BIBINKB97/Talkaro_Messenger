import 'package:flutter/material.dart';
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
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
              },
              child: Icon(
                Icons.add_comment,
                size: 30,
                color: kwhite,
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

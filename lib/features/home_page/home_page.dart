import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/features/home_page/widgets/search_chat.dart';
import 'package:talkaro/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:talkaro/features/home_page/widgets/drawer.dart';
import 'package:talkaro/features/home_page/widgets/contact_list_tab1.dart';
import 'package:talkaro/features/home_page/widgets/tab2_widgets.dart';
import 'package:talkaro/features/authentication/controller/auth_controller.dart';

import 'package:talkaro/utils/colors.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

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
                Navigator.pushNamed(context, SelsectContactScreen.routeName);
              },
              child: Icon(
                Icons.add_comment,
                size: 25,
                color: kwhite,
              )),
        ),
        drawer: CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: AppbarWithSearch(),
        ),
        body: TabBarView(children: const [
          ContactsList(),
          CallsTab(),
        ]),
      ),
    );
  }
}

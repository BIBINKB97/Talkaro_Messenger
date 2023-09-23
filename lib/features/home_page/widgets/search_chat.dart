
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/features/group_chat/screens/create_group_screen.dart';
import 'package:talkaro/features/home_page/widgets/tab_style.dart';
import 'package:talkaro/features/select_contacts/controller/select_contact_controller.dart';
import 'package:talkaro/utils/colors.dart';

class AppbarWithSearch extends ConsumerStatefulWidget {
  const AppbarWithSearch({super.key});

  @override
  ConsumerState<AppbarWithSearch> createState() => _AppbarWithSearchState();
}

class _AppbarWithSearchState extends ConsumerState<AppbarWithSearch> {
  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.white,
    size: 25,
  );
  Widget customSearchBar = const Text(
    "Talkaro",
    style: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
  );
  TextEditingController searchController = TextEditingController();

  List<Contact> filteredContactList = [];

  void filterChatContacts(String query) {
    final contactList = ref.read(getContactsProvider);
    setState(() {
      if (query.isEmpty) {
        filteredContactList = contactList.value!;
      } else {
        filteredContactList = contactList.value!
            .where((contact) =>
                contact.displayName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: customSearchBar,
      toolbarHeight: 70,
      elevation: 1,
      backgroundColor: ktheme,
      actions: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              if (customIcon.icon == Icons.search) {
                customIcon = Icon(
                  Icons.cancel,
                  color: Colors.white,
                  size: 23,
                );
                customSearchBar = TextField(
                  onChanged: (query) {
                    filterChatContacts(query);
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      fillColor: kwhite,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: kblack)),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                );
              } else {
                customIcon = Icon(
                  Icons.search,
                  size: 25,
                  color: Colors.white,
                );
                customSearchBar = Text(
                  "Talkaro",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                );
              }
            });
          },
          child: SizedBox(
            width: 50,
            child: customIcon,
          ),
        ),
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text('Create Group'),
              onTap: () => Future(
                () => Navigator.pushNamed(
                  context,
                  CreateGroupScreen.routeName,
                ),
              ),
            ),
          ],
        )
      ],
      bottom: TabBar(
          unselectedLabelColor: kblack,
          isScrollable: true,
          indicatorColor: kwhite,
          tabs: const [
            CustomTab(tabtitle: "Chats"),
            CustomTab(tabtitle: "Calls"),
          ]),
    );
   
  }
}

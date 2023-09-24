import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/widgets/error.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/features/select_contacts/controller/select_contact_controller.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class SearchContacts extends ConsumerStatefulWidget {
  static const String routeName = '/search-contacts';
  const SearchContacts({super.key});

  @override
  ConsumerState<SearchContacts> createState() => _SearchContactsState();
}

class _SearchContactsState extends ConsumerState<SearchContacts> {
  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.white,
    size: 25,
  );
  Widget customSearchBar = const Text(
    "Select Contact",
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

  void selectContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) {
    ref
        .read(selectContactControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: customSearchBar,
          centerTitle: true,
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
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
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
                      "Select Contact",
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
            kwidth20,
          ],
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(80), child: TextField())),
      body: ref.watch(getContactsProvider).when(
          data: (contactList) => ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                final contact = contactList[index];
                return InkWell(
                  onTap: () => selectContact(ref, contact, context),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      leading: contact.photo == null
                          ? null
                          : CircleAvatar(
                              backgroundImage: MemoryImage(contact.photo!),
                              radius: 30,
                            ),
                      title: Text(
                        contact.displayName,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              }),
          error: (err, trace) => ErrorScreen(error: err.toString()),
          loading: () => Loader()),
    );
  }
}

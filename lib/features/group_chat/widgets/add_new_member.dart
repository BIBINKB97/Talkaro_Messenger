import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/widgets/error.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/features/chat/controller/chat_controller.dart';
import 'package:talkaro/features/group_chat/controller/group_controller.dart';
import 'package:talkaro/features/group_chat/widgets/select_contacts_group.dart';
import 'package:talkaro/features/select_contacts/controller/select_contact_controller.dart';
import 'package:talkaro/models/group.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class AddNewMember extends ConsumerStatefulWidget {
  static const String routeName = '/add-new';

  final String groupId;

  const AddNewMember(this.groupId, {super.key});

  @override
  ConsumerState<AddNewMember> createState() => _AddNewMemberState();
}

class _AddNewMemberState extends ConsumerState<AddNewMember> {
  final TextEditingController groupnameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    groupnameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ktheme,
        title: Text('Add new Member'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<GroupModel>(
        future: ref.read(chatControllerProvider).fetchGroupData(widget.groupId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Loader(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error fetching data"),
            );
          }
          var groupdata = snapshot.data;
          return Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                Stack(
                  children: [
                    CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(groupdata!.groupPic)),
                  ],
                ),
                kheight10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: klight3,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          groupdata.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                kheight20,
                Text(
                  'Select Contacts',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Divider(
                  thickness: 1,
                ),
                SelectContactsGroup(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<String> selectedContsctsUid = [];
          ref.watch(getContactsProvider).when(
              data: (contactList) {
                for (int i = 0; i <= contactList.length; i++) {
                  if (selectedContactsIndex.contains(i)) {
                    selectedContsctsUid.add(
                      contactList[i].phones[0].number.replaceAll(
                            ' ',
                            '',
                          ),
                    );
                  }
                }
                return;
              },
              error: (err, trace) => ErrorScreen(error: err.toString()),
              loading: () => const Loader());
          ref
              .read(groupControllerProvider)
              .addnewMember(context, widget.groupId, selectedContsctsUid);
        },
        backgroundColor: ktheme,
        child: Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    );
  }
}

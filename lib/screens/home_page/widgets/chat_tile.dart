import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/models/chat_contact.dart';
import 'package:talkaro/screens/chat_screen/controler/chat_controller.dart';
import 'package:talkaro/utils/colors.dart';

class ChatTile extends ConsumerWidget {
  const ChatTile(
      {super.key,
      required this.name,
      required this.messege,
      required this.time,
      required this.profilePic});
  final String name;
  final String messege;
  final String time;
  final ImageProvider profilePic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        child: Column(children: [
      StreamBuilder<List<ChatContact>>(
          stream: ref.watch(chatControllerProvider).chatContacts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }

            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var chatContactData = snapshot.data![index];

                  return ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundImage: profilePic,
                    ),
                    title: Text(
                      chatContactData.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      chatContactData.lastMessege,
                      style: TextStyle(color: kblack),
                    ),
                    trailing: Text(
                      DateFormat.Hm().format(chatContactData.timeSent),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  );
                });
          })
    ]));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/models/chat_contact.dart';
import 'package:talkaro/screens/chat_screen/chat_screen.dart';
import 'package:talkaro/screens/chat_screen/controler/chat_controller.dart';
import 'package:talkaro/screens/home_page/widgets/chat_tile.dart';

class ContactList extends ConsumerWidget {
  static const String routeName = '/chat-screen';
  const ContactList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(builder: (context) {
      return StreamBuilder<List<ChatContact>>(
          stream: ref.watch(chatControllerProvider).chatContacts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader();
            }
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var chatContactData = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ChatScreen.routeName,
                      arguments: {
                        'name': chatContactData.name,
                        'uid': chatContactData.contactId,
                      },
                    );
                  },
                  child: ChatTile(
                    profilePic: NetworkImage(chatContactData.profilePic),
                    name: chatContactData.name,
                    message: chatContactData.lastMessege,
                    time: DateFormat.Hm().format(chatContactData.timeSent),
                  ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          });
    });
  }
}

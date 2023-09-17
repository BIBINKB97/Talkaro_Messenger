import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/features/chat/widgets/bottom_text_box.dart';
import 'package:talkaro/models/user_model.dart';
import 'package:talkaro/features/chat/widgets/chat_list.dart';
import 'package:talkaro/features/authentication/controller/auth_controller.dart';
import 'package:talkaro/features/profile/view_profile/view_profile.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';
import 'package:talkaro/utils/main_widgets.dart';

class ChatScreen extends ConsumerWidget {
  static const String routeName = '/inbox-screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  const ChatScreen({
    super.key,
    required this.name,
    required this.uid,
    required this.isGroupChat
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: ktheme,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  "images/user.png",
                ),
              ),
            ),
            title: isGroupChat? AppBarTitle(title: name) : InkWell(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ViewProfile())),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<UserModel>(
                      stream:
                          ref.read(authControllerProvider).userDataById(uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Loader();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppBarTitle(title: name),
                            Text(
                              snapshot.data!.isOnline ? 'online' : 'offline',
                              style: TextStyle(color: kwhite, fontSize: 16),
                            )
                          ],
                        );
                      }),
                ],
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.call_rounded,
                      color: kwhite,
                    ),
                    kwidth20,
                    Icon(
                      Icons.videocam_rounded,
                      color: kwhite,
                    ),
                    kwidth20,
                    Icon(
                      Icons.more_vert,
                      color: kwhite,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatList(
                recieverUserId: uid,
              ),
            ),
            BottomTextBox(recieverUserId: uid)
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/features/calls/controller/call_controller.dart';
import 'package:talkaro/features/calls/screen/call_pickup_screen.dart';
import 'package:talkaro/features/chat/widgets/bottom_text_box.dart';
import 'package:talkaro/features/group_chat/controller/group_controller.dart';
import 'package:talkaro/features/group_chat/widgets/add_new_member.dart';
import 'package:talkaro/models/group.dart';
import 'package:talkaro/models/user_model.dart';
import 'package:talkaro/features/chat/widgets/chat_list.dart';
import 'package:talkaro/features/authentication/controller/auth_controller.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

final counterProvider = StateProvider<bool>((ref) => false);

class ChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat;
  final String? profilePic;

  const ChatScreen({
    Key? key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    required this.profilePic,
  }) : super(key: key);

  void makeVideoCall(WidgetRef ref, BuildContext context) {
    ref.read(callControllerProvider).makeVideoCall(
          context,
          name,
          uid,
          profilePic!,
          isGroupChat,
        );
  }

  void makeAudioCall(WidgetRef ref, BuildContext context) {
    ref.read(callControllerProvider).makeAudioCall(
          context,
          name,
          uid,
          profilePic!,
          isGroupChat,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CallPickupScreen(
      scaffold: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ktheme,
          title: isGroupChat
              ? StreamBuilder<GroupModel>(
                  stream: ref.read(groupControllerProvider).groupDatabyId(uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
                    var userdata = snapshot.data;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 22,
                            )),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(userdata.groupPic)),
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(userdata!.groupPic),
                            backgroundColor: Colors.grey,
                            radius: 25,
                          ),
                        ),
                        kwidth20,
                        Text(
                          name,
                          style: TextStyle(fontSize: 20),
                        ),
                        kwidth60,
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddNewMember(uid),
                            ));
                          },
                          icon: const Icon(Icons.person_add),
                        ),
                      ],
                    );
                  },
                )
              : StreamBuilder<UserModel>(
                  stream: ref.read(authControllerProvider).userDataById(uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
                    var userdata = snapshot.data;
                    return Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 22,
                            )),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(userdata.profilePic)),
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(userdata!.profilePic),
                            backgroundColor: Colors.grey,
                            radius: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(snapshot.data!.isOnline ? 'online' : 'offline',
                                style: const TextStyle(
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ],
                    );
                  },
                ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {
                makeVideoCall(ref, context);
              },
              icon: Icon(Icons.videocam_rounded),
            ),
            IconButton(
              onPressed: () {
                makeAudioCall(ref, context);
              },
              icon: Icon(Icons.call),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatList(
                recieverUserId: uid,
                isGroupChat: isGroupChat,
              ),
            ),
            BottomTextBox(
              recieverUserId: uid,
              isGroupChat: isGroupChat,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/config/agora_config.dart';
import 'package:talkaro/features/calls/controller/call_controller.dart';
import 'package:talkaro/models/call_model.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class AudioCallScreen extends ConsumerStatefulWidget {
  final String channelId;
  final Call call;
  final bool isGroupChat;
  const AudioCallScreen({
    Key? key,
    required this.channelId,
    required this.call,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AudioCallScreenState();
}

class _AudioCallScreenState extends ConsumerState<AudioCallScreen> {
  AgoraClient? client;
  String baseUrl = 'https://talkaro-calling-service.onrender.com';

  late Timer callTimer;
  int secondsElapsed = 0;
  bool isCallConnected = false;

  @override
  void initState() {
    super.initState();
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: widget.channelId,
        tokenUrl: baseUrl,
      ),
    );
    initAgora();
    startCallTimer();
  }

  void initAgora() async {
    await client!.initialize();
    client!.engine.enableLocalVideo(false);
  }

  void startCallTimer() {
    if (isCallConnected) {
      callTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          secondsElapsed++;
        });
      });
    }
  }

  @override
  void dispose() {
    callTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: client == null
          ? const Loader()
          : StreamBuilder<DocumentSnapshot>(
              stream: ref.watch(callControllerProvider).callStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.data() != null) {
                  Call call = Call.fromMap(
                      snapshot.data!.data() as Map<String, dynamic>);

                  return SafeArea(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        AgoraVideoViewer(client: client!),
                        Center(
                          child: Column(
                            children: [
                              kheight80,
                              kheight80,
                              Text(
                                call.receiverName,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                              kheight10,
                              Text(
                                _formatDuration(secondsElapsed),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              kheight80,
                              kheight30,
                              CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage(call.receiverPic),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 30,
                            child: IconButton(
                                onPressed: () async {
                                  await client!.engine.leaveChannel();
                                  ref.read(callControllerProvider).endCall(
                                        widget.call.callerId,
                                        widget.call.receiverId,
                                        context,
                                      );
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.call_end,
                                  color: kwhite,
                                )),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              }),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

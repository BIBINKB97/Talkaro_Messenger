// ignore_for_file: use_build_context_synchronously

import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/config/agora_config.dart';
import 'package:talkaro/features/calls/controller/call_controller.dart';
import 'package:talkaro/models/call_model.dart';
import 'package:talkaro/utils/colors.dart';

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
  }

  void initAgora() async {
    await client!.initialize();
    client!.engine.enableLocalVideo(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: client == null
          ? const Loader()
          : SafeArea(
              child: Stack(
                children: [
                  AgoraVideoViewer(client: client!),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: ktheme,
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
                            icon: Icon(
                              Icons.call_end,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talkaro/common/enums/messege_enum.dart';
import 'package:talkaro/common/providers/message_replay_provider.dart';
import 'package:talkaro/common/utils/utils.dart';
import 'package:talkaro/features/chat/controller/chat_controller.dart';
import 'package:talkaro/features/chat/widgets/message_replay_preview.dart';
import 'package:talkaro/utils/colors.dart';

class BottomTextBox extends ConsumerStatefulWidget {
  final String recieverUserId;
  const BottomTextBox({
    super.key,
    required this.recieverUserId,
  });

  @override
  ConsumerState<BottomTextBox> createState() => _BottomTextBoxState();
}

class _BottomTextBoxState extends ConsumerState<BottomTextBox> {
  bool isShowSendButton = false;
  final TextEditingController _messegeController = TextEditingController();
  FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isRecording = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic permission not allowed !');
    }
    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  void sendTextMessege() async {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessege(
            context,
            _messegeController.text.trim(),
            widget.recieverUserId,
          );
      _messegeController.clear();
      setState(() {
        _messegeController.text = '';
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound.aac';
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await _soundRecorder!.stopRecorder();
        sendFileMessege(File(path), MessegeEnum.audio);
      } else {
        await _soundRecorder!.startRecorder(
          toFile: path,
        );
      }

      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendFileMessege(
    File file,
    MessegeEnum messegeEnum,
  ) {
    ref.read(chatControllerProvider).sendFileMessege(
          context,
          file,
          widget.recieverUserId,
          messegeEnum,
        );
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessege(image, MessegeEnum.image);
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      sendFileMessege(video, MessegeEnum.video);
    }
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messegeController.dispose();
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final messageReplay = ref.watch(messageReplyProvider);
    final isShowMessageReplay = messageReplay != null;
    return Column(
      children: [
        isShowMessageReplay ? MessageReplayPreview() : SizedBox(),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: TextFormField(
                  focusNode: focusNode,
                  controller: _messegeController,
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    } else {
                      setState(() {
                        isShowSendButton = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: klight1,
                    prefixIcon: IconButton(
                      onPressed: toggleEmojiKeyboardContainer,
                      icon: Icon(
                        Icons.emoji_emotions,
                        color: Colors.grey,
                      ),
                    ),
                    suffixIcon: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: selectImage,
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            ),
                          ),
                          Transform.rotate(
                            angle: 47 * (99 / 179),
                            child: IconButton(
                              onPressed: selectVideo,
                              icon: Icon(
                                Icons.attach_file,
                              ),
                              color: kgrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 2,
                right: 10,
                left: 2,
              ),
              child: CircleAvatar(
                radius: 22,
                backgroundColor: ktheme,
                child: GestureDetector(
                  onTap: sendTextMessege,
                  child: Icon(
                    isShowSendButton
                        ? Icons.send
                        : isRecording
                            ? Icons.close
                            : Icons.mic,
                    color: kwhite,
                  ),
                ),
              ),
            ),
          ],
        ),
        isShowEmojiContainer
            ? SizedBox(
                height: 310,
                child: EmojiPicker(
                  onEmojiSelected: ((category, emoji) {
                    setState(() {
                      _messegeController.text =
                          _messegeController.text + emoji.emoji;
                    });

                    if (!isShowSendButton) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    }
                  }),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}

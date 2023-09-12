import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/enums/messege_enum.dart';
import 'package:talkaro/common/utils/utils.dart';
import 'package:talkaro/screens/chat_screen/controler/chat_controller.dart';
import 'package:talkaro/utils/colors.dart';

class BottomTextBox extends ConsumerStatefulWidget {
  final String recieverUserId;
  BottomTextBox({
    super.key,
    required this.recieverUserId,
  });

  @override
  ConsumerState<BottomTextBox> createState() => _BottomTextBoxState();
}

class _BottomTextBoxState extends ConsumerState<BottomTextBox> {
  bool isShowSendButton = false;
  final TextEditingController _messegeController = TextEditingController();
  bool isShowEmojiContainer = false;
  FocusNode focusNode = FocusNode();

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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    isShowSendButton ? Icons.send : Icons.mic,
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

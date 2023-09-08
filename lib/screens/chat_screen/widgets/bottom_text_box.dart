import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/screens/chat_screen/controler/chat_controller.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

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

  void sendTextMessege() async {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessege(
            context: context,
            recieverUserId: widget.recieverUserId,
            text: _messegeController.text,
          );
      _messegeController.clear();
      // setState(() {
      //   _messegeController.text = '';
      // });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messegeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 224, 225, 225),
            borderRadius: BorderRadius.circular(26)),
        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
        height: 60,
        width: 360,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.emoji_emotions_outlined,
                color: kgrey,
              ),
            ),
            kwidth10,
            Expanded(
              child: TextFormField(
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
                    hintText: "Message",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 19),
                    border: InputBorder.none),
              ),
            ),
            Transform.rotate(
              angle: 47 * (99 / 179),
              child: Icon(
                Icons.attach_file,
                color: kgrey,
              ),
            ),
            kwidth20,
            CircleAvatar(
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
            kwidth20
          ],
        ),
      ),
    );
  }
}

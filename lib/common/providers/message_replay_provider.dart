import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/enums/messege_enum.dart';

class MessageReplay {
  final String message;
  final bool isMe;
  final MessegeEnum messegeEnum;

  MessageReplay({
    required this.message,
    required this.isMe,
    required this.messegeEnum,
  });
}

final messageReplyProvider = StateProvider<MessageReplay?>((ref) => null);

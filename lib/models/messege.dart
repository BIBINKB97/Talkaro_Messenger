import 'package:talkaro/common/enums/messege_enum.dart';

class Messege {
  final String senderId;
  final String recieverid;
  final String text;
  final MessegeEnum type;
  final DateTime timeSent;
  final String messegeId;
  final bool isSeen;
  final String repliedMessage;
  final String repliedTo;
  final MessegeEnum repliedMessageType;

  Messege({
    required this.senderId,
    required this.recieverid,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.messegeId,
    required this.isSeen,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
  });
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverid': recieverid,
      'text': text,
      'type': type.type,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messegeId': messegeId,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType':repliedMessageType.type,
    };
  }

  factory Messege.fromMap(Map<String, dynamic> map) {
    return Messege(
      senderId: map['senderId'] ?? '',
      recieverid: map['recieverid'] ?? '',
      text: map['text'] ?? '',
      type: (map['type'] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messegeId: map['messegeId'] ?? '',
      isSeen: map['isSeen'] ?? false,
      repliedMessage: map['repliedTo'] ?? '',
      repliedTo: map['repliedTo'] ?? '',
      repliedMessageType: (map['repliedMessageType'] as String).toEnum(),
    );
  }
}

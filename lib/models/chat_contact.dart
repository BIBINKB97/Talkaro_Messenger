class ChatContact {
  final String name;
  final String profilePic;
  final String contactId;
  final DateTime timeSent;
  final String lastMessege;

  ChatContact({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.timeSent,
    required this.lastMessege,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'lastMessege': lastMessege,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      contactId: map['contactId'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      lastMessege: map['lastMessege'] ?? '',
    );
  }
}

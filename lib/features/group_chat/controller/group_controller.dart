import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/features/group_chat/repository/group_repository.dart';
import 'package:talkaro/models/group.dart';


final groupControllerProvider = Provider((ref) {
  final groupRepository = ref.read(groupRepositoryProvider);
  return GroupController(
    groupRepository: groupRepository,
    ref: ref,
  );
});

class GroupController {
  final GroupRepository groupRepository;
  final ProviderRef ref;
  GroupController({
    required this.groupRepository,
    required this.ref,
  });

  void createGroup(BuildContext context, String name, File profilePic,
      List<Contact> selectedContact) {
    groupRepository.createGroup(context, name, profilePic, selectedContact);
  }
   Stream<GroupModel> groupDatabyId(String groupId) {
    return groupRepository.groupData(groupId);
  }
  void addnewMember(BuildContext context, String groupId, List<String> newMemberUid) {
    groupRepository.addMemberToGroup(context, groupId, newMemberUid);
  }
}
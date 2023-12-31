// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'dart:developer';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/features/group_chat/repository/group_repository.dart';
import 'package:talkaro/features/select_contacts/controller/select_contact_controller.dart';
import 'package:talkaro/utils/constants.dart';

import '../../../common/widgets/error.dart';

final SelectedGroupsContacts = StateProvider<List<Contact>>(
  (ref) => [],
);
List<int> selectedContactsIndex = [];

class SelectContactsGroup extends ConsumerStatefulWidget {
  const SelectContactsGroup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectContactsGroupState();
}

class _SelectContactsGroupState extends ConsumerState<SelectContactsGroup> {
  List<int> selectedContactsIndex = [];

  List<String> registeredPhoneNumbers = [];

  Future<void> fetchregisteredPhoneNumbers() async {
    final QuerySnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    final List<String> phoneNumbers = userSnapshot.docs
        .map((doc) => doc.get('phoneNumber'))
        .where((phoneNumber) => phoneNumber != null)
        .cast<String>()
        .toList();
    setState(() {
      registeredPhoneNumbers = phoneNumbers;
      log(registeredPhoneNumbers.toString());
    });
  }

  List<Contact> filterContacts(List<Contact> contacts) {
    return contacts.where((contact) {
      if (contact.phones.isNotEmpty) {
        for (final phone in contact.phones) {
          if (registeredPhoneNumbers.contains(phone.normalizedNumber)) {
            return true;
          }
        }
      }
      return false;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    fetchregisteredPhoneNumbers();
  }

  void selectContact(int index, Contact contact) {
    setState(() {
      if (selectedContactsIndex.contains(index)) {
      } else {
        selectedContactsIndex.add(index);
      }
    });

    ref
        .read(SelectedGroupsContacts.state)
        .update((state) => [...state, contact]);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getContactsProvider).when(
        data: (contactList) {
          final filteredContacts = filterContacts(contactList);
          return Expanded(
            child: ListView.builder(
                itemCount: filteredContacts.length,
                itemBuilder: (context, index) {
                  final contact = filteredContacts[index];
                  
                  return InkWell(
                    onTap: () {
                      selectContact(index, contact);
                      ref.read(groupRepositoryProvider).selectContact(index,contact);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                          title: Row(
                            children: [
                              const CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey,
                                backgroundImage: AssetImage('images/user.png'),
                              ),
                              kwidth10,
                              Text(
                                contact.displayName,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          leading: selectedContactsIndex.contains(index)
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedContactsIndex.remove(index);
                                    });
                                  },
                                  icon: const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.done,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : null),
                    ),
                  );
                }),
          );
        },
        error: (err, trace) => ErrorScreen(error: err.toString()),
        loading: () => const Loader());
  }
}

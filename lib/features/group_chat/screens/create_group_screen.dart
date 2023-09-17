import 'dart:io';

import 'package:flutter/material.dart';
import 'package:talkaro/common/utils/utils.dart';
import 'package:talkaro/features/group_chat/widgets/select_contacts_group.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';
import 'package:talkaro/utils/main_widgets.dart';

class CreateGroupScreen extends StatefulWidget {
  static const String routeName = '/create-group';
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController groupNameController = TextEditingController();
  File? image;

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

void createGroup() {
  if(groupNameController.text.trim().isNotEmpty && image!=null) {

  }
}


  @override
  void dispose() {
    super.dispose();
    groupNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: 'Create Group'),
        centerTitle: true,
        backgroundColor: ktheme,
        elevation: 0,
      ),
      body: Center(
          child: Column(
        children: [
          kheight20,
          Stack(
            children: [
              image == null
                  ? CircleAvatar(
                      backgroundImage: AssetImage("images/user.png"),
                      radius: 80,
                    )
                  : CircleAvatar(
                      backgroundImage: FileImage(image!),
                      radius: 80,
                    ),
              Padding(
                padding: EdgeInsets.only(left: 110.0, top: 120),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: ktheme,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: Icon(Icons.add_a_photo_rounded),
                    color: kwhite,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: groupNameController,
              decoration: InputDecoration(
                hintText: 'Enter Group Name',
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select Contacts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SelectContactsGroup(),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ktheme,
        child: Icon(
          Icons.done,
          color: kwhite,
        ),
      ),
    );
  }
}

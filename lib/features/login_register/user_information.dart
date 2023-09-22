import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/utils/utils.dart';
import 'package:talkaro/features/authentication/controller/auth_controller.dart';
import 'package:talkaro/features/profile/edit_profile/widgets.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';
import 'package:talkaro/utils/main_widgets.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-informationScreen';
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();
    if (name.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(
            context,
            name,
            image,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ktheme,
        centerTitle: true,
        title: AppBarTitle(title: "Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            kheight80,
            Center(
              child: Stack(
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
            ),
            kheight20,
            TextFormProfile(
              controller: nameController,
              hintText: ' Enter Name',
              label: "Name",
            ),
            kheight20,
            CommonButton(
              title: " save ",
              onPressed: storeUserData,
            )
          ],
        ),
      ),
    );
  }
}

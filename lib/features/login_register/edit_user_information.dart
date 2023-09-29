import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/utils/utils.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/features/authentication/controller/auth_controller.dart';
import 'package:talkaro/models/user_model.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/main_widgets.dart';

class EditUserInformation extends ConsumerStatefulWidget {
  static String routeName = '/user-information';
  const EditUserInformation({super.key});

  @override
  ConsumerState<EditUserInformation> createState() =>
      _EditUserInformationState();
}

class _EditUserInformationState extends ConsumerState<EditUserInformation> {
  final TextEditingController namesController = TextEditingController();
  File? image;
  bool isLoading = true;
  UserModel? userData;

  @override
  void dispose() {
    super.dispose();
    namesController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void updateUserData() async {
    String name = namesController.text.trim();
    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .saveUserDataToFirebase(context, name, image);
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    try {
      final loadedUserData =
          await ref.read(authControllerProvider).getUserData();
      if (loadedUserData != null) {
        namesController.text = loadedUserData.name;
        setState(() {
          userData = loadedUserData;
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ktheme,
          title: Text('Edit your informations'),
          centerTitle: true,
        ),
        body: isLoading
            ? Loader()
            : SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.15),
                      Stack(
                        children: [
                          image == null
                              ? CircleAvatar(
                                  radius: 80,
                                  backgroundImage:
                                      NetworkImage(userData!.profilePic),
                                )
                              : CircleAvatar(
                                  radius: 80,
                                  backgroundImage: FileImage(
                                    image!,
                                  ),
                                ),
                          Positioned(
                              bottom: 0,
                              left: 105,
                              child: CircleAvatar(
                                backgroundColor: ktheme,
                                radius: 20,
                                child: IconButton(
                                    color: kwhite,
                                    onPressed: selectImage,
                                    icon: Icon(Icons.add_a_photo)),
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width * 0.85,
                            padding: EdgeInsets.all(20),
                            child: TextField(
                                controller: namesController,
                                decoration: InputDecoration(
                                    hintText: userData!.name,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: ktheme),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: ktheme),
                                        borderRadius:
                                            BorderRadius.circular(30)))),
                          )
                        ],
                      ),
                      CommonButton(
                          title: 'Update',
                          onPressed: () async {
                            updateUserData();
                            showSnackBar(
                                context: context,
                                content: 'successfully updated');
                          }),
                    ],
                  )),
                ),
              ));
  }
}

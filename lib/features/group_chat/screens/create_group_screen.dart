// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:talkaro/common/utils/utils.dart';
// import 'package:talkaro/features/group_chat/controller/group_controller.dart';
// import 'package:talkaro/features/group_chat/widgets/select_contacts_group.dart';
// import 'package:talkaro/utils/colors.dart';
// import 'package:talkaro/utils/constants.dart';
// import 'package:talkaro/utils/main_widgets.dart';

// class CreateGroupScreen extends ConsumerStatefulWidget {
//   static const String routeName = '/create-group';
//   const CreateGroupScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<CreateGroupScreen> createState() => _CreateGroupScreenState();
// }

// class _CreateGroupScreenState extends ConsumerState<CreateGroupScreen> {
//   final TextEditingController groupNameController = TextEditingController();
//   File? image;

//   void selectImage() async {
//     image = await pickImageFromGallery(context);
//     setState(() {});
//   }

//   void createGroup() {
//     if (groupNameController.text.trim().isNotEmpty && image != null) {
//       ref.read(groupControllerProvider).createGroup(
//             context,
//             groupNameController.text.trim(),
//             image!,
//             ref.read(SelectedGroupsContacts),
//           );
//       ref.read(SelectedGroupsContacts.state).update((state) => []);
//       Navigator.pop(context);
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     groupNameController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: AppBarTitle(title: 'Create Group'),
//         centerTitle: true,
//         backgroundColor: ktheme,
//         elevation: 0,
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             kheight20,
//             Stack(
//               children: [
//                 image == null
//                     ? const CircleAvatar(
//                         backgroundImage: AssetImage('images/user.png'),
//                         radius: 70,
//                       )
//                     : CircleAvatar(
//                         backgroundImage: FileImage(
//                           image!,
//                         ),
//                         radius: 70,
//                       ),
//                 Positioned(
//                   bottom: 5,
//                   right: 1,
//                   child: CircleAvatar(
//                     backgroundColor: ktheme,
//                     child: IconButton(
//                       onPressed: selectImage,
//                       icon: const Icon(
//                         Icons.add_a_photo,
//                         color: kwhite,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: TextField(
//                 controller: groupNameController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter Group Name',
//                 ),
//               ),
//             ),
//             Container(
//               alignment: Alignment.topLeft,
//               padding: const EdgeInsets.all(8),
//               child: const Text(
//                 'Select Contacts',
//                 style: TextStyle(
//                   color: ktheme,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             const SelectContactsGroup(),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: createGroup,
//         backgroundColor: ktheme,
//         child: const Icon(
//           Icons.done,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:ui';
import 'package:talkaro/common/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/utils/colors.dart';

import '../controller/group_controller.dart';
import '../widgets/select_contacts_group.dart';

class CreateGroup extends ConsumerStatefulWidget {
  static const String routeName = '/create-group';
  const CreateGroup({super.key});

  @override
  ConsumerState<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends ConsumerState<CreateGroup> {
  final TextEditingController groupnameController = TextEditingController();
  File? image;

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void createGroup() async {
    if (groupnameController.text.trim().isNotEmpty && image != null) {
      ref.read(groupControllerProvider).createGroup(
            context,
            groupnameController.text.trim(),
            image!,
            ref.read(
              SelectedGroupsContacts,
            ),
          );
      ref.read(SelectedGroupsContacts.state).update((state) => []);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    groupnameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: ktheme,
        title: const Text('Create Group'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Stack(
              children: [
                image == null
                    ? const CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                            'https://static.vecteezy.com/system/resources/thumbnails/020/765/399/small/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg'),
                      )
                    : CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(
                          image!,
                        ),
                      ),
                Positioned(
                    bottom: -11,
                    left: 100,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black,
                      child: IconButton(
                          color: Colors.amber,
                          onPressed: selectImage,
                          icon: const Icon(Icons.camera_alt)),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: groupnameController,
                        decoration: InputDecoration(
                            hintText: 'Enter the Groupname',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.amber),
                                borderRadius: BorderRadius.circular(5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.amber),
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Select Contacts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(
              thickness: 1,
            ),
            const SelectContactsGroup(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Create"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onPressed: createGroup,
        backgroundColor: Colors.amber,
        icon: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}

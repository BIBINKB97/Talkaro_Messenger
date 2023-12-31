// import 'package:flutter/material.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:talkaro/common/widgets/error.dart';
// import 'package:talkaro/common/widgets/loader.dart';
// import 'package:talkaro/features/home_page/widgets/search_chat.dart';
// import 'package:talkaro/features/select_contacts/controller/select_contact_controller.dart';
// import 'package:talkaro/utils/colors.dart';
// import 'package:talkaro/utils/constants.dart';
// import 'package:talkaro/utils/main_widgets.dart';

// class SelsectContactScreen extends ConsumerWidget {
//   static const String routeName = '/select-contact';
//   const SelsectContactScreen({super.key});

//   void selectContact(
//       WidgetRef ref, Contact selectedContact, BuildContext context) {
//     ref
//         .read(selectContactControllerProvider)
//         .selectContact(selectedContact, context);
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ktheme,
//         title: AppBarTitle(title: "Select Contact"),
//         actions: [
//           IconButton(
//               onPressed: () => AppbarWithSearch(),
//               icon: Icon(
//                 Icons.search,
//               )),
//           kwidth10,
//         ],
//       ),
//       body: ref.watch(getContactsProvider).when(
//           data: (contactList) => ListView.builder(
//               itemCount: contactList.length,
//               itemBuilder: (context, index) {
//                 final contact = contactList[index];
//                 return InkWell(
//                   onTap: () => selectContact(ref, contact, context),
//                   child: Padding(
//                     padding: const EdgeInsets.only(bottom: 8.0),
//                     child: ListTile(
//                       leading: contact.photo == null
//                           ? null
//                           : CircleAvatar(
//                               backgroundImage: MemoryImage(contact.photo!),
//                               radius: 30,
//                             ),
//                       title: Text(
//                         contact.displayName,
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//           error: (err, trace) => ErrorScreen(error: err.toString()),
//           loading: () => Loader()),
//     );
//   }
// }

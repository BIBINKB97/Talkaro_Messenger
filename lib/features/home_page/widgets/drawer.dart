import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/features/authentication/controller/auth_controller.dart';
import 'package:talkaro/features/group_chat/screens/create_group_screen.dart';
import 'package:talkaro/features/home_page/widgets/drawer_widgets/about_us.dart';
import 'package:talkaro/features/home_page/widgets/drawer_widgets/privacy_policy.dart';
import 'package:talkaro/features/login_register/edit_user_information.dart';
import 'package:talkaro/features/splash_screen/splash_screen.dart';
import 'package:talkaro/models/user_model.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<UserModel?>(
      future: ref.read(authControllerProvider).getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Drawer(
              child: ListView(
            children: const [
              kheight50,
              kheight50,
              kheight30,
              Loader(),
            ],
          ));
        }

        if (snapshot.hasError) {
          return const Drawer(
            child: Text("Error fetching data"),
          );
        }
        final userData = snapshot.data;
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: ktheme,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const EditUserInformation(),
                        ));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(userData!.profilePic),
                        radius: 45,
                      ),
                    ),
                    kheight10,
                    Text(
                      userData.name,
                      style: TextStyle(color: kwhite, fontSize: 18),
                    ),
                    kheight5,
                    Text(
                      userData.phoneNumber,
                      style: TextStyle(
                        color: kwhite,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.group_add),
                title: Text('New Group'),
                onTap: () => Future(
                  () => Navigator.pushNamed(
                    context,
                    CreateGroup.routeName,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person_add),
                title: Text('Invite Friends'),
                onTap: () {
                  Share.share("talkaromessenger.playstore");
                },
              ),
              Divider(
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
                color: ktheme,
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text('privacy policy'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About Us'),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AboutUs()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text(
                  'Signout',
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Signout !',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: const Text(
                          'This action will Signout you from the application !',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Yes'),
                            onPressed: () async {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SplashScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

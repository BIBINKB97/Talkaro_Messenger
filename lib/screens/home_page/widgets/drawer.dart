import 'package:flutter/material.dart';
import 'package:talkaro/screens/profile/edit_profile/profile.dart';
import 'package:talkaro/utils/colors.dart';
import 'package:talkaro/utils/constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: ktheme,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserProfile()));
                },
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("images/user.png"),
                    ),
                    kheight10,
                    Text(
                      'Bibin KB',
                      style: TextStyle(
                        fontSize: 18.5,
                      ),
                    )
                  ],
                ),
              )),
          ListTile(
            leading: Icon(Icons.group_add),
            title: Text('New Group'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Contacts'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person_add),
            title: Text('Invite Friends'),
            onTap: () {
              Navigator.pop(context);
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
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About Us'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

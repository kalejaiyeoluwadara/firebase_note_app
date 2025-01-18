import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(child: Icon(Icons.favorite)),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: Text('H O M E'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/home_page');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text('P R O F I L E'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/profile_page');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.group),
                      title: Text('U S E R S'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/users_page');
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: Text('L O G O U T'),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
// 
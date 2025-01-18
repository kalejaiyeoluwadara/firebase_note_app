import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/components/my_drawer.dart';
import 'package:firebase/components/my_list_tile.dart';
import 'package:firebase/components/my_post_button.dart';
import 'package:firebase/components/my_textfield.dart';
import 'package:firebase/service/firestore2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WallPage extends StatelessWidget {
  WallPage({super.key});
  final FirestorePosts database = FirestorePosts();
  final TextEditingController newPostController = TextEditingController();
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(),
          title: const Text(
            'W A L L',
            style: TextStyle(),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: logout,
              child: const Icon(
                Icons.logout,
              ),
            ),
            const SizedBox(
              width: 19,
            )
          ],
        ),
        drawer: const MyDrawer(),
        body: Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MyTextfield(
                          controller: newPostController,
                          hintText: 'Say something',
                          obscureText: false),
                    ),
                    MyPostButton(
                      onTap: postMessage,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder(
                  stream: database.getPostsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return (const Center(
                        child: CircularProgressIndicator(),
                      ));
                    }
                    final posts = snapshot.data!.docs;
                    if (snapshot.data == null || posts.isEmpty) {
                      return (const Center(
                          child: Text('No posts... Post something')));
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          String message = post['PostMessage'];
                          String userEmail = post['UserEmail'];
                          Timestamp timestamp = post['Timestamp'];
                          return MyListTile(
                              message: message,
                              userEmail: userEmail,
                              timestamp: timestamp);
                        },
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}

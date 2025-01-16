import 'package:firebase/service/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Firestore firestore = Firestore();
  TextEditingController controller = TextEditingController();
  void openNoteBox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                firestore.addNote(controller.text);
                controller.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void handleUpdate(String note, int index, List notesList) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController updateController =
            TextEditingController(text: note);
        return AlertDialog(
          content: TextField(
            controller: updateController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                firestore.updateNote(
                    notesList[index].id, updateController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget itemBuilder(BuildContext context, List notesList, int index) {
    String note = notesList[index]['note'];
    return ListTile(
      title: Text(
        note,
        overflow: TextOverflow.ellipsis, // Ensures long text doesn't overflow
      ),
      trailing: IntrinsicWidth(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => handleUpdate(note, index, notesList),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                firestore.deleteNote(notesList[index].id);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        onPressed: openNoteBox,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
          stream: firestore.getNotesStream(),
          builder: (context, snapshop) {
            if (snapshop.hasData) {
              List notesList = snapshop.data!.docs;
              return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) =>
                    itemBuilder(context, notesList, index),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/notes.dart';
import '../Widgets/note_widget.dart';
import 'create_note.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<List<Note>> fetchNotesStream() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    final userId = auth.currentUser!.uid;

    return firestore
        .collection("Notes")
        .doc(userId)
        .collection("userNotes")
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Note(
      title: doc.data()['title'] ?? '',
      content: doc.data()['content'] ?? '',
    ))
        .toList());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          IconButton(
              onPressed:(){
                AuthService().signOut(context);
              },
              icon:const Icon(Icons.logout)
          )
        ],
      ),
     floatingActionButton: FloatingActionButton.extended(
         onPressed: (){
           Navigator.push(context,MaterialPageRoute(builder: (context)=>const CreateNote()));
         },
         label: const Text("Create Note"),
       icon: const Icon(Icons.add),
     ),
      body: StreamBuilder<List<Note>>(
        stream: fetchNotesStream(),
          builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No notes available.'));
      } else {
        List<Note> notes = snapshot.data!;
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              Note note = notes[index];
              return noteWidget(note.title, note.content,context);
            });
      }
          }
          )
    );
  }

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/show_snackbar.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final TextEditingController _titleController=TextEditingController();
 final TextEditingController _contentController=TextEditingController();

 void uploadNote(){
   final title=_titleController.text.trim();
   final content=_contentController.text.trim();
   FirebaseFirestore firestore = FirebaseFirestore.instance;
   FirebaseAuth auth = FirebaseAuth.instance;
    final userId=auth.currentUser!.uid;

   firestore.collection("Notes").doc(userId).collection("userNotes").add({
     "title": title,
     "content": content,
     "created": Timestamp.now(),
   })
       .then((value) {
     showSnackBar( "Note uploaded successfully", context,  Icons.done,Colors.green);
     Navigator.pop(context); // Close the screen after successful upload
   })
       .catchError((error) {
     showSnackBar( "Error uploading note", context,  Icons.done,Colors.green);
   });

 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
                     if(_titleController.text.isNotEmpty||_contentController.text.isNotEmpty){
                       uploadNote();
                     }
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: Padding(padding:const EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              hintText: "Title",
              border: InputBorder.none,
            ),
            maxLines: null,

          ),
          TextField(
            controller: _contentController,
            expands: false,
            decoration: const InputDecoration(
              hintText: "Note",
              border: InputBorder.none,
            ),
            maxLines: null,
          ),
        ],
      ),
      ),

    );
  }
}

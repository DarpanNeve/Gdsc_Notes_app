

import 'package:flutter/material.dart';
import 'package:notes_app/Widgets/show_dialog.dart';

Widget noteWidget (String title, String content,BuildContext context){
  return GestureDetector(
    onLongPress: (){
      showDialog(context: context,
          builder:(BuildContext context)=>showDialogQ(context,title)
      );
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.tealAccent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          Expanded(child: Text(content,style: const TextStyle(fontSize: 15),)),
        ],
      ),
    ),
  );
}
import 'package:flutter/material.dart';

class EDTComment extends StatelessWidget {
  const EDTComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: TextField(
        // controller: tec,
        style: TextStyle(
            color: Colors.black
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          hintText: "type Comment",
          border: InputBorder.none,
          hintStyle:TextStyle(color: Colors.grey),
          // border: OutlineInputBorder(),
          suffixIcon:IconButton(icon: Icon(Icons.send,color: Colors.grey,),onPressed: (){},)

        ),

      ),
    );
  }
}

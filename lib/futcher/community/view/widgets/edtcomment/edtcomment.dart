import 'package:flutter/material.dart';

class EdtComment extends StatelessWidget {
  final tec;
  final hintText;
  final prefixIcon;
  const EdtComment({super.key,required this.tec ,this.hintText,this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: tec,
      style: TextStyle(
          color: Colors.black
      ),
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        hintText: "${hintText}",
        border: InputBorder.none,
        hintStyle:TextStyle(color: Colors.grey),
        suffixIcon: prefixIcon
        // border: OutlineInputBorder(),
      ),


    );
  }
}

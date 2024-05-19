import 'package:flutter/material.dart';

class EDTArea extends StatelessWidget {
  final keyboardType;
  final obscureText;
  final hintText;
  final tec;
  const EDTArea({super.key,this.keyboardType,this.obscureText,this.hintText,this.tec});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 45,right: 45),
      child: TextField(
        controller: tec,
        style: TextStyle(
          color: Colors.white
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: null,
        decoration: InputDecoration(
          hintText: hintText,

          hintStyle:TextStyle(color: Colors.grey),
          // border: OutlineInputBorder(),
        ),

      ),
    );

  }
}

import 'package:flutter/material.dart';

class EDTPhone extends StatelessWidget {
  final keyboardType;
  final obscureText;
  final hintText;
  final prefixIcon;
  final tec;
  const EDTPhone({super.key,this.keyboardType,this.obscureText,this.hintText,this.prefixIcon,this.tec});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 45,right: 45,top: 16),
      child: TextField(
        controller: tec,
          keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          hintStyle:TextStyle(color: Colors.grey),
        ),
      ),
    );

  }
}

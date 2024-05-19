import 'package:flutter/material.dart';
import 'package:k2help/helper/scalesize.dart';
class AuthEditTxt extends StatelessWidget {
  final String hintText;
  final prefixIcon;
  final bool obscureText;
  final TextEditingController tec ;
  const AuthEditTxt({super.key,required this.hintText,this.prefixIcon,required this.obscureText,required this.tec});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: ScaleSize.textScaleFactor(context),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        obscureText: obscureText,
        style: TextStyle(
          color: Colors.white,
        ),
        controller: tec,
        decoration: InputDecoration(
          hintText: hintText,

          prefixIcon: prefixIcon,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan),
          ),
          hintStyle: TextStyle(
            color: Colors.white
          ),

        ),
      ),
    );
  }
}

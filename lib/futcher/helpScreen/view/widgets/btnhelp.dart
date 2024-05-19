
import 'package:flutter/material.dart';
import 'package:k2help/helper/scalesize.dart';

class BtnHelp extends StatelessWidget {
  final VoidCallback press;
  final String btntxt;
  final backGroundColor;
  final foregroundColor;
  const BtnHelp({super.key,required this.press,required this.btntxt,this.backGroundColor,this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: foregroundColor,
      backgroundColor: backGroundColor,
      minimumSize: Size(80, 50),
      padding: EdgeInsets.symmetric(horizontal: 100),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: press,
        child: Text(btntxt,
          style: TextStyle(
            fontSize: 24
          ),
          textScaleFactor: ScaleSize.textScaleFactor(context),
        ),
      ),
    );
  }
}

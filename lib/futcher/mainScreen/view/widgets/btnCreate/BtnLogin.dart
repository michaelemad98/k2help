
import 'package:flutter/material.dart';
import 'package:k2help/helper/scalesize.dart';

class BtnLogin extends StatelessWidget {
  final VoidCallback press;
  final String btntxt;
  const BtnLogin({super.key,required this.press,required this.btntxt});

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.orange.shade800,
      minimumSize: height >=1366.0? Size(width *0.5,height *0.07):Size(200, 50),
      // padding: EdgeInsets.symmetric(horizontal: 100),
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
          textScaleFactor: ScaleSize.textScaleFactor(context),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

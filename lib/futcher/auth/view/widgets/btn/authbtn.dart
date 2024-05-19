
import 'package:flutter/material.dart';
import 'package:k2help/helper/scalesize.dart';

class AuthBtn extends StatelessWidget {

  final String btntxt;
  final btnonPressed;
  final bool? isload;
  const AuthBtn({super.key,required this.btntxt,this.btnonPressed,this.isload});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(20)
      ),
      child: ElevatedButton(
        onPressed: btnonPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          minimumSize: Size(200, 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: isload!?CircularProgressIndicator():Text(btntxt,
          textScaleFactor: ScaleSize.textScaleFactor(context),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
class EDTPost extends StatelessWidget {
  final tec ;
  final onPressed;
  final imgPressed;
  final file;
  const EDTPost({super.key,this.tec,this.onPressed,this.imgPressed ,this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: tec,
            style: TextStyle(
                color: Colors.black
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              hintText: "type post",
              border: InputBorder.none,
              hintStyle:TextStyle(color: Colors.grey),
              // border: OutlineInputBorder(),
            ),

          ),
          file==null?Container():Image.file(file,width: 200,height: 200,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              IconButton(icon: Icon(Icons.photo,color: Colors.grey,),onPressed: imgPressed,),
              IconButton(icon: Icon(Icons.send,color: Colors.grey,),onPressed: onPressed,),
            ],
          )
        ],
      ),
    );
  }
}

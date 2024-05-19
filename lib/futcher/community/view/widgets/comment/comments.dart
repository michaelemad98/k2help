import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  final commenttxt ;
  final commentlength;
  const Comments({super.key,this.commenttxt,this.commentlength});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: commentlength,
        itemBuilder: (context,index){
      return Container(
        child: Column(
          children: [
            Text('${commenttxt[index]['description']}'),
            Text("Replay"),
          ],
        ),
      );
    });
  }
}

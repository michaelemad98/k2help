import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k2help/futcher/bass/controller/bassemcontroller.dart';

class BassemScreen extends StatelessWidget {
  const BassemScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder(
            init: BassemController(),
            builder: (controller) {
              return FutureBuilder(future: controller.initializationCamera(), builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.done){
                  return Stack(
                    children: [
                      CameraPreview(controller.cameraController),
                      Image.asset('assets/images/shape.png')
                    ],
                  );
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
              });
            }
          )
        ],
      ),
    );
  }
}


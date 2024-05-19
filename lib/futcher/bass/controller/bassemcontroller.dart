import 'package:camera/camera.dart';
import 'package:get/get.dart';

class BassemController extends GetxController{
  late CameraController cameraController;

  Future<void> initializationCamera()async{
    var cameras = await availableCameras();
    cameraController = CameraController(
      cameras[EnumCameraDescrcription.front.index],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420
    );
    await cameraController.initialize();
  }

}
enum EnumCameraDescrcription{front,back}
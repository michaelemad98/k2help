import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k2help/futcher/helpScreen/models/countriesmodel.dart';
import 'package:k2help/helper/constant/constAPI.dart';

class HelpController extends GetxController{
  var data = Get.arguments;
  bool showlocation = false;

  ShowLoaction(){
    showlocation = true;
    update();
  }
  String State='';
  String  City = '';
  List cities = [];
  int stateindex = 0;
 bool isShowCity = false;
  Setupdaate(ss,index){
    State = ss;
    print(index);
    cities = States[index].cities;
    stateindex = index;
    isShowCity = true;
    // CountryModel coubtryModel = CountryModel();
    // coubtryModel= CountryModel.fromJson(States);
    // print(coubtryModel.data![0].cities![0].name);
    // // City = '${coubtryModel.data![0].cities![0].name}';
    update();
  }
  bool isShowStreet = false;
  List streets =[];
  SetCity(ss,index){
    City = ss;
    print(ss);
    isShowStreet  = true;
    streets = States[stateindex].cities[index].streets;
    update();
  }
  String  Street = '';
  int streetid = 0 ;
  setStreet(ss,id){
    streetid = id;
    Street = ss;
    update();
  }
  var States ;
  Future GetCpunteries()async{
    try {
      Dio dio  = Dio();
      var response = await dio.get('${hostname}countries',
          options: Options(
            validateStatus: (status) => true,
          )
      );
      if (response.statusCode == 200) {
        print(json.encode(response.data));
        CountryModel coubtryModel = CountryModel();
        coubtryModel= CountryModel.fromJson(response.data);
        States = coubtryModel.data;
        return response.data;
      }
      else {
        print(response.statusMessage);
      }

    }catch(e){}
  }
  
    List<File> myfilelist=[];
    File ?myfile;
    File ?file;
    bool isshowDialog = false;
    String ?fileName;
  PickImagefromGalary()async{
   XFile ? xfile = await  ImagePicker().pickImage(
       source: ImageSource.gallery, imageQuality: 25);
   myfile = File(xfile!.path);
   print(myfile);
   final bytes = myfile!.readAsBytesSync();
   fileName = myfile!.path.split('/').last;
   print(fileName);
   isshowDialog = true;
   myfilelist.add(myfile!);
   update();
   // await UploadImage();
   // print(dfielss);
  }
  PickImagefromCamera()async{
    XFile? xfile = await ImagePicker().pickImage(
        source: ImageSource.camera, imageQuality: 25);
    myfile = File(xfile!.path);
    fileName = myfile!.path.split('/').last;
    isshowDialog = true;
    myfilelist.add(myfile!);
    update();
  }

  String latitude = '';
  String longitude = '';
  GetCurrentLocation() async {
    try{
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
      print(latitude + longitude);

    }catch(e){
      print(e);
      Geolocator.getLastKnownPosition(forceAndroidLocationManager: true);
    }
  }

  TextEditingController  firstnametec = TextEditingController();
  TextEditingController  lastnametec = TextEditingController();
  TextEditingController  phonetec = TextEditingController();
  TextEditingController  emailtec = TextEditingController();
  TextEditingController  descriptiotec = TextEditingController();

  CreateHelp()async {
    var dataneed = {
      'first_name': '${firstnametec.text}',
      'last_name': '${lastnametec.text}',
      'phone': '${phonetec.text}',
      'description': '${descriptiotec.text}',
      'lat': '${latitude}',
      'lng': '${longitude}',
      'link': 'https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}',
      'street_id': '$streetid',
      'type': data[0]=='need'?'need a help':'wanna a help'
    };

    try{
      Dio dio  = Dio();
      var response  = await dio.post('${hostname}create_help',
      options: Options(
        validateStatus: (status) => true,
      ),
        data: dataneed
      );
      if (response.statusCode == 200) {
        print(json.encode(response.data));
      }
      else {
        print(response.statusMessage);
      }
    }catch(e){}
  }
}
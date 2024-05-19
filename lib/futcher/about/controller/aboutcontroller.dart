import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k2help/futcher/about/models/aboutmodel.dart';
import 'package:k2help/helper/constant/constAPI.dart';
class AboutController extends GetxController{
Dio dio = Dio();
String descriptoinAbt= '';
GetAboutDescription()async{
  try{
    var response = await dio.get("http://192.168.1.16:8000/api/about",
    options: Options(
      validateStatus: (status) => true,
    )
    );

    if (response.statusCode == 200) {
      GetAboutDescriptionModel getAboutDescriptionModel = GetAboutDescriptionModel();
      getAboutDescriptionModel = GetAboutDescriptionModel.fromJson(response.data);
      descriptoinAbt = "${getAboutDescriptionModel.data!.about}";
      print(json.encode(response.data));
    }
    else {
      print(response.statusMessage);
    }
  }catch(e){
    print(e);
  }
}

}
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:k2help/futcher/helpScreen/models/countriesmodel.dart';
import 'package:k2help/helper/constant/constAPI.dart';

class VolunteersController extends GetxController{

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

  RedgistVolunteer()async{
    try{
      var data = {
        'first_name': '${firstnametec.text}',
        'last_name': '${lastnametec.text}',
        'email': '${emailtec.text}',
        'phone': '${phonetec.text}',
        'lat': '${latitude}',
        'lng': '${longitude}',
        'link': 'https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}',
        'street_id': '$streetid'
      };

      var dio = Dio();
      var response = await dio.post(
        '${hostname}regist_volunteer',
        options: Options(
          validateStatus: (status) => true,
        ),
        data: data,
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
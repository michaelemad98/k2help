import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:k2help/futcher/about/models/faqmodel.dart';
import 'package:k2help/helper/constant/constAPI.dart';

class FAQSCotroller extends GetxController{
  Dio dio = Dio();
  Future GetFAQS() async {
    try{
      var response =await dio.get('$hostname$faqs',
      options: Options(
        validateStatus: (status) => true,
      )
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        return response.data;

      }
      else {
        print(response.statusMessage);
      }
    }catch(e){
      print(e);
    }
  }
}
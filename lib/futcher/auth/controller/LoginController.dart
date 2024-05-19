import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k2help/futcher/auth/models/loginmodel.dart';
import 'package:k2help/helper/constant/constAPI.dart';
import 'package:k2help/helper/sherdprefrence/shardprefKeyConst.dart';
import 'package:k2help/helper/sherdprefrence/sharedprefrenc.dart';
class LoginController extends GetxController{
  TextEditingController useremailtec =  TextEditingController();
  TextEditingController userpasswordtec =  TextEditingController();
  String token ='';
  String errorMessage ='';
  bool   isLoading = false;

  Future<void> SignInWithEmailAndPassword(email,password,context) async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      print('User signed in: ${user!.uid}');

    }catch(e){
      print('Failed to sign in: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to sign in: $e. Please check your credentials.'),
      ));
    }
  }

  void Login({email, password,context})async{
    isLoading = true;
    final firebaseMessaging = FirebaseMessaging.instance;
    final FCMtoken = await firebaseMessaging.getToken();
    token = '${FCMtoken}';
    Dio dio = Dio();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var data = {
      'username': '${email}',
      'password': '${password}',
      'device_token': '${FCMtoken}'
    };
    var response = await dio.post('${hostname}login',
    options: Options(
      headers: headers,
      validateStatus: (status) => true,
    ),
      data: data
    );
    if(response.statusCode==200){
      isLoading = false;
      print(response.data);
      SignInWithEmailAndPassword(email,password,context);
      LoginModel loginModel = LoginModel();
      loginModel = LoginModel.fromJson(response.data);
      CacheHelper.saveData(key: isLoginkey , value: true);
      CacheHelper.saveData(key: useridkey , value: loginModel.data!.id);
      CacheHelper.saveData(key: userfirstnamekey , value: loginModel.data!.firstName);
      CacheHelper.saveData(key: userlastnamekey , value: loginModel.data!.lastName);
      CacheHelper.saveData(key: useremailkey , value: loginModel.data!.email);
      CacheHelper.saveData(key: usernamekey , value: loginModel.data!.username);
      CacheHelper.saveData(key: userphonekey , value: loginModel.data!.phone);
      CacheHelper.saveData(key: userpicturekey , value: loginModel.data!.picture);
      CacheHelper.saveData(key: access_tokenkey , value: loginModel.data!.token);
      update();
      Get.offNamed('/mainscreen');


    }
    else{
      isLoading = false;
      errorMessage = response.data['message'];
      print(response.data);

    }

  }

}
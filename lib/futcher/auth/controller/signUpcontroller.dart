import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k2help/futcher/auth/controller/LoginController.dart';
import 'package:k2help/helper/constant/constAPI.dart';
import 'package:k2help/helper/sherdprefrence/shardprefKeyConst.dart';
import 'package:k2help/helper/sherdprefrence/sharedprefrenc.dart';

class SignUpController extends GetxController {
  TextEditingController firstnametec = TextEditingController();
  TextEditingController lastnametec = TextEditingController();
  TextEditingController usernametec = TextEditingController();
  TextEditingController useremailtec = TextEditingController();
  TextEditingController userphonetec = TextEditingController();
  TextEditingController userpasswordtec = TextEditingController();
  TextEditingController userconpasswordtec = TextEditingController();
  bool isLoading = false;
  String token = '';
  String errorMessage = '';
  LoginController loginController = LoginController();

  @override
  void onInit() {
    super.onInit();
    loginController = LoginController();
  }
  void SignUPWithEmailandPassword(context)async{
    try {
      final firebaseMessaging = FirebaseMessaging.instance;
      final FCMtoken = await firebaseMessaging.getToken();
      token = '${FCMtoken}';
      if (firstnametec.text.isEmpty) {
        errorMessage = 'Enter first name';
        update();
      } else if (lastnametec.text.isEmpty) {
        errorMessage = 'Enter first name';
        update();
      }else if (useremailtec.text.isEmpty) {
        errorMessage = 'Enter username';
        update();
      } else if (userpasswordtec.text.isEmpty) {
        errorMessage = 'Enter Password';
        update();
      } else if (userconpasswordtec.text.isEmpty) {
        errorMessage = 'Enter Cofirm Password';
        update();
      } else if (userconpasswordtec.text != userpasswordtec.text) {
        errorMessage = 'Cofirm password not match';
        update();
      } else {

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: "${useremailtec.text}@k2help.com", password: userpasswordtec.text);
        User? user = userCredential.user;
        print('User signed up: ${user!.uid}');
        AddDatatoFireStore(email:"${useremailtec.text}@k2help.com",password: userpasswordtec.text,userid: user.uid,name: usernametec.text,FcmToken:token);
        CreateAnAccount(context,user.uid,token);
      }
    } catch (e) {
      print('Failed to sign up: $e');
      errorMessage = "${e}";
      update();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to sign up :$e. Please try again. '),
      ));
    }

  }

  AddDatatoFireStore({userid, name,email,password,FcmToken}){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('users').doc(userid).set({
      'first_name': '${firstnametec.text}',
      'last_name': '${lastnametec.text}',
      'password': '${userpasswordtec.text}',
      'password_confirmation': '${userconpasswordtec.text}',
      'username': '${useremailtec.text}@k2help.com',
      'phone':"${userphonetec.text}",
      'profilephoto':"https://img.freepik.com/free-psd/3d-illustration-business-man-with-glasses_23-2149436194.jpg?t=st=1715867749~exp=1715871349~hmac=99e33e95a5fa6507b30a7a028ce9eeed66d052e5c504377f9ee46358bc943ef4&w=740",
      'uid':userid
    }).then((value){
      print("Data added successfully!");
    }).catchError((error) {
      print("Failed to add data: $error");
    });
  }

  CreateAnAccount(context,uid,fcmtoken) async{
    errorMessage = '';
    update();
    Dio dio = Dio();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var data = {

      'first_name': '${firstnametec.text}',
      'last_name': '${lastnametec.text}',
      'password': '${userpasswordtec.text}',
      'password_confirmation': '${userconpasswordtec.text}',
      'username': '${useremailtec.text}@k2help.com',
      'fcm_token': fcmtoken,
      'phone':"${userphonetec.text}",
      'profilephoto':"https://img.freepik.com/free-psd/3d-illustration-business-man-with-glasses_23-2149436194.jpg?t=st=1715867749~exp=1715871349~hmac=99e33e95a5fa6507b30a7a028ce9eeed66d052e5c504377f9ee46358bc943ef4&w=740",
      'uid': uid
    };
    var response = await dio.post('${hostname}register',
        options: Options(
          headers: headers,
          validateStatus: (status) => true,
        ),
        data: data
    );
    if(response.statusCode==200){
      isLoading = false;
      print(response.data);
      loginController.Login(
          email: useremailtec.text, password:userpasswordtec.text,context: context);
      update();

    }else{
      isLoading = false;
      print(response.data);
      update();
    }
  }

}
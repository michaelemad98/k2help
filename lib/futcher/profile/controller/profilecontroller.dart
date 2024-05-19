import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k2help/helper/sherdprefrence/shardprefKeyConst.dart';
import 'package:k2help/helper/sherdprefrence/sharedprefrenc.dart';

class ProfileController extends GetxController{
  Future GetProfileData()async{
    final currentUser = FirebaseAuth.instance.currentUser;
     return FirebaseFirestore.instance
        .collection('users')
        .doc(
        '${currentUser!.uid}')
        .get();
  }


  LogOut()async{
    CacheHelper.saveData(key: isLoginkey , value: false);
    await FirebaseAuth.instance.signOut();
    Get.offNamed('/mainscreen');

    update();
  }
}
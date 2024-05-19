import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:k2help/helper/constant/constAPI.dart';
import 'package:http/http.dart' as http;
import 'package:k2help/helper/sherdprefrence/shardprefKeyConst.dart';
import 'package:k2help/helper/sherdprefrence/sharedprefrenc.dart';

class CommunityController extends GetxController {
  TextEditingController postTec = TextEditingController();
  List<File> myfilelist = [];
  File? myfile;
  File? file;
  bool isshowDialog = false;
  String? fileName;

  PickImagefromGalary() async {
    XFile? xfile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25);
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

  PickImagefromCamera() async {
    XFile? xfile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);
    myfile = File(xfile!.path);
    fileName = myfile!.path.split('/').last;
    isshowDialog = true;
    myfilelist.add(myfile!);
    update();
  }

  Future<void> CreatePost() async {
    String access_token = CacheHelper.getData(key: access_tokenkey);
    var headers = {'Authorization': 'Bearer ${access_token}'};
    var request =
        http.MultipartRequest('POST', Uri.parse('${hostname}create_post'));
    request.fields.addAll({'post': '${postTec.text}'});
    if (myfile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', '${myfile!.path}'));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      CreatePostonfireStore(
          userid: data['data']['user_id'],
          id: data['data']['id'],
          description: data['data']['description'],
          image: data['data']['image'],
      );
      myfile = null;
      postTec.clear();
      update();
    } else {
      print(response.reasonPhrase);
    }
  }


  CreatePostonfireStore({id, userid, description, image}) async {
    String firstname = CacheHelper.getData(key: userfirstnamekey);
    String lastname = CacheHelper.getData(key: userlastnamekey);
    final currentUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('posts').add({
      'id': id,
      "description": description,
      "created_at": Timestamp.now(),
      "image": image,
      'uid': currentUser!.uid
    });
  }

  var Posts;

  GetPosts() async {
    Dio dio = Dio();
    var response = await dio.get(
      '${hostname}posts',
      options: Options(
        validateStatus: (status) => true,
        // headers: headers,
      ),
    );
    // print("***********************************");
    if (response.statusCode == 200) {
      // print(json.encode(response.data));

      Posts = response.data;
      update();
    } else {
      print(response.statusMessage);
    }
  }
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserData(String userId) async{
    try {
      DocumentSnapshot userDoc = await firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      } else {
        print('User does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  late final Stream<String> textStream;
  late final Function(String) onTextChanged;
  TextEditingController commentTEC = TextEditingController();
  AddCommentonFirestore(docId)async{
    final currentUser = FirebaseAuth.instance.currentUser;
    print(docId);
    print(currentUser!.uid);
    DocumentReference documentRef = FirebaseFirestore.instance.collection('posts').doc(docId);
    Map<String, dynamic> commentdata = {
      'created_at': Timestamp.now(),
      "description": commentTEC.text,
      'useruid':currentUser.uid,
    };
    try{
      await documentRef.collection('comments').add(commentdata);
      print('Subcollection document added successfully');
      commentTEC.clear();
    }catch(e){
      print('Error adding subcollection document: $e');
    }
  }
  TextEditingController replayTEC = TextEditingController();
  AddReplaytofFirestore(docId,commentid)async{
    final currentUser = FirebaseAuth.instance.currentUser;
    DocumentReference documentReplayRef = FirebaseFirestore.instance.collection('posts').doc(docId).collection('comments').doc(commentid);
    Map<String, dynamic> replaydata = {
      'created_at': Timestamp.now(),
      "description": replayTEC.text,
      'useruid':currentUser!.uid,
    };
    try{
      await documentReplayRef.collection('replies').add(replaydata);
      print('Subcollection document added successfully');
      replayTEC.clear();
    }catch(e){
      print('Error adding subcollection document: $e');
    }
  }
  
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    DateFormat dateFormatter = DateFormat("HH:mm a");
    // String formattedDate = dateFormatter.format(dateTime);
    return '${dateFormatter.format(dateTime)}\n${dateTime.day}/${dateTime.month}/${dateTime.year}';
    // Or you can use DateFormat from intl package for more advanced formatting
  }



  bool isLogin = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }



  final ScrollController scrollController = ScrollController();


  @override
  void dispose() {
    scrollController.dispose();
    commentTEC.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k2help/futcher/mainScreen/view/widgets/btnCreate/BtnLogin.dart';
import 'package:k2help/futcher/profile/controller/profilecontroller.dart';
import 'package:k2help/helper/scalesize.dart';
import 'package:k2help/helper/sherdprefrence/shardprefKeyConst.dart';
import 'package:k2help/helper/sherdprefrence/sharedprefrenc.dart';
import 'package:lottie/lottie.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'k2Help',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        actions: [
          GetBuilder(
            init: ProfileController(),
            builder: (controller) {
              return FutureBuilder(
                future: controller.GetProfileData(),
                builder: (context,snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Container();
                  }else if(snapshot.hasData){
                    return Container(
                      margin: EdgeInsets.only(left: 30,right: 30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: InkWell(
                          onTap: () {
                            var isLogin = CacheHelper.getData(key: isLoginkey);
                            print(isLogin);
                            if (isLogin == null || isLogin == false) {
                              isLogin = false;
                              // /*
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Please Login First"),
                                    content: Text(
                                        "You need to log in to access this feature."),
                                    actions: <Widget>[
                                      Expanded(
                                        child: TextButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Get.toNamed('/login');
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: TextButton(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );

                              // */
                              // update();
                            } else {
                              isLogin = true;
                              Get.toNamed('/profileScreen');
                              // update();
                            }

                          },
                          child: Image.network(
                            '${snapshot.data['profilephoto']}',
                            fit: BoxFit.cover,
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                    );
                  }else{
                   return IconButton(onPressed: (){
                     showDialog(
                       context: context,
                       builder: (BuildContext context) {
                         return AlertDialog(
                           title: Text("Please Login First"),
                           content: Text(
                               "You need to log in to access this feature."),
                           actions: <Widget>[
                             Expanded(
                               child: TextButton(
                                 child: Text("OK"),
                                 onPressed: () {
                                   Get.toNamed('/login');
                                 },
                               ),
                             ),
                             Expanded(
                               child: TextButton(
                                 child: Text("Cancel"),
                                 onPressed: () {
                                   Get.back();
                                 },
                               ),
                             ),
                           ],
                         );
                       },
                     );
                   }, icon: Icon(Icons.account_circle_rounded,color: Colors.white,));
                  }
                }
              );
            }
          ),

        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      'What\nHappend ?',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                        textScaleFactor: ScaleSize.textScaleFactor(context),
                        textAlign: TextAlign.center,
                    )),
                Center(
                  child: Image.asset(
                    'assets/images/help.png',
                    width:height >=1366.0? width *0.5:width *0.7,
                    height: height >=1366.0? width *0.5:width *0.7,
                  ),
                ),
                Center(
                    child: BtnLogin(
                  btntxt: 'help',
                  press: () {
                    // Get.toNamed('/helpscreen');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.grey.shade800,
                            content: Container(
                              height: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.help,
                                    color: Colors.orange.shade800,
                                    size: 50,
                                  ),
                                  BtnLogin(
                                      btntxt: 'I need Help',
                                      press: () {
                                        Get.toNamed('/helpscreen',arguments: ['need']);
                                      }),
                                  BtnLogin(
                                      btntxt: ' I wanna help \nsome one else',
                                      press: () {
                                        Get.toNamed('/helpscreen',arguments: ['wanna']);
                                      }),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                )),
                Center(
                    child: BtnLogin(
                  btntxt: 'Community',
                  press: () {
                    Get.toNamed('/communityScreen');
                  },
                )),
                Center(
                    child: BtnLogin(
                  btntxt: 'I want to be a volunteer',
                  press: () {
                    Get.toNamed('/volunteersScreen');
                  },
                )),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(

        backgroundColor: Colors.orange.shade800,
        onPressed: () {
          Get.toNamed('/aboutScreen');
        },
        child: Icon(
          Icons.info_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}

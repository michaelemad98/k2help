import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k2help/futcher/profile/controller/profilecontroller.dart';
import 'package:k2help/helper/scalesize.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade900,
      body:GetBuilder(
        init: ProfileController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        )
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(35),
                            bottomLeft: Radius.circular(35),),child: Image.asset('assets/images/profile_cover.webp',fit: BoxFit.cover,))),
                  Positioned(
                    left: 20,
                    top: 40,
                    child: CircleAvatar(
                      backgroundColor: Colors.white ,
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        child: IconButton(onPressed: (){
                          Get.back();
                        }, icon: Icon(Icons.arrow_back_ios,color: Colors.orange.shade900,)),
                      ),
                    ),
                  ),
                ],
              ),

              FutureBuilder(
                  future: controller.GetProfileData(),
                builder: (context,snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Container();
                  }else if(snapshot.hasData){
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(45),bottomRight: Radius.circular(45)),
                        // border: Border.all(color: Colors.white)

                      ),
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(top: 10,right: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${snapshot.data['first_name']} ${snapshot.data['last_name']}',
                                  style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30
                                  ),
                                  textScaleFactor: ScaleSize.textScaleFactor(context),
                                  textAlign: TextAlign.center,
                                ),
                                Text('@${snapshot.data['username'].split('@k2help.com')[0]}',
                                  style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 25
                                  ),
                                  textScaleFactor: ScaleSize.textScaleFactor(context),
                                  textAlign: TextAlign.center,
                                ),

                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Transform.scale(
                                scale: 1.5,
                                origin: Offset(0,-40),
                                alignment: Alignment.center,
                                child: Image.network(
                                  '${snapshot.data['profilephoto']}',
                                  fit: BoxFit.cover,
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }else{
                    return Container();
                  }
                }
              ),

              Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('Languange',
                        style: TextStyle(color: Colors.white,
                        fontSize: 30
                        ),
                        ),
                      ),
                      Icon(Icons.language,color: Colors.white,)
                    ],
                  ),
                ),
              ),

              Center(
                child: InkWell(
                  onTap: (){
                    controller.LogOut();
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text('Logout',
                          style: TextStyle(color: Colors.white,
                          fontSize: 30
                          ),
                          ),
                        ),
                        Icon(Icons.logout,color: Colors.white,)
                      ],
                    ),
                  ),
                ),
              )


            ],
          );
        }
      ) ,
    );
  }
}

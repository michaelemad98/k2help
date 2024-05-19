import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k2help/futcher/helpScreen/controller/helpcontroller.dart';
import 'package:k2help/futcher/helpScreen/view/widgets/btncountry.dart';
import 'package:k2help/futcher/helpScreen/view/widgets/btnhelp.dart';
import 'package:k2help/futcher/helpScreen/view/widgets/edttxt/edttxtphone.dart';
import 'package:k2help/futcher/helpScreen/view/widgets/edttxt/textarea.dart';
import 'package:k2help/futcher/mainScreen/view/widgets/btnCreate/BtnLogin.dart';
import 'package:k2help/helper/scalesize.dart';

import '../../models/countriesmodel.dart';
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('k2Help',style: TextStyle(color: Colors.white),
          textScaleFactor: ScaleSize.textScaleFactor(context),

        ),
        centerTitle: false,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
        onPressed: (){
          Get.back();
        }
        ),
      ),
      body: GetBuilder(
        init:HelpController() ,
        builder: (controller) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('What happened?',style: TextStyle(color: Colors.white,),
                            textScaleFactor: ScaleSize.textScaleFactor(context),
              
                          ),
                          Text(controller.data[0]=='need'?'I need Help':'I wanna help \nsome one else',style: TextStyle(color: Colors.white,),
                            textScaleFactor: ScaleSize.textScaleFactor(context),
                            textAlign: TextAlign.center ,
              
                          ),
                        ],
                      )),
                  EDTPhone(
                    hintText: 'firstname',
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    tec: controller.firstnametec,
                  ),
                  EDTPhone(
                    hintText: 'lastname',
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    tec: controller.lastnametec,
                  ), EDTPhone(
                    hintText: 'phone number',
                    keyboardType: TextInputType.phone,
                    obscureText: false,
                    tec: controller.phonetec,
                  ),
                  EDTArea(
                    hintText: 'Type What happened',
                    keyboardType: TextInputType.multiline,
                    obscureText:false,
                    tec: controller.descriptiotec,
                  ),
              
                  Container(
                    margin: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
              
                        Center(
                          child: BtnHelp(
                            backGroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            press: (){
                            },
                            btntxt: 'Upload photo',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: BtnHelp(
                      backGroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      press: (){
                        controller.ShowLoaction();
                      },
                      btntxt: 'Add Location',
                    ),
                  ),
                 controller.showlocation? Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Column(
                          children: [
                    BtnCountry(btntxt: 'To Send Current Location', press: () {
                      controller.GetCurrentLocation();
                    },
                    ),
                      Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BtnCountry(btntxt: 'states', press: () async {
                                  await controller.GetCpunteries();
                                  showModalBottomSheet(
                                    backgroundColor: Colors.orange,
                                    context: context,
                                    builder: (context){
                                      return Container(
                                        child: FutureBuilder(
                                          future:controller.GetCpunteries() ,
                                          builder: (context,snapshot) {
                                            if(snapshot.connectionState == ConnectionState.waiting){
                                            return Center(child: CircularProgressIndicator(),);
                                            }else{
                                              CountryModel coubtryModel = CountryModel();
                                              coubtryModel= CountryModel.fromJson(snapshot.data);
                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: coubtryModel.data!.length,
                                                  itemBuilder: (context,index){
                                                    return Directionality(
                                                      textDirection: TextDirection.rtl,
                                                      child: Container(
                                                        margin: EdgeInsets.all(10),
                                                        child: InkWell(
                                                            onTap: (){
                                                              controller.Setupdaate(coubtryModel.data![index].name,index);
                                                              Get.back();
                                                            }
                                                            ,child: Text('${coubtryModel.data![index].name}',style: TextStyle(color: Colors.white),)),),
                                                    );
                                                  });
                                            }
                                          }
                                        ),
                                      );
                                    }
                                  );
                                },
                                ),
                                Text('${controller.State}',style: TextStyle(color: Colors.white),),
                              ],
                            ),
                            controller.isShowCity?Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                BtnCountry(btntxt: 'cities', press: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.orange,
                                      context: context,
                                      builder: (context){
                                        return Container(
                                          child:ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: controller.cities.length,
                                              itemBuilder: (context,index){
                                                return Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: InkWell(
                                                        onTap: (){
                                                          controller.SetCity(controller.cities[index].name,index);
                                                          Get.back();
                                                        }
                                                        ,child: Text('${controller.cities[index].name}',style: TextStyle(color: Colors.white),)),),
                                                );
                                              }),
                                        );
                                      }
                                  );
                                },
                                ),
                                Text('${controller.City}',style: TextStyle(color: Colors.white),),
                              ],
                            ):Container(),
                          controller.isShowStreet?  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BtnCountry(btntxt: 'streets', press: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.orange,
                                      context: context,
                                      builder: (context){
                                        return Container(
                                          child:ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: controller.streets.length,
                                              itemBuilder: (context,index){
                                                return Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: InkWell(
                                                        onTap: (){
                                                          controller.setStreet(controller.streets[index].name,controller.streets[index].id);
                                                          Get.back();
                                                        }
                                                        ,child: Text('${controller.streets[index].name}',style: TextStyle(color: Colors.white),)),),
                                                );
                                              }),
                                        );
                                      }
                                  );
                                },

                                ),
                                Text('${controller.Street}',style: TextStyle(color: Colors.white),),

                              ],
                            ):Container(),
              
                          ],
                        ),

                      ],
                    ),
                  ):Container(),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: BtnLogin(
                      press: (){
                        print(controller.streetid);
                        controller.CreateHelp();
                      },
                      btntxt: 'Send to Help',
                    ),
                  ),
                  controller.data[0]=='need'?Container():
                  Center(
                    child: BtnLogin(
                      btntxt: 'I want to be a volunteer',
                      press: () {
                        Get.toNamed('/volunteersScreen');
                      },
                    )
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

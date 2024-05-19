import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k2help/futcher/helpScreen/models/countriesmodel.dart';
import 'package:k2help/futcher/helpScreen/view/widgets/btncountry.dart';
import 'package:k2help/futcher/helpScreen/view/widgets/btnhelp.dart';
import 'package:k2help/futcher/helpScreen/view/widgets/edttxt/edttxtphone.dart';
import 'package:k2help/futcher/mainScreen/view/widgets/btnCreate/BtnLogin.dart';
import 'package:k2help/futcher/volunteersScreen/controller/volunteersController.dart';

class VolunteersScreen extends StatelessWidget {
  const VolunteersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('k2Help',style: TextStyle(color: Colors.white),),
        centerTitle: false,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
            onPressed: (){
              Get.back();
            }
        ),
      ),
      body: GetBuilder(
        init: VolunteersController(),
        builder: (controller) {
          return Container(
            width: double.infinity,
              height: double.infinity,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                  margin: EdgeInsets.all(16),
                  child: Text('Regester as Volunteers',style: TextStyle(color: Colors.white,),)),

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
              EDTPhone(
                hintText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                tec: controller.emailtec,
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
                  press: (){},
                  btntxt: 'Register',
                ),
              ),
            ],
          ),
          );
        }
      ),
    );
  }
}

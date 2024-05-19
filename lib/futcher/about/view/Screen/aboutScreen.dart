import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k2help/futcher/about/controller/aboutcontroller.dart';
import 'package:k2help/futcher/about/controller/faqsController.dart';
import 'package:k2help/futcher/about/models/faqmodel.dart';
import 'package:k2help/futcher/about/view/widgets/edttxtcomment/edtcomment.dart';
import 'package:k2help/futcher/helpScreen/view/widgets/edttxt/edttxtphone.dart';
import 'package:k2help/helper/scalesize.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
            textScaleFactor: ScaleSize.textScaleFactor(context),
          ),
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          actions: [
            Container(
                margin: EdgeInsets.all(10),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ))
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              Container(
                padding:EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Descraption :',style: TextStyle(fontSize: 25,color: Colors.orange.shade800,fontWeight: FontWeight.w900),
                      textScaleFactor: ScaleSize.textScaleFactor(context),
                    ),
                    GetBuilder(
                      init: AboutController(),
                      builder: (controller) {
                        return FutureBuilder(future: controller.GetAboutDescription(),
                          builder: (context,snapshot) {
                            return Text(
                              '${controller.descriptoinAbt}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textScaleFactor: ScaleSize.textScaleFactor(context),
                            );
                          }
                        );
                      }
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Q&A',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 30),
                          textScaleFactor: ScaleSize.textScaleFactor(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GetBuilder(
                          init: FAQSCotroller(),
                          builder: (controller) {
                            return FutureBuilder(future: controller.GetFAQS(),
                                builder:  (context,snapshot) {
                                 if(snapshot.hasData){
                                   GetFaqModel faqModel = GetFaqModel();
                                   faqModel = GetFaqModel.fromJson(snapshot.data);
                                   return Container(
                                     padding: EdgeInsets.all(20),
                                     decoration: BoxDecoration(
                                       color: Colors.white,
                                       border: Border.all(color: Colors.orange.shade800,width: 2),
                                       borderRadius: BorderRadius.circular(22),
                                     ),
                                     // height: height*0.45,
                                     child: ListView.builder(
                                         shrinkWrap: true,
                                         itemCount: faqModel.data!.length,
                                         itemBuilder: (context,index){
                                           return Container(

                                             child: ExpansionTile(
                                               title: Text('${faqModel.data![index].question}',style: TextStyle(fontSize: 20,color: Colors.orange.shade800,fontWeight: FontWeight.w900),
                                                 textScaleFactor: ScaleSize.textScaleFactor(context),
                                               ),
                                               children:[

                                                 Container(
                                                   padding: EdgeInsets.all(10),
                                                   child: Text('${faqModel.data![index].answer}',style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),
                                                     textScaleFactor: ScaleSize.textScaleFactor(context),
                                                   ),
                                                 )   ],
                                             ),
                                           );
                                         }),
                                   );
                                 }
                                 else if (snapshot.connectionState == ConnectionState.waiting){
                                   return Center(child: CircularProgressIndicator(),);
                                 }
                                 else{
                                  return Container();
                                 }
                              }
                            );
                          }
                        ),
                
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    // Divider(color: Colors.white,),

                    EDTComment()

                  ],
                ),
              ),
            ],
          ),
        ));
  }
}


/*
Container(
                              margin: EdgeInsets.all(16),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.orange.shade800,width: 3),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('How can Send Help ?',style: TextStyle(fontSize: 20,color: Colors.orange.shade800,fontWeight: FontWeight.w900),
                                        textScaleFactor: ScaleSize.textScaleFactor(context),
                                      ),
                                      IconButton(icon: Icon(Icons.arrow_drop_down_outlined,),onPressed: (){},),
                                    ],
                                  ),

                                  Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum',style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600),
                                    textScaleFactor: ScaleSize.textScaleFactor(context),
                                  )
                                ],
                              ),
                            );
 */
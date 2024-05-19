
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k2help/futcher/auth/controller/signUpcontroller.dart';
import 'package:k2help/futcher/auth/view/widgets/btn/authbtn.dart';
import 'package:k2help/futcher/auth/view/widgets/edittxt/edittex.dart';
import 'package:k2help/helper/scalesize.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40,),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Nirmala UI',
                    fontWeight: FontWeight.w700,
                  ),
                  textScaleFactor: ScaleSize.textScaleFactor(context),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    border: Border.all(color: Colors.white,width: 1),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: GetBuilder(
                    init: SignUpController(),
                    builder: (controller) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AuthEditTxt(hintText: 'First Name', obscureText: false,
                                prefixIcon: Icon(Icons.edit,color: Colors.white,
                                size:30,
                                ),
                                  tec: controller.firstnametec,
                                ),
                              ),
                              Expanded(
                                child: AuthEditTxt(hintText: 'Last Name', obscureText: false,
                                  prefixIcon: Icon(Icons.edit,color: Colors.white,
                                    size:30,
                                  ),
                                  tec: controller.lastnametec,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16,),


                          AuthEditTxt(hintText: 'Username', obscureText: false,
                          prefixIcon: Icon(Icons.account_circle_outlined,color: Colors.white,
                          size:30,
                          ),
                            tec: controller.useremailtec,
                          ),
                          SizedBox(height: 16,),
                          AuthEditTxt(hintText: 'Phone', obscureText: false,
                          prefixIcon: Icon(Icons.phone_android,color: Colors.white,
                          size:30,
                          ),
                            tec: controller.userphonetec,
                          ),
                          SizedBox(height: 16,),

                          AuthEditTxt(hintText: 'password', obscureText: true,
                          prefixIcon: Icon(Icons.password,color: Colors.white,),
                            tec: controller.userpasswordtec,
                          ),
                          SizedBox(height: 16,),

                          AuthEditTxt(hintText: 'confirm password', obscureText: true,
                          prefixIcon: Icon(Icons.password,color: Colors.white,),
                            tec: controller.userconpasswordtec,
                          ),
                          SizedBox(height: 16,),
                          Text('${controller.errorMessage}',
                            textScaleFactor: ScaleSize.textScaleFactor(context),
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30,),
                          AuthBtn(btntxt: 'Sign Up',btnonPressed: (){
                            controller.SignUPWithEmailandPassword(context);
                            // controller.AddDatatoFireStore(userid: 'sss',name: 'name',password: 'aaa',email: 'ssss');
                          },
                          isload: controller.isLoading,
                          ),
                        ],
                      );
                    }
                  ),
                ),
                SizedBox(height: 40,),
                InkWell(
                  onTap: (){
                    Get.toNamed('/login');
                  },
                  child: Text(
                    'Have An Account ?  Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Nirmala UI',
                      fontWeight: FontWeight.w700,
                    ),
                    textScaleFactor: ScaleSize.textScaleFactor(context),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top:30,left: 30,right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Powered by Tadafuq',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.16,
                          fontFamily: 'Nirmala UI',
                          fontWeight: FontWeight.w400,
                        ),
                        textScaleFactor: ScaleSize.textScaleFactor(context),
                      ),
                      Row(
                        children: [
                          Text(
                            'K2 Help',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.16,
                              fontFamily: 'Nirmala UI',
                              fontWeight: FontWeight.w400,

                            ),
                            textScaleFactor: ScaleSize.textScaleFactor(context),

                          ),
                          // Icon(Icons.copyright,color: Colors.white,size: 16,)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

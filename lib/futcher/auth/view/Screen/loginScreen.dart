import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k2help/futcher/auth/controller/LoginController.dart';
import 'package:k2help/futcher/auth/view/widgets/btn/authbtn.dart';
import 'package:k2help/futcher/auth/view/widgets/edittxt/edittex.dart';
import 'package:k2help/helper/scalesize.dart';

class LoginScrren extends StatelessWidget {
  const LoginScrren({super.key});

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
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Nirmala UI',
                    fontWeight: FontWeight.w700,
                  ),
                  textScaleFactor: ScaleSize.textScaleFactor(context),
                ),
                SizedBox(height: 40,),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    border: Border.all(color: Colors.white,width: 1),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: GetBuilder(
                    init: LoginController(),
                      builder: (controller) {
                      return Column(
                        children: [

                          AuthEditTxt(hintText: 'username', obscureText: false,
                            prefixIcon: Icon(Icons.account_circle_rounded,color: Colors.white,
                              size:30,
                            ),
                            tec: controller.useremailtec,
                          ),
                          SizedBox(height: 16,),

                          AuthEditTxt(hintText: 'password', obscureText: true,
                            prefixIcon: Icon(Icons.password,color: Colors.white,),
                            tec: controller.userpasswordtec,
                          ),
                          SizedBox(height: 16,),

                          Text('${controller.errorMessage}',
                              textScaleFactor: ScaleSize.textScaleFactor(context),
                              style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30,),
                          AuthBtn(

                            btntxt: 'Login',btnonPressed:
                            (){
                            controller.Login(email: "${controller.useremailtec.text}@k2help.com",password: controller.userpasswordtec.text,context: context);
                            // Get.offAllNamed('/navigator');
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
                    // Get.to(()=>);
                  },
                  child: InkWell(
                    onTap: (){
                      Get.toNamed('/signup');
                    },
                    child: Text(
                      'Don\'t have an Account?',
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
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

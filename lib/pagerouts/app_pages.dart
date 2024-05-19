


import 'package:get/get.dart';
import 'package:k2help/futcher/about/view/Screen/aboutScreen.dart';
import 'package:k2help/futcher/auth/view/Screen/SignupScreen.dart';
import 'package:k2help/futcher/auth/view/Screen/loginScreen.dart';
import 'package:k2help/futcher/bass/view/scren/bassem.dart';
import 'package:k2help/futcher/community/view/Screen/communityScreen.dart';
import 'package:k2help/futcher/helpScreen/view/screen/HelpScreen.dart';
import 'package:k2help/futcher/mainScreen/view/screen/MainScreen.dart';
import 'package:k2help/futcher/profile/view/Screen/profileScreen.dart';
import 'package:k2help/futcher/volunteersScreen/view/Screen/VolunteersScreen.dart';


part 'app_routes.dart';
class AppPages{
  static final routes=[

    GetPage(name: _Paths.MAINSCREEN, page: ()=>MainScreen()),
    GetPage(name: _Paths.HELPSCREEN, page: ()=>HelpScreen()),
    GetPage(name: _Paths.VOLUNTEERSSCREEN, page: ()=>VolunteersScreen()),
    GetPage(name: _Paths.ABOUTSCREEN, page: ()=>AboutScreen()),
    GetPage(name: _Paths.COMMUNITYSCREEN, page: ()=>CommunityScreen()),
    GetPage(name: _Paths.BASSEMSCREEN, page: ()=>BassemScreen()),

    GetPage(name: _Paths.ProfileScreen, page: ()=>ProfileScreen(),transition:Transition.rightToLeftWithFade ),
    GetPage(name: _Paths.SIGNUP, page: ()=>SignUpScreen(),transition:Transition.zoom ),
    GetPage(name: _Paths.LOGIN, page: ()=>LoginScrren(),transition:Transition.fade ),



  ];
}

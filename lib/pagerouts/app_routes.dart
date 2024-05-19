part of 'app_pages.dart';

abstract class Routes{

  Routes._();
  static const MIANSCREEN= _Paths.MAINSCREEN;
  static const HELPSCREEN= _Paths.HELPSCREEN;
  static const VOLUNTEERSSCREEN= _Paths.VOLUNTEERSSCREEN;
  static const ABOUTSCREEN= _Paths.ABOUTSCREEN;
  static const COMMUNITYSCREEN= _Paths.COMMUNITYSCREEN;
  static const BASSEMSCREEN= _Paths.BASSEMSCREEN;
  static const LOGIN= _Paths.LOGIN;
  static const SIGNUP= _Paths.SIGNUP;
  static const ProfileScreen= _Paths.ProfileScreen;
}
abstract class _Paths{
  static const MAINSCREEN = '/mainscreen';
  static const HELPSCREEN = '/helpscreen';
  static const VOLUNTEERSSCREEN = '/volunteersScreen';
  static const ABOUTSCREEN = '/aboutScreen';
  static const COMMUNITYSCREEN = '/communityScreen';
  static const BASSEMSCREEN = '/bassemScreen';
  static const ProfileScreen = '/profileScreen';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
}

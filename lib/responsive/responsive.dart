import 'package:flutter/material.dart';


const double  mobileSize=280.0;
const double  tabSized=720.0;
const double  webSized=1300.0;


class ResponsiveLayoutUser{


  static Widget? getResponsiveWidget(BuildContext context,{Widget? mobile,Widget? web,Widget? tab}){

      if(isTab(context) && tab != null) return tab;
      else if(isWeb(context) && web != null) return web;
    return mobile;
  }

  static bool isMobile(BuildContext context){
    Size screenSize=MediaQuery.of(context).size;
    return screenSize.width >=mobileSize && screenSize.width <tabSized;
  }

  static bool isTab(BuildContext context){
    Size screenSize=MediaQuery.of(context).size;
    return screenSize.width >=tabSized && screenSize.width <webSized;
  }

  static bool isWeb(BuildContext context){
    Size screenSize=MediaQuery.of(context).size;
    return screenSize.width >=webSized;
  }
}

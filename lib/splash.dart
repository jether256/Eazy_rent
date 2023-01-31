import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eazy_rent/shared/pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logged/dashonwer.dart';
import 'notlogged/dashbo.dart';


class Splash extends StatefulWidget {

  static const  String id='splash';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  String? userID,name,email,num, pass, pic,lon, lat,ad, token,renew,status,type,log,create,cry,uup,fcmi;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      userID = sharedPreferences.getString(PrefInfo.ID);
      name = sharedPreferences.getString(PrefInfo.name);
      email = sharedPreferences.getString(PrefInfo.email);
      num = sharedPreferences.getString(PrefInfo.num);
      pass = sharedPreferences.getString(PrefInfo.pass);
      pic = sharedPreferences.getString(PrefInfo.pic);
      lon = sharedPreferences.getString(PrefInfo.lon);
      lat = sharedPreferences.getString(PrefInfo.lat);
      ad = sharedPreferences.getString(PrefInfo.ad);
      token = sharedPreferences.getString(PrefInfo.token);
      renew = sharedPreferences.getString(PrefInfo.renew);
      status = sharedPreferences.getString(PrefInfo.status);
      type = sharedPreferences.getString(PrefInfo.type);
      log = sharedPreferences.getString(PrefInfo.log);
      create = sharedPreferences.getString(PrefInfo.create);
      fcmi = sharedPreferences.getString(PrefInfo.fcm);
    });
  }


  @override
  void initState() {
    getPref();


    Timer( const Duration(seconds: 0,),(){


      getPref1();


    });

    super.initState();
  }



  String? ID1;
  //String? Type;

  getPref1() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      ID1=sharedPreferences.getString(PrefInfo.ID);
      ID1== null ? sessionLogout():sessionLogin();

     /// Navigator.pushReplacementNamed(context, DashNot.id);

    });
  }


  sessionLogout() {
    Navigator.pushReplacementNamed(context,DashNot.id);
  }

  sessionLogin() {

    Navigator.pushReplacementNamed(context,DashBoardLogged.id);

  }


  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.black,
      Colors.blue,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 40.0,
         );


    return Scaffold(

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Image.asset('assets/images/loo.png',height: 200,),
            const SizedBox(height: 10,),

            // AnimatedTextKit(
            //   animatedTexts: [
            //     ColorizeAnimatedText(
            //       'Eazy Rent',
            //       textStyle: colorizeTextStyle,
            //       colors: colorizeColors,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
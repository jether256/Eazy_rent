
import 'package:eazy_rent/notlogged/dashbo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import '../crypt/encrypt.dart';
import '../logged-signup/login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../screens/charts.dart';
import '../shared/pref.dart';


class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {


  final StreamController<List> _streamController = StreamController<List>();
  Timer? _timer;





  Future getData() async {


    var response = await http.get(
        Uri.parse("https://www.eazyrent256.com/api/user/mess/lastmess.php"),
        headers: {"Accept": "headers/json"});



    // var response = await http.post(
    //     Uri.parse("https://www.eazyrent256.com/api/user/mess/lastmess.php"),
    //     headers: {"Accept": "headers/json"}, body: {
    //   "uid":encryp('$userID'),
    // });

    if (response.statusCode == 200) {

      List data = json.decode(response.body);
      _streamController.add(data);

    }
  }

  @override
  void initState() {
    getData();
    getPref();
    //Check the server every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) => getData());

    super.initState();
  }

  @override
  void dispose() {
    //cancel the timer
    if (_timer!.isActive) _timer!.cancel();

    super.dispose();
  }



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


  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefInfo.ID);
    sharedPreferences.remove(PrefInfo.name);
    sharedPreferences.remove(PrefInfo.email);
    sharedPreferences.remove(PrefInfo.num);
    sharedPreferences.remove(PrefInfo.pass);
    sharedPreferences.remove(PrefInfo.pic);
    sharedPreferences.remove(PrefInfo.lon);
    sharedPreferences.remove(PrefInfo.lat);
    sharedPreferences.remove(PrefInfo.ad);
    sharedPreferences.remove(PrefInfo.token);
    sharedPreferences.remove(PrefInfo.renew);
    sharedPreferences.remove(PrefInfo.status);
    sharedPreferences.remove(PrefInfo.type);
    sharedPreferences.remove(PrefInfo.log);
    sharedPreferences.remove(PrefInfo.create);

    logout();
  }


  logout(){
    Navigator.pushReplacementNamed(context,DashNot.id);
  }

  _scaffold(message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(message),
      action: SnackBarAction(label: 'ok',onPressed: (){
        ScaffoldMessenger.of(context).clearSnackBars();
      },),));
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.lightBlue,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Contact Us', style: TextStyle(color: Colors.white,),),
        ),
        body: ListView(
          shrinkWrap: true,
          padding:const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
          children: [


            const SizedBox(height: 10,),

            InkWell(
              onTap:(){

                _makePhoneCall('+256778316724');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Icon(Icons.call,size: 40,),
                  Expanded(child: Text('+256778316724',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 17),)),
                ],
              ),
            ),

            const SizedBox(height: 10,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Icon(Icons.mail,size: 40,),
                Expanded(child: Text('eazyrent@gmail.com',maxLines: 2,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 17),)),
              ],
            ),

            const SizedBox(height: 10,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Image.asset('assets/images/facebook.png',height: 40,width: 40,),
                Expanded(child: Text(' Facebook',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 17),)),
              ],
            ),

            const SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Image.asset('assets/images/twitter.png',height: 40,width: 40,),
                Expanded(child: Text(' Twitter',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 17),)),
              ],
            ),

            const SizedBox(height: 10,),


            InkWell(
              onTap: (){

                openWhatsapp();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Image.asset('assets/images/whatsapp.png',height: 40,width: 40,),
                  Expanded(child: Text('Whatsapp',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 17),)),
                ],
              ),
            ),

            const SizedBox(height: 10,),

          ],
        )
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path:phoneNumber,
    );
    await launchUrl(launchUri);
  }



  openWhatsapp() async {

    String whatsapp = '+256778316724';
    String whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=Hallo Eazy Rent";
    String whatsappURLIos =
        "https://wa.me/$whatsapp?text=${Uri.parse("Hallo Eazy Rent ")}";
    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(whatsappURLIos));
      } else {
        _scaffold("Whatsapp not installed");
      }
    } else {
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        _scaffold("Whatsapp not installed");
      }
    }
  }



}

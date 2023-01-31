import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../notlogged/dashbo.dart';
import '../shared/pref.dart';

class Terms extends StatefulWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {


  final StreamController<List> _streamController = StreamController<List>();
  Timer? _timer;


  Future getData() async {
    var response = await http.get(
        Uri.parse("https://www.eazyrent256.com/api/user/conatct/terms.php"),
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {

      List data = json.decode(response.body);
      //Add your data to stream
      _streamController.add(data);

    }
  }


  @override
  void initState() {
    getPref();
    getData();


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


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar:AppBar(
            //leading: IconButton(icon:const Icon(Icons.menu), onPressed: () {  },),
            //leading: Image.asset("assets/images/logo.png",color: Colors.white,),
            title: const Text('Terms and Privacy Policy',style: TextStyle(color: Colors.white),),
            actions: [
              IconButton(icon:const Icon(Icons.login_outlined), onPressed: () {

                signOut();
              },),
              //IconButton(icon:const Icon(Icons.logout), onPressed: () {  },),
              IconButton(icon:const Icon(Icons.notifications), onPressed: () {  },),
            ],
            elevation: 2,
            centerTitle: true,
            backgroundColor:Colors.lightBlue,
            // shape: const RoundedRectangleBorder(
            //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
            // ),
            //flexibleSpace: Image.asset('assets/images/logo.png',fit: BoxFit.cover,),
          ) ,
          body: StreamBuilder<List>(
            stream: _streamController.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {

                if(snapshot.data==0){

                  return  Center(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('No Terms And Policy',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    ],
                  ));
                }




                return ListView(

                  shrinkWrap: true,
                  children: [
                    for (Map document in snapshot.data)

                      Card(
                        //color: Colors.grey.shade500,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 20,),



                              Text(document['descc']),

                            ],
                          ),
                        ),
                      ),
                  ],
                );


              }
              return const Text('Loading...');
            },
          ),

      ),
    );
  }



}

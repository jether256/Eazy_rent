import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../notlogged/dashbo.dart';
import '../shared/pref.dart';
import 'appinfo.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {


  final StreamController<List> _streamController = StreamController<List>();

  Timer? _timer;



  Future getData() async {
    var response = await http.get(
        Uri.parse("https://www.eazyrent256.com/api/user/about/about.php"),
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
          title: const Text('Settings',style: TextStyle(color: Colors.white),),
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
        body: ListView(
          shrinkWrap: true,
          padding:const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
          children:  [



            ListTile(leading: const Icon(Icons.file_copy_outlined),
              horizontalTitleGap: 2,
              title: InkWell(
                  onTap: (){


                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Terms(),
                        )
                    );


                  },
                  child: const Text('Terms And Privacy Policy')),
            ),

            const Divider(),

            ListTile(leading: const Icon(Icons.info_outline),
              horizontalTitleGap: 2,
              title: InkWell(
                  onTap: (){


                    showDialog(context: context, builder: (BuildContext context){
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(10.0)),
                        child: Container(
                          alignment: Alignment.topCenter,
                          width:MediaQuery.of(context).size.width/2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [

                              AppBar(
                                title:const Center(child: Text('App Info',style: TextStyle(fontSize: 20),)),
                              ),

                              const SizedBox(height: 10,),

                              StreamBuilder<List>(
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
                                           // color: Colors.grey.shade500,
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

                              const SizedBox(height: 10,),


                            ],

                          ),
                        ),
                      );
                    });

                  },
                  child: const Text('App Info')),
            ),

            const Divider(),


          ],
        )

      ),
    );
  }



}

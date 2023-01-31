
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../notlogged/dashbo.dart';
import '../shared/pref.dart';

class CustomAppNot extends StatefulWidget {
  const CustomAppNot({Key? key}) : super(key: key);

  @override
  State<CustomAppNot> createState() => _CustomAppNotState();
}

class _CustomAppNotState extends State<CustomAppNot> {





  String id1 = "";
  String name1 = "";


  @override
  void initState() {
    super.initState();

    getPref();
    showAdu();

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




  // var adures;
  //
  // Future fetchLoc() async {
  //   var response = await http.post(
  //       Uri.parse("https://manjether.000webhostapp.com/layisi/ad.php"),
  //       headers: {"Accept": "headers/json"},body:{'id':'$id1'});
  //
  //   if (response.statusCode == 200) {
  //
  //     setState(() {
  //       adures=response.body;
  //     });
  //
  //   }
  //
  //   print('Your location is $adures');
  //
  // }


  late List adu = [];


  Future showAdu() async {
    var response = await http.post(
        Uri.parse("https://www.eazyrent256.com/api/user/ad.php"),
        headers: {"Accept": "headers/json"},body:{'id':'$userID'});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        adu = jsonData;
      });
      print(jsonData);
      return jsonData;
    }
  }




  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future:showAdu(),
        //initialData: [],
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){

          if (snapshot.hasData) {

            return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: adu.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: AppBar(
                      //leading: IconButton(icon:const Icon(Icons.menu), onPressed: () {  },),
                      leading: Image.asset("assets/images/logo.png",color: Colors.white,),
                      title:MaterialButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                             Text( adu[index]['addr'],style: TextStyle(color: Colors.white),),

                            IconButton(icon:const Icon(Icons.edit_outlined,color: Colors.white,), onPressed: () {




                            },),


                          ],
                        ),
                        onPressed: () {

                        },
                      ),
                      actions: [
                        IconButton(icon:const Icon(Icons.account_circle_outlined), onPressed: () {


                          signOut();

                        },),
                        //IconButton(icon:const Icon(Icons.logout), onPressed: () {  },),

                      ],
                      elevation: 0,
                      centerTitle: true,
                      backgroundColor:Colors.lightBlue,
                      bottom:  PreferredSize(
                        preferredSize: const Size.fromHeight(56),
                        child:Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search Rentals,apartments,land,office space, bangalows,air bnb',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                  ),

                                ),
                              ),
                              IconButton(icon:const Icon(Icons.notifications,color: Colors.white,), onPressed: () {  },),
                            ],
                          ),
                        ) ,
                      ),
                      // shape: const RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                      // ),
                      //flexibleSpace: Image.asset('assets/images/logo.png',fit: BoxFit.cover,),
                    ),
                  );

                });

          } else {


            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: AppBar(
                //leading: IconButton(icon:const Icon(Icons.menu), onPressed: () {  },),
                leading: Image.asset("assets/images/logo.png",color: Colors.white,),
                title:MaterialButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(' Address',style: TextStyle(color: Colors.white),),

                      IconButton(icon:const Icon(Icons.edit_outlined,color: Colors.white,), onPressed: () {

                      },),


                    ],
                  ),
                  onPressed: () {

                  },
                ),
                actions: [
                  IconButton(icon:const Icon(Icons.account_circle_outlined), onPressed: () {


                    //signOut();

                  },),
                  //IconButton(icon:const Icon(Icons.logout), onPressed: () {  },),

                ],
                elevation: 0,
                centerTitle: true,
                backgroundColor:Colors.lightBlue,
                bottom:  PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child:Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search Rentals,apartments,land,office space, bangalows,air bnb',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.zero,
                              filled: true,
                              fillColor: Colors.grey[300],
                            ),

                          ),
                        ),
                        IconButton(icon:const Icon(Icons.notifications,color: Colors.white,), onPressed: () {  },),
                      ],
                    ),
                  ) ,
                ),
                // shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                // ),
                //flexibleSpace: Image.asset('assets/images/logo.png',fit: BoxFit.cover,),
              ),
            );


          }
        }

    );
  }
}

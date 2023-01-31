
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../logged-signup/login.dart';

import '../notlogged/dashbo.dart';

import '../shared/pref.dart';
import 'account.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  String _location='';
  String _adress='';

  @override
  void initState() {
    getLoc();
    getPref();
    super.initState();
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


  String? loke;
  getLoc() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    loke = sharedPreferences.getString(PrefInfo.ID);


    String? loco=sharedPreferences.getString('location');
    String? ade=sharedPreferences.getString('address');
    setState(() {
      _location=loco!;
      _adress=ade!;
    });
  }


  @override
  Widget build(BuildContext context) {



    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          //leading: IconButton(icon:const Icon(Icons.menu), onPressed: () {  },),
          //leading: Image.asset("assets/images/logo.png",color: Colors.white,),
          title: const Text('Profile',style: TextStyle(color: Colors.white),),
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
        body:ListView(
          shrinkWrap: true,
          padding:const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
          children:  [

            Container(
              color: Colors.white,
              child:const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('My Account',style:TextStyle(fontWeight:FontWeight.bold)),
              ),

            ),

            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey)
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children:  [
                            const CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.lightBlue,
                              child: Text('J',style:TextStyle(fontSize:50,color: Colors.white),),

                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Container(
                                height: 70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Text('$name',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:Colors.white),),

                                    Text('$email',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,color:Colors.white),),

                                    Text('$num',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,color:Colors.white),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),

                      ],
                    ),
                  ),
                ),

                Positioned(
                    right: 10.0,
                    top: 10.0,
                    child:IconButton(onPressed:()
                    {

                      //Navigator.pushReplacementNamed(context, ProfileUpdateScreen.id);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  EditAccount(),
                          )
                      );


                    },
                        icon:const Icon(Icons.edit,color: Colors.white,))
                )
              ],
            ),





            const Divider(),

            const ListTile(leading: Icon(Icons.comment_bank_outlined),
              horizontalTitleGap: 2,
              title: Text('My Ratings & Reviews'),),


            const Divider(),

            const ListTile(leading: Icon(Icons.notifications),
              horizontalTitleGap: 2,
              title: Text('Notifications'),),

            const Divider(),

            ListTile(leading: const Icon(Icons.pages_outlined),
              horizontalTitleGap: 2,
              title: InkWell(
                  onTap: ()
                  {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) =>  const AboutUS() ,
                    //     )
                    // );
                  },
                  child: const Text('About Us')),
            ),

            const Divider(),
            ListTile(leading: const Icon(Icons.power_settings_new),
              horizontalTitleGap: 2,
              onTap: (){
                //signOut();

              },
              title: const Text('Log Out'),),


          ],
        )

      ),
    );
  }
}

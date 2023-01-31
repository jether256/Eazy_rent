import 'dart:async';

import 'package:flutter/material.dart';
import 'package:eazy_rent/notlogged/housedetailsnot.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:eazy_rent/crypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../logged-signup/login.dart';
import '../../../notlogged/dashbo.dart';
import '../../../providers/chartdetail.dart';
import '../../../shared/pref.dart';
class PlacesDetailsNot extends StatefulWidget {
  const PlacesDetailsNot({Key? key}) : super(key: key);

  @override
  State<PlacesDetailsNot> createState() => _PlacesDetailsNotState();
}

class _PlacesDetailsNotState extends State<PlacesDetailsNot> {






  final StreamController<List> _streamController2 = StreamController<List>();
  Timer? _timer;




  @override
  void initState() {
    getPref();

    getHouses();


    //Check the server every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) => getHouses());
    super.initState();
  }


  @override
  void dispose() {
    //cancel the timer
    if (_timer!.isActive) _timer!.cancel();

    super.dispose();
  }


  late Box box;
  List data=[];

  Future openBox() async{
    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box=await Hive.openBox('placesdetailsnot');
    return;
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

  Future   getHouses()async {

    await openBox();


    try{

      var response = await http.get(
          Uri.parse("https://www.eazyrent256.com/api/user/places/places.php"),
          headers: {"Accept": "headers/json"});

      if (response.statusCode == 200) {

        List data = json.decode(response.body);
        //Add your data to stream
        _streamController2.add(data);

        await putData(data);

      }

    }catch(SocketException){

      print('No Internet');

    }

    //get data from DB
    var myMap=box.toMap().values.toList();
    if(myMap.isEmpty){

      data.add('empty');

    }else{

      data=myMap;
    }

    return Future.value(true);
  }


  Future putData(data) async{
    await box.clear();
    //insert data

    for(var d in data){
      box.add(d);
    }
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
    return Scaffold(
      appBar:AppBar(
        //leading: IconButton(icon:const Icon(Icons.menu), onPressed: () {  },),
        //leading: Image.asset("assets/images/logo.png",color: Colors.white,),
        title:  Text('Places',style: const TextStyle(color: Colors.white),),
        actions: [
          IconButton(icon:const Icon(Icons.login), onPressed: () {

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                )
            );

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
      ),
      body:SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white10,
            child:Padding(
              padding:  const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: StreamBuilder<List>(
                stream: _streamController2.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {

                  if (snapshot.hasData) {

                    if(snapshot.data.length == 0) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Center(child: Text('There no places')),
                          ],
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Container(
                        //     height: 56,
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Text('Fresh Recommendations',style: TextStyle(fontWeight: FontWeight.bold),),
                        //     )),


                      GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2/3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10,
                      ),
                      children: [
                        for (Map document in snapshot.data)

                          Pro(
                            id: document['ID'],
                            userID: document['user_id'],
                            own: document['owner'],
                            fon: document['phone'],
                            biz: document['bizname'],
                            bizphon:document['num'],
                            mail: document['mail'],
                            im1:'https://www.eazyrent256.com/api/owner/mage1/${document['image1']}',
                            im2: 'https://www.eazyrent256.com/api/owner/mage2/${document['image2']}',
                            im3:'https://www.eazyrent256.com/api/owner/mage3/${document['image3']}',
                            im4: 'https://www.eazyrent256.com/api/owner/mage4/${document['image4']}',
                            im5:'https://www.eazyrent256.com/api/owner/mage5/${document['image5']}',
                            tit: document['title'],
                            pr: document['price'],
                            desc:document['descc'],
                            adu: document['adu'],
                            lat: document['lat'],
                            lon: document['lon'],
                            place:document['place'],
                            bed:document['bed'],
                            bath:document['bath'],
                            fun: document['fun'],
                            con: document['con'],
                            sq: document['bsqft'],
                            cs: document['csqft'],
                            flo: document['floors'],
                            kit: document['kitchen'],
                            paid: document['paid'],
                            start: document['start'],
                            end:document['end'],
                            blocked:document['blocked'],
                            type:document['type'],
                            proid:document['pro_id'],
                          ),
                      ],
                    ),
                      ],
                    );

                  }else{
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 140,right:140 ),
                            child: Container(
                              // color: Colors.grey[300],
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.blue,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }





                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Pro extends StatefulWidget {

  final String id;
  final String userID;
  final String own;
  final String fon;
  final String biz;
  final String bizphon;
  final String mail;
  final String im1;
  final String im2;
  final String im3;
  final String im4;
  final String im5;
  final String tit;
  final String pr;
  final String desc;
  final String adu;
  final String lat;
  final String lon;
  final String place;
  final String bed;
  final String bath;
  final String fun;
  final String con;
  final String sq;
  final String cs;
  final String flo;
  final String kit;
  final String paid;
  final String start;
  final String end;
  final String blocked;
  final String type;
  final String proid;

  Pro({ required this.id, required this.userID, required this.own, required this.fon, required this.biz, required this.bizphon, required this.mail, required this.im1, required this.im2, required this.im3, required this.im4, required this.im5, required this.tit, required this.pr, required this.desc, required this.adu, required this.lat, required this.lon, required this.place, required this.bed, required this.bath, required this.fun, required this.con, required this.sq, required this.cs, required this.flo, required this.kit, required this.paid, required this.start, required this.end, required this.blocked, required this.type, required this.proid});

  @override
  State<Pro> createState() => _ProState();
}

class _ProState extends State<Pro> {
  @override
  Widget build(BuildContext context) {

    final _roomDetails=Provider.of<ChatDetailsProvider>(context);

    final _formated= NumberFormat();


    var _price=int.parse(widget.pr);
    String price=_formated.format(_price);

    return InkWell(
      onTap: ()
      {

        // _roomDetails.getselectedChart(widget.id,widget.userID,widget.own,widget.fon,widget.biz,widget.bizphon,
        //     widget.mail,widget.im1,widget.im2,widget.im3,widget.im4,widget.im5,widget.tit,widget.pr,widget.desc,
        //     widget.adu,widget.lat,widget.lon,widget.place,widget.bed,widget.bath,widget.fun,widget.con,widget.sq,widget.cs,
        //     widget.flo,widget.kit,widget.paid, widget.start,widget.end,widget.blocked,widget.type,widget.proid);


        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  HouseDetailsNot(id:widget.id,userID:widget.userID,own:widget.own,
                  fon:widget.fon,biz:widget.biz,bizphon:widget.bizphon,mail:widget.mail,
                  im1:widget.im1,im2:widget.im2,im3:widget.im3,im4:widget.im4,im5:widget.im5,
                  tit:widget.tit,pr:widget.pr,desc:widget.desc,adu:widget.adu,lat:widget.lat,lon:widget.lon,
                  place:widget.place,bed:widget.bed,bath:widget.bath,fun:widget.fun,con:widget.con,sq:widget.sq,cs:widget.cs,
                  flo:widget.flo,kit:widget.kit,paid:widget.paid,start:widget.start,end:widget.end,blocked:widget.blocked,
                  type:widget.type,proid:widget.proid,
                )));

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>  HouseDetailsNot()));


      }
      ,
      child:Container(
        alignment: Alignment.bottomLeft,
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),

          image: DecorationImage(
            image:NetworkImage(widget.im1),
            fit: BoxFit.cover,

          ),
        ),
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,

            children: [

              Positioned(
                bottom:0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  width:MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget.tit,maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      Text('\Shs $price',maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,color: Colors.black),),
                      //Text(forma,maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(fontSize: 14,color: Colors.grey),),

                    ],
                  ),
                ),
              ),

              Positioned(
                  top: 0.0,
                  left: 0.0,
                  child:Container(
                    decoration: BoxDecoration(
                      color:Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(widget.type),
                  )
              ),

            ],
          ),
        ) ,
      ),
    );
  }
}
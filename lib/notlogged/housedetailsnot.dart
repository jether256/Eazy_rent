import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eazy_rent/logged-signup/login.dart';
import 'package:eazy_rent/screens/report.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'package:url_launcher/url_launcher.dart';

import '../screens/ownerdetails/deatilsnot/ownernot.dart';


class HouseDetailsNot extends StatefulWidget {
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

  HouseDetailsNot({ required this.id, required this.userID, required this.own, required this.fon, required this.biz, required this.bizphon, required this.mail, required this.im1, required this.im2, required this.im3, required this.im4, required this.im5, required this.tit, required this.pr, required this.desc, required this.adu, required this.lat, required this.lon, required this.place, required this.bed, required this.bath, required this.fun, required this.con, required this.sq, required this.cs, required this.flo, required this.kit, required this.paid, required this.start, required this.end, required this.blocked, required this.type, required this.proid});



  @override
  State<HouseDetailsNot> createState() => _HouseDetailsNotState();
}

class _HouseDetailsNotState extends State<HouseDetailsNot> {


  final _formated= NumberFormat();

  bool _loading=true;

  int _index=0;


  @override
  void initState() {

    //getPref();
    late List photos;

    Timer(const Duration(seconds: 2),(){

      setState(() {
        _loading=false;
      });

    });
    super.initState();
  }


  late List photos=[
    '${widget.im1}',
    '${widget.im2}',
    '${widget.im3}',
    '${widget.im4}',
    '${widget.im5}'
  ];



  _callSeller(String s){
    launch(s);
  }




  @override
  Widget build(BuildContext context) {


    var _price=int.parse(widget.pr);
    String price=_formated.format(_price);


    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          //leading: IconButton(icon:const Icon(Icons.menu), onPressed: () {  },),
          //leading: Image.asset("assets/images/logo.png",color: Colors.white,),
          title: Text(widget.tit,style: const TextStyle(color: Colors.white),),
          actions: [
            IconButton(icon:const Icon(Icons.login), onPressed: () {

              Navigator.pushReplacementNamed(context,LoginScreen.id);

            },),
            //IconButton(icon:const Icon(Icons.logout), onPressed: () {  },),
            IconButton(icon:const Icon(Icons.notifications), onPressed: () {


              Navigator.pushReplacementNamed(context,LoginScreen.id);

            },),
          ],
          elevation: 2,
          centerTitle: true,
          backgroundColor:Colors.lightBlue,
          // shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
          // ),
          //flexibleSpace: Image.asset('assets/images/logo.png',fit: BoxFit.cover,),
        ),
        body:ListView(
          padding: const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 70),
          children: [

            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                // borderRadius: BorderRadius.circular(2),
              ),
              child: _loading ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    ),
                    const SizedBox(height:10,),

                    const Text('Loading Houses..'),

                  ],
                ),
              ):ListView(
                scrollDirection: Axis.horizontal,
                children:photos.map((e){
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CachedNetworkImage(imageUrl:photos[_index]),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10,),

            _loading ?  Container():
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(widget.tit.toUpperCase(),maxLines: 2,style: const TextStyle(fontWeight: FontWeight.bold,overflow:TextOverflow.ellipsis,),),
                  const SizedBox(height: 10,),
                  Text(widget.place.toUpperCase(),maxLines: 2,style: const TextStyle(fontWeight: FontWeight.bold,overflow:TextOverflow.ellipsis,),),

                  const SizedBox(height: 30,),
                  Text('\Shs $price',style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),

                  //desc
                  const SizedBox(height: 10,),

                  const Text('Description',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  const SizedBox(height: 10,),
                  const Divider(color: Colors.grey,thickness: 3,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            border: Border.all(color: Colors.lightBlue),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                // Text(widget.desc),

                                ExpandableText(
                                  widget.desc,
                                  expandText: 'View More',
                                  collapseText: 'View Less',
                                  maxLines: 2,
                                  style: const TextStyle(color:Colors.black),
                                ),
                                const SizedBox(height: 10,),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('BedRooms: ${widget.bed}'),
                                    const SizedBox(height: 4,),
                                    Text('BathRooms: ${widget.bath}'),
                                    const SizedBox(height: 4,),
                                    Text('Furnishing: ${widget.fun}'),
                                    const SizedBox(height: 4,),
                                    Text('Construction status: ${widget.con}'),
                                    const SizedBox(height: 4,),
                                    Text('Total Floors: ${widget.flo}'),
                                    const SizedBox(height: 4,),
                                    Text('Kitchen: ${widget.kit}'),
                                    const SizedBox(height: 4,),
                                    Text('Building Sqft: ${widget.sq}'),
                                    const SizedBox(height: 4,),
                                    Text('Floor Sqft: ${widget.cs}'),
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Text('Posted at: ${widget.start}'),


                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Divider(color: Colors.grey,),

                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 40,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue.shade300,
                          radius: 38,
                          child: Icon(CupertinoIcons.person_alt,
                            size: 60,
                            color: Colors.red.shade300,),
                        ),

                      ),
                      const SizedBox(height: 10,),

                      Expanded(
                        child: ListTile(
                          title: Text(widget.own,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          subtitle: const Text('See Profile',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                          trailing: IconButton(icon:const Icon(Icons.arrow_forward_ios,size: 12,), onPressed: () {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  OwnerDetailsNot(id:widget.id,userID:widget.userID,own:widget.own,
                                      fon:widget.fon,biz:widget.biz,bizphon:widget.bizphon,mail:widget.mail,
                                      im1:widget.im1,im2:widget.im2,im3:widget.im3,im4:widget.im4,im5:widget.im5,
                                      tit:widget.tit,pr:widget.pr,desc:widget.desc,adu:widget.adu,lat:widget.lat,lon:widget.lon,
                                      place:widget.place,bed:widget.bed,bath:widget.bath,fun:widget.fun,con:widget.con,sq:widget.sq,cs:widget.cs,
                                      flo:widget.flo,kit:widget.kit,paid:widget.paid,start:widget.start,end:widget.end,blocked:widget.blocked,
                                      type:widget.type,proid:widget.proid,
                                    )));




                          },),
                        ),
                      )
                    ],

                  ),

                  const SizedBox(height: 8,),
                  const Text('Location',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  const SizedBox(height: 10,),



                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(child: Text('HOUSE ID:  ${widget.proid}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),

                      TextButton(
                        onPressed: () {

                          showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              // isScrollControlled: true,
                              builder:(context)=>Container(
                                height: 220,
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    const Text('Please Login First!',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700,fontSize: 20),),
                                    const Text('Click the button below to login',maxLines: 2,style: TextStyle(color: Colors.blue),),

                                    const SizedBox(height: 20,),

                                    GestureDetector(
                                      onTap: (){


                                        Navigator.pushReplacementNamed(context,LoginScreen.id);

                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: Colors.grey.shade200,
                                        ),
                                        padding: const EdgeInsets.all(30),
                                        child: Row(
                                          children:  [

                                            const Icon(Icons.person,size:30.0 ,color: Colors.grey,),

                                            const SizedBox(width: 18,),

                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: const [
                                                Center(child: Text('Login',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),)),
                                                //Flexible(child: Text('Reset via Email verification',style: TextStyle(color: Colors.blue),)),
                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              )
                          );


                        },
                        child: const Text('REPORT ',style: TextStyle(color: Colors.blue),
                        ),),
                    ],
                  ),
                ],

              ),
            )

          ],
        ),
        bottomSheet:Row(
          children: [
            Expanded(
                child:Container(
                  child: Row(
                    children: [

                      Expanded(

                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                          child: InkWell(
                            onTap: (){

                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                  // isScrollControlled: true,
                                  builder:(context)=>Container(
                                    height: 220,
                                    padding: const EdgeInsets.all(30),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        const Text('Please Login First!',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700,fontSize: 20),),
                                        const Text('Click the button below to login',maxLines: 2,style: TextStyle(color: Colors.blue),),

                                        const SizedBox(height: 20,),

                                        GestureDetector(
                                          onTap: (){

                                            Navigator.pushReplacementNamed(context,LoginScreen.id);

                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.grey.shade200,
                                            ),
                                            padding: const EdgeInsets.all(30),
                                            child: Row(
                                              children:  [

                                                const Icon(Icons.person,size:30.0 ,color: Colors.grey,),

                                                const SizedBox(width: 18,),

                                                Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: const [
                                                    Center(child: Text('Login',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),)),
                                                    //Flexible(child: Text('Reset via Email verification',style: TextStyle(color: Colors.blue),)),
                                                  ],
                                                )

                                              ],
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  )
                              );


                            },
                            child: Container(
                              height:56 ,
                              decoration: BoxDecoration(
                                color:Colors.lightBlue,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children:[
                                    Image.asset('assets/images/whatsapp.png',height: 40,),
                                  ],
                                ),
                              ),
                              ),
                            ),
                          ),
                        ),
                      ),


                      Expanded(
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                          child: InkWell(
                            onTap: (){




                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                  // isScrollControlled: true,
                                  builder:(context)=>Container(
                                    height: 220,
                                    padding: const EdgeInsets.all(30),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        const Text('Please Login First!',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700,fontSize: 20),),
                                        const Text('Click the button below to login',maxLines: 2,style: TextStyle(color: Colors.blue),),

                                        const SizedBox(height: 20,),

                                        GestureDetector(
                                          onTap: (){


                                            Navigator.pushReplacementNamed(context,LoginScreen.id);
                                           // Navigator.pushReplacementNamed(context, LoginScreen.id);

                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.grey.shade200,
                                            ),
                                            padding: const EdgeInsets.all(30),
                                            child: Row(
                                              children:  [

                                                const Icon(Icons.person,size:30.0 ,color: Colors.grey,),

                                                const SizedBox(width: 18,),

                                                Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: const [
                                                    Center(child: Text('Login',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),)),
                                                    //Flexible(child: Text('Reset via Email verification',style: TextStyle(color: Colors.blue),)),
                                                  ],
                                                )

                                              ],
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  )
                              );


                            },
                            child: Container(
                              height:56 ,
                              decoration: BoxDecoration(
                                color:Colors.black54,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(CupertinoIcons.phone,color: Colors.white,),
                                    Text('Call',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

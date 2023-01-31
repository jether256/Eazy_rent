import 'dart:async';

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../providers/chartdetail.dart';
import '../housedetails.dart';

class Deal extends StatefulWidget {
  const Deal({Key? key}) : super(key: key);

  @override
  State<Deal> createState() => _DealState();
}

class _DealState extends State<Deal> {


  final StreamController<List> _streamController2 = StreamController<List>();
  Timer? _timer;

  @override
  void initState() {
    // getPref();
    getData();

    //Check the server every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) => getData());

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
    box=await Hive.openBox('deal');
    return;
  }


  Future    getData()async {

    await openBox();


    try{

      var response = await http.get(
          Uri.parse("https://www.eazyrent256.com//api/user/deals/all.php"),
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





  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
        stream: _streamController2.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if (snapshot.hasData) {

            return  ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
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
            );



          }else{

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius:BorderRadius.circular(4),
                child: Container(
                  width:MediaQuery.of(context).size.width,
                  height: 150,
                  color: Colors.grey[200],
                  child:Container(
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
            );

          }

        }
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

    return InkWell(
      onTap: ()
      {

        //
        // _roomDetails.getselectedChart(widget.id,widget.userID,widget.own,widget.fon,widget.biz,widget.bizphon,
        //     widget.mail,widget.im1,widget.im2,widget.im3,widget.im4,widget.im5,widget.tit,widget.pr,widget.desc,
        //     widget.adu,widget.lat,widget.lon,widget.place,widget.bed,widget.bath,widget.fun,widget.con,widget.sq,widget.cs,
        //     widget.flo,widget.kit,widget.paid, widget.start,widget.end,widget.blocked,widget.type,widget.proid);


        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  HouseDetails(id:widget.id,userID:widget.userID,own:widget.own,
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
        //         builder: (context) =>  HouseDetails()));



      }
      ,
      child:Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0,right: 2.0,top: 5.0,bottom: 2.0),
              child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                  ),
                  child:CachedNetworkImage(imageUrl:widget.im1,fit: BoxFit.cover,)
              ),
            ),

            Text(widget.tit,maxLines: 2,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold
              ,overflow:TextOverflow.ellipsis,),),
          ],
        ),
      ),
    );
  }
}
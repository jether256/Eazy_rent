import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../providers/sliderpro.dart';
import 'bannnotde.dart';





class SliderNot extends StatefulWidget {
  const SliderNot({Key? key}) : super(key: key);

  @override
  State<SliderNot> createState() => _SliderNotState();
}

class _SliderNotState extends State<SliderNot> {


  final StreamController<List> _streamController2 = StreamController<List>();
  Timer? _timer;


  int _index= 0;
  int _dataLenghth=1;

  @override
  void initState() {

    getSlider();


    //Check the server every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) => getSlider());
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
    box=await Hive.openBox('slidernot');
    return;
  }



  Future   getSlider()async {

    await openBox();


    try{

      var response = await http.get(
        Uri.parse("https://www.eazyrent256.com//api/user/banner/getBana.php"),
        headers: {"Accept": "headers/json"},);

      if (response.statusCode == 200) {

        List data = json.decode(response.body);
        //Add your data to stream
        _streamController2.add(data);
        _dataLenghth=data.length;
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





  // @override
  // void initState(){
  //   super.initState();
  //   getSlider();
  // }



  //List<SliderModel> slider = [];
  // late  List slider=[];
  //
  // getSlider() async{
  //   var response = await http.get(
  //       Uri.parse("https://mymusawoee.000webhostapp.com/api/user/bana.php"),
  //       headers: {"Accept": "headers/json"},);
  //
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     setState(() {
  //       final data = jsonDecode(response.body);
  //       // for (Map item in data) {
  //       //   slider.add(SliderModel.fromJson(item));
  //       //
  //       // }
  //       slider = data;
  //
  //
  //       _dataLenghth=data.length;
  //     });
  //     print(data);
  //     return data;
  //   }
  //
  // }


  // List<BanaModel> slider = [];
  // Future getSlider() async {
  //   var response = await http.get(
  //     Uri.parse("https://eazyrent.000webhostapp.com/api/user/banner/getBana.php"),
  //     headers: {"Accept": "headers/json"},);
  //   if (response.statusCode == 200) {
  //     // var jsonData = json.decode(response.body);
  //     setState(() {
  //       final data = jsonDecode(response.body);
  //       for (Map item in data) {
  //         slider.add(BanaModel.fromJson(item));
  //       }
  //     });
  //
  //     // setState(() {
  //     //   adu = jsonData;
  //     // });
  //     // print(jsonData);
  //     // return jsonData;
  //   }
  // }






  @override
  Widget build(BuildContext context) {





    return Column(
      children: [
        StreamBuilder<List>(
            stream: _streamController2.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.hasData) {

                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselSlider.builder(
                    itemCount:snapshot.data.length,
                    options:CarouselOptions(
                        initialPage: 0,
                        autoPlay: true,height: 150,
                        onPageChanged:(int i, carouselPageChangedReason){

                          setState(() {
                            _index=i;
                          });

                        }
                    ), itemBuilder: (BuildContext context, int index, int realIndex) {

                    // final x = slider[index];

                    return  InkWell(
                      onTap: (){

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BannerDetailsNot(
                                id:snapshot.data[index]['id'],User_id:snapshot.data[index]['user_id'],biz:snapshot.data[index]['bizname'],
                                tit:snapshot.data[index]['title'],image:snapshot.data[index]['image'],
                                start:snapshot.data[index]['start'],end:snapshot.data[index]['end'],paid:snapshot.data[index]['paid'],
                              ),
                            )
                        );


                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),

                              color: Colors.white10
                            ),
                            child: CachedNetworkImage(imageUrl:'https://www.eazyrent256.com//api/owner/businesses/bana/${snapshot.data[index]['image']}',fit: BoxFit.fill,)),
                      ),
                    );


                  },),
                );



              }else{

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius:BorderRadius.circular(4),
                    child: Container(
                      width:MediaQuery.of(context).size.width,
                      height: 150,
                        color: Colors.grey[100],
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
        ),

        DotsIndicator(
          dotsCount:_dataLenghth,
          position: _index.toDouble(),
          decorator: DotsDecorator(
            size: const Size.square(5.0),
            activeSize: const Size(18.0, 5.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            activeColor:Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../models/bannermodel.dart';
import '../../providers/sliderpro.dart';
import 'bannsdet.dart';





class SliderLogged extends StatefulWidget {
  const SliderLogged({Key? key}) : super(key: key);

  @override
  State<SliderLogged> createState() => _SliderLoggedState();
}

class _SliderLoggedState extends State<SliderLogged> {






  @override
  void initState(){
    super.initState();
    getSlider();
  }

  int _index= 0;
  int _dataLenghth=1;

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


 // List<SliderModel> slider = [];
  late  List slider=[];

  getSlider() async{
    var response = await http.get(
      Uri.parse("https://www.eazyrent256.com//api/user/banner/getBana.php"),
      headers: {"Accept": "headers/json"},);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        final data = jsonDecode(response.body);
        // for (Map item in data) {
        //   slider.add(SliderModel.fromJson(item));
        //
        // }
        slider = data;


        _dataLenghth=data.length;
      });
      print(data);
      return data;
    }

  }





  @override
  Widget build(BuildContext context) {

    final _sliderProvider=Provider.of<SliderProvider>(context);



    return Column(
      children: [
        FutureBuilder(
            future:getSlider(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){

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

                        //
                        // _sliderProvider.getselectedSlider(slider[index].id,slider[index].user_id,slider[index].bizname,slider[index].tit,slider[index].im,slider[index].start,slider[index].end,
                        //     slider[index].paid
                        // );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BannerDetails(
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
                            child: CachedNetworkImage(imageUrl:'https://www.eazyrent256.com//api/owner/businesses/bana/${slider[index]['image']}',fit: BoxFit.fill,)),
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

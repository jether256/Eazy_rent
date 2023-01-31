
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';


import 'detailcatnot.dart';

class CategoryNot extends StatefulWidget {
  const CategoryNot({Key? key}) : super(key: key);

  @override
  State<CategoryNot> createState() => _CategoryNotState();
}

class _CategoryNotState extends State<CategoryNot> {



  final StreamController<List> _streamController2 = StreamController<List>();
  Timer? _timer;


  Future getData() async {
    var response = await http.get(
        Uri.parse("https://www.eazyrent256.com/api/user/category.php"),
        headers: {"Accept": "headers/json"});
    if (response.statusCode == 200) {

      List data = json.decode(response.body);
      //Add your data to stream
      _streamController2.add(data);

    }
  }


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



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
        stream: _streamController2.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {



          if (snapshot.hasData) {

            return  GridView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              childAspectRatio: 2/3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 6,
              ),
              children: [
                for (Map document in snapshot.data)

            InkWell(
              onTap: (){

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeatilCartNot(
                        ID:document['id'],NAME:document['name'],PIC:document['pic'],
                      ),
                    )
                );
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4)
                        ),
                        width: 80,
                        height: 80,
                        child:CachedNetworkImage(imageUrl:'https://www.eazyrent256.com//api/owner/category/${document['pic']}',fit: BoxFit.fill,)
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Text(document['name'],maxLines: 2,style: const TextStyle(fontSize: 14,overflow:TextOverflow.ellipsis,),),
                  ),

                ],
              ),
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


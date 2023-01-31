import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BrandedHighlightsNot extends StatefulWidget {
  const BrandedHighlightsNot({Key? key}) : super(key: key);

  @override
  State<BrandedHighlightsNot> createState() => _BrandedHighlightsNotState();
}

class _BrandedHighlightsNotState extends State<BrandedHighlightsNot> {

 /// api/owner/brand/
  ///
  ///

  final StreamController<List> _streamController2 = StreamController<List>();
  Timer? _timer;


  @override
  void initState() {
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
    box=await Hive.openBox('brandednot');
    return;
  }


  Future   getHouses()async {

    await openBox();


    try{

      var response = await http.get(
          Uri.parse("https://eazyrent256.com/api/owner/brand.php"),
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
                    id: document['id'],
                    image: 'https://www.eazyrent256.com/api/owner/brand/${document['image']}',
                    image2: 'https://www.eazyrent256.com/api/owner/brand/${document['image2']}',
                    image3: 'https://www.eazyrent256.com/api/owner/brand/${document['image3']}',
                    url: document['url'],
                  ),
              ],
            );



          }else{

            return Container(
              height:170 ,
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
            );

          }

        }
    );
  }
}


class Pro extends StatefulWidget {

  final String id;
  final String image;
  final String image2;
  final String image3;
  final String url;

  Pro(
      { required this.id, required this.image, required this.image2, required this.image3, required this.url});

  @override
  State<Pro> createState() => _ProState();
}

class _ProState extends State<Pro> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Branded Highlights',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 1),)
            ),
          ),

          Container(
            height: 170,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: [

                Row(
                  children: [
                    Expanded(
                        flex:5,
                        child:Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,0,4,8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Container(
                                  color: Colors.deepOrangeAccent,
                                  height: 100,
                                  child: Center(
                                      child:CachedNetworkImage(
                                        fit: BoxFit.cover,
                                          imageUrl:widget.image,
                                        placeholder: (context,url)=>GFShimmer(
                                            child:Container(
                                              child: Container(
                                                color: Colors.grey.shade500,
                                                height:50,
                                              ),
                                            )
                                        ),
                                      ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex:1,
                                  child:Padding(
                                    padding: const EdgeInsets.fromLTRB(8,0,4,8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Container(
                                        color: Colors.green,
                                        height: 50,
                                        child: Center(
                                          child:CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:widget.image2,
                                            placeholder: (context,url)=>GFShimmer(
                                                child:Container(
                                                  child: Container(
                                                    color: Colors.grey.shade500,
                                                    height:50,
                                                  ),
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex:1,
                                  child:Padding(
                                    padding: const EdgeInsets.fromLTRB(4,0,8,8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Container(
                                        color: Colors.purple,
                                        height: 50,
                                        child: Center(
                                          child:CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:widget.image3,
                                            placeholder: (context,url)=>GFShimmer(
                                                child:Container(
                                                  child: Container(
                                                    color: Colors.grey.shade500,
                                                    height:50,
                                                  ),
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                    Expanded(
                      flex: 2,
                      child:Padding(
                        padding: const EdgeInsets.fromLTRB(4,0,8,8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: 170,
                            color: Colors.deepOrangeAccent,
                            child:Center(
                              child: Text('Ad',textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}

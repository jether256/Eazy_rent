import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../models/catpro.dart';
import '../../providers/cat.dart';

class CatProNot extends StatefulWidget {
  const CatProNot({Key? key}) : super(key: key);

  @override
  State<CatProNot> createState() => _CatProNotState();
}

class _CatProNotState extends State<CatProNot> {

  //https://eazyrent256.com/api/user/cathouse.php

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
    box=await Hive.openBox('catpronot');
    return;
  }


  String? selectedCat;


 List jay=[];
  Future  getData()async {

    await openBox();


    try{

      var response = await http.get(
          Uri.parse("https://eazyrent256.com/api/user/cathouse.php"),
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

    final _cat = Provider.of<CategoryProvider>(context);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Center(
            child: selectedCat == null ? Text('Categories',style: TextStyle(color: Colors.white)):Text(selectedCat!,style: TextStyle(color: Colors.white)),
            )),
      body:Row(
        children: [
          Container(
            color: Colors.grey.shade400,
            width: 80,
            child:StreamBuilder<List>(
                stream: _streamController2.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {

                  if (snapshot.hasData) {

                    return  ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: [
                        for (Map document in snapshot.data)

                          InkWell(
                            onTap: (){



                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => CatProDetails(
                              //         // ID:document['id'],NAME:document['name'],PIC:document['pic'],
                              //       ),
                              //     )
                              // );

                              setState(() {
                                //_cat.getCat(document['id'],document['name'],document['pic']);
                                selectedCat=document['name'];
                              });
                            },
                            child: Container(
                              color:selectedCat == document['name'] ? Colors.white38: Colors.grey.shade500,
                              height: 97,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:50,
                                          width: 70,
                                          child: CachedNetworkImage(imageUrl:'https://www.eazyrent256.com//api/owner/category/${document['pic']}',fit: BoxFit.cover,)
                                ),
                                      Text(document['name'],style: TextStyle(fontSize: 13,
                                        color:selectedCat == document['name'] ? Colors.black: Colors.white,
                                      ),),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );



                  }else{

                    return ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: [
                      Container(
                      height: 70,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.grey,
                                height:30,
                              ),
                              Text('',style: TextStyle(fontSize: 10,color: Colors.grey),)
                            ],
                          ),
                        ),
                      ),
                    ),
                        Container(
                          height: 70,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    height:30,
                                  ),
                                  Text('',style: TextStyle(fontSize: 10,color: Colors.grey),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    height:30,
                                  ),
                                  Text('',style: TextStyle(fontSize: 10,color: Colors.grey),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    height:30,
                                  ),
                                  Text('',style: TextStyle(fontSize: 10,color: Colors.grey),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    height:30,
                                  ),
                                  Text('',style: TextStyle(fontSize: 10,color: Colors.grey),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    height:30,
                                  ),
                                  Text('',style: TextStyle(fontSize: 10,color: Colors.grey),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    height:30,
                                  ),
                                  Text('',style: TextStyle(fontSize: 10,color: Colors.grey),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    height:30,
                                  ),
                                  Text('',style: TextStyle(fontSize: 10,color: Colors.grey),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    height:30,
                                  ),
                                  Text('',style: TextStyle(fontSize: 10,color: Colors.grey),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    height:30,
                                  ),
                                  Text('',style: TextStyle(fontSize: 10,color: Colors.grey),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    height:30,
                                  ),
                                  Text('',style: TextStyle(fontSize: 10,color: Colors.grey),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    height:30,
                                  ),
                                  Text('',style: TextStyle(fontSize: 10,color: Colors.grey),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.grey,
                                    height:30,
                                  ),
                                  Text('',style: TextStyle(fontSize: 10,color: Colors.grey),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );

                  }

                }
            ),
          ),

         Expanded(
           child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
            Container(
              height: 70,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey,
                        height:30,
                      ),
                      Text(_cat.name,style: TextStyle(fontSize: 10,color: Colors.grey),)
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
         ),
        ],
      ) ,
    );
  }
}



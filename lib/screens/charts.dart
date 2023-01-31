  import 'dart:async';
  import 'dart:convert';
  import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
  import '../../../crypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../notlogged/dashbo.dart';
import '../providers/chart.dart';
import '../providers/chartdetail.dart';
import '../shared/pref.dart';

  class ChatDetails extends StatefulWidget {

    final  String chatID;


    ChatDetails({required this.chatID});




    @override
    State<ChatDetails> createState() => _ChatDetailsState();
  }

  class _ChatDetailsState extends State<ChatDetails> {

    TextEditingController meso=TextEditingController();

    final StreamController<List> _streamController = StreamController<List>();
    Timer? _timer;

   // final CustomPopupMenuController _controller = CustomPopupMenuController();

    bool _send = false;
    final _format = NumberFormat('##,###,###,##0');


    // void didChangeDependencies() {
    //   final _advertsProvider = Provider.of<AdvertsProvider>(context);
    //   showMessages(_advertsProvider);
    //
    //   super.didChangeDependencies();
    // }


    @override
    void initState() {
      getPref();
      //showMessages();
      getData();

      //Check the server every 5 seconds
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) => getData());

      super.initState();
    }

    @override
    void dispose() {
      //cancel the timer
      if (_timer!.isActive) _timer!.cancel();

      super.dispose();
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


    String timeee = DateTime.now().microsecondsSinceEpoch.toString();


    Future getData() async {

      //String chatroomId='${widget.userID}.${userID}.${widget.proid}';
      var response = await http.post(
          Uri.parse('https://www.eazyrent256.com/api/user/mess/getMess.php'),
          body: {
            "chatRoomId":encryp(widget.chatID),
          });

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        //Add your data to stream
        _streamController.add(data);

      }
    }




    @override
    Widget build(BuildContext context) {

      final _roomDetails=Provider.of<ChatDetailsProvider>(context);

      final _roomProvider=Provider.of<ChartRoomProvider>(context);


      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue,
          title: Text(_roomDetails.title,style: const TextStyle(color: Colors.white),),

        ),
        body: Column(
          children: [
            Expanded(
              child:StreamBuilder<List>(
                stream: _streamController.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {

                    if(snapshot.data==0){

                      return  Center(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('No Messages',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                        ],
                      ));
                    }


                    return ListView(

                      shrinkWrap: true,
                      children: [
                        for (Map document in snapshot.data)

                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 20,),



                              Text(document['mess']),

                            ],
                          ),
                      ],
                    );






                  }
                  return Text('Loading.....');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:50,vertical: 20 ),
              child: Row(
                children: [
                  Expanded(child: TextFormField(
                    controller: meso,
                    decoration: const InputDecoration(
                        hintText:"Type here....",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                            )
                        )
                    ),
                  )),
                  IconButton(onPressed:(){

                    String ma=meso.text;
                    if(ma.isNotEmpty){

                      sendMessage(_roomDetails);
                      meso.clear();
                    }


                  }, icon:const Icon(Icons.send,color: Colors.teal,)),

                ],
              ),
            ),
          ],
        ),
      );
    }

    sendMessage(ChatDetailsProvider roomDetails) async {

        EasyLoading.show(status: 'Sending');

       // String chatroomId='${widget.userID}.${userID}.${widget.proid}';

        var response = await http.post(
            Uri.parse('https://www.eazyrent256.com/api/user/mess/addMess.php'),
            body: {
              "chatRoomId":encryp(widget.chatID),
              "chat":encryp(meso.text) ,
              "selname":encryp(roomDetails.owner) , //seller
              "usename":encryp('$name'), //seller
              "selID":encryp(roomDetails.user_id), //buyer
              "useid":encryp('$userID') , //buyer
              "product_id":encryp(roomDetails.proid) ,
              "image":encryp(roomDetails.image1) ,
              "time": DateTime.now().microsecondsSinceEpoch.toString(),
            });

        if (response.statusCode == 200) {

          EasyLoading.showSuccess('Message sent');
        } else {
          EasyLoading.showError('Message failed to send');
        }



    }
  }

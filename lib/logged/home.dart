import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../notlogged/dashbo.dart';
import '../providers/chartdetail.dart';
import '../screens/all/all.dart';
import '../screens/category/cart.dart';
import '../screens/deals/deal.dart';
import '../screens/deals/dealdetails.dart';
import '../screens/housedetails.dart';
import '../screens/places/placedetails.dart';
import '../screens/places/places.dart';
import '../screens/slider/sliderlogged.dart';
import '../shared/pref.dart';
import '../widgets/custnot.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  String _location='';
  String _adress='';


  @override
  void initState() {

    getPref();
    getLoc();
    showProducts();
    super.initState();
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

  late  List searchList=[];
  showProducts() async{

    var response = await http.get(Uri.parse("https://www.eazyrent256.com/api/user/getAllPro.php"),headers:{"Accept":"headers/json"});
    if(response.statusCode ==200){

      var jsonData=json.decode(response.body);

      for(var i=0;i<jsonData.length;i++){
         searchList.add(jsonData[i]['pro_id']);
        // searchList.add(jsonData[i]['type']);
         searchList.add(jsonData[i]['price']);
         searchList.add(jsonData[i]['place']);
        searchList.add(jsonData[i]['title']);
        searchList.add(jsonData[i]['descc']);
        // searchList.add(jsonData[i]['adu']);
         searchList.add(jsonData[i]['bizname']);
         searchList.add(jsonData[i]['owner']);
      }
      print(searchList);
      //return jsonData;

    }

  }


  @override
  Widget build(BuildContext context) {



    return SafeArea(
      child: Scaffold(

        body:NestedScrollView(
          physics: const BouncingScrollPhysics(),
            floatHeaderSlivers: true,
            headerSliverBuilder:
            (BuildContext context, bool innerBoxIsScrolled){

              return  <Widget>[

              SliverAppBar(
                //leading: IconButton(icon:const Icon(Icons.menu), onPressed: () {  },),
                leading: Image.asset("assets/images/loo.png",color: Colors.white,),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [StretchMode.zoomBackground],
                  background:Image.asset("assets/images/ty.jpg",fit: BoxFit.cover,),
                ),
                expandedHeight: 200.0,
                pinned: true,
                stretch: true,
                // title:MaterialButton(
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Text(_location ?? '',style: TextStyle(color: Colors.white),),
                //
                //       IconButton(icon:const Icon(Icons.edit_outlined,color: Colors.white,), onPressed: () {
                //
                //       },),
                //
                //
                //     ],
                //   ),
                //   onPressed: () {
                //
                //     EasyLoading.show(status: 'Please wait...');
                //     locationData.getCurrentPosition();
                //     if(locationData.permissionAllowed==true){
                //       EasyLoading.dismiss();
                //
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => Mapma(),
                //           )
                //       );
                //
                //     }else{
                //       EasyLoading.dismiss();
                //
                //       print('Permission not allowed');
                //     }
                //
                //
                //
                //
                //   },
                // ),
                actions: [
                  IconButton(icon:const Icon(Icons.account_circle_outlined), onPressed: () {


                    signOut();

                  },),
                  //IconButton(icon:const Icon(Icons.logout), onPressed: () {  },),

                ],
                elevation: 0,
                centerTitle: true,
                backgroundColor:Colors.lightBlue,
                bottom:  PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child:Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onTap: (){
                              showSearch(context: context, delegate:SearchAds(list:searchList));
                            },
                            decoration: InputDecoration(
                              hintText: 'Search Rentals,apartments,land,office space, bangalows,air bnb',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.zero,
                              filled: true,
                              fillColor: Colors.grey[300],
                            ),

                          ),
                        ),
                        IconButton(icon:const Icon(Icons.notifications,color: Colors.white,), onPressed: () {  },),
                      ],
                    ),
                  ) ,
                ),
                // shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                // ),
                //flexibleSpace: Image.asset('assets/images/logo.png',fit: BoxFit.cover,),
              ),

              ];
            },
          body: ListView(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
      children: [


          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8)
            ),
            child:const SliderLogged(),
          ),

          const SizedBox(height: 10,),

          //categories
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8)
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                  child: Row(
                    children: [
                      Image.asset('assets/images/face.gif',height: 30,),
                      const Text('Categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                    ],
                  ),
                ),
                const Category(),
              ],
            ),
          ),

          const SizedBox(height: 10,),

          //deal
          Container(
            height: 200,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8)
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(

                        children: [
                          Image.asset('assets/images/off.gif',height: 40,),
                          const SizedBox(width: 10,),
                          const Text('Deal of The Day',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                        ],
                      ),

                      InkWell(
                          onTap: (){

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DealDetails(
                                  ),
                                )
                            );




                          },
                          child: const Text('View more..',style: TextStyle(color: Colors.blue),)
                      ),

                    ],
                  ),
                ),
                const Flexible(child: Deal()),
              ],
            ),
          ),


          const SizedBox(height: 10,),

          //places
          Container(
            height: 200,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8)
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(

                        children: [
                          Image.asset('assets/images/ye.gif',height: 40,),
                          const SizedBox(width: 10,),
                          const Text('Popular Places',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                        ],
                      ),

                      InkWell(
                          onTap: (){

                            //PlacesDetails

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlacesDetails(
                                  ),
                                )
                            );

                          },
                          child: const Text('View more..',style: TextStyle(color: Colors.blue),)
                      ),

                    ],
                  ),
                ),
                const Flexible(child: Places()),
              ],
            ),
          ),
          //
        Container(
          height:MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8)
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  const [
              Padding(
                padding: EdgeInsets.only(left: 8.0,top: 8.0),
                child: Text('Houses near you',style: TextStyle(color: Colors.lightBlue,fontSize: 18,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0,right: 8.0,top: 5),
                child: Text('Find Best Quality Houses  near you',style: TextStyle(color: Colors.grey,fontSize: 12),),
              ),

              Flexible(child: AllHoses()),
            ],
          ),
        ),

      ],
    ),
        ),
      ),
    );
  }
}


class SearchAds extends SearchDelegate<String>{

  List<dynamic> list;
  SearchAds({required this.list});

  showAllProducts() async{

    var response = await http.post(
        Uri.parse('https://www.eazyrent256.com/api/user/search.php'),
        body: {
          "search":query,
        });
    if(response.statusCode ==200){
      var jsonData=json.decode(response.body);
      return jsonData;

    }

  }


  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(
        onPressed:(){
          query="";
          showSuggestions(context);

        },
        icon:const Icon(Icons.close),
      )

    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(onPressed:(){
      close(context,"");
    },icon:const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {


    final _roomDetails=Provider.of<ChatDetailsProvider>(context);

    return FutureBuilder<dynamic>(
        future: showAllProducts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                  var lists=snapshot.data[index];

                  final _format=NumberFormat('##,###,##0');
                  var _price=int.parse(lists['price']);//convert to int
                  String _formattedPrice='\Shs ${_format.format(_price)}';


                  //
                  // var date=DateTime.DateTime.fromMicrosecondsSinceEpoch(lists['date']);
                  // var _date=DateFormat.yMMM().format(date);


                  return InkWell(
                    onTap: (){

                      //
                      //
                      // _roomDetails.getselectedChart(lists['ID'],lists['user_id'],lists['owner'],lists['phone'],lists['bizname'],lists['num'],
                      //     lists['mail'],lists['image1'],lists['image2'],lists['image3'],lists['image4'],lists['image5'],lists['title'],lists['price'],lists['descc'],
                      //     lists['adu'],lists['lat'],lists['lon'],lists['place'],lists['bed'],lists['bath'],lists['fun'],lists['con'],lists['bsqft'],lists['csqft'],
                      //     lists['floors'],lists['kitchen'],lists['paid'], lists['start'],lists['end'],lists['blocked'],lists['type'],lists['pro_id']);
                      //

                      //
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  HouseDetails(id:lists['ID'],userID:lists['user_id'],own:lists['owner'],
                                fon:lists['phone'],biz:lists['bizname'],bizphon:lists['num'],mail:lists['mail'],
                                im1:lists['image1'],im2:lists['image2'],im3:lists['image3'],im4:lists['image4'],im5:lists['image5'],
                                tit:lists['title'],pr:lists['price'],desc:lists['descc'],adu:lists['adu'],lat:lists['lat'],lon:lists['lon'],
                                place:lists['place'],bed:lists['bed'],bath:lists['bath'],fun:lists['fun'],con:lists['con'],sq:lists['bsqft'],cs:lists['csqft'],
                                flo:lists['floors'],kit:lists['kitchen'],paid:lists['paid'],start:lists['start'],end:lists['end'],blocked:lists['blocked'],
                                type:lists['type'],proid:lists['pro_id'],
                              )));

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>  HouseDetails()));
                    },
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 120,
                                child:CachedNetworkImage(
                                  imageUrl:'https://www.eazyrent256.com/api/owner/mage1/${lists['image1']}',fit: BoxFit.cover,
                                  //placeholder: (context, url) =>,
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(_formattedPrice,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                      Text(lists['title']),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Posted At:${lists['start']}'),
                                    ],
                                  ),


                                ],
                              )
                            ],

                          ),
                        ),
                      ),

                    ),
                  );
                });
          }else{
            return Column(
              children: const [
                Center(child: CircularProgressIndicator()),
              ],
            );
          }

        });

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    var listData=query.isEmpty ? list:list.where((element) => element.toLowerCase().contains(query)).toList();

    return listData.isEmpty ? const Center(child: Text('No Data Found'),):ListView.builder(
        itemCount: listData.length,
        itemBuilder:(context,index){
          return  ListTile(
            onTap: (){
              query=listData[index];
              showResults(context);
            },
            title:Text(listData[index]),
          );
        }
    );
  }

}
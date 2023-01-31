
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {

    return Text('mahjsjs');
    // return AppBar(
    //   //leading: IconButton(icon:const Icon(Icons.menu), onPressed: () {  },),
    //   leading: Image.asset("assets/images/logo.png",color: Colors.white,),
    //   title:MaterialButton(
    //     child: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Text(_location ?? '',style: TextStyle(color: Colors.white),),
    //
    //         IconButton(icon:const Icon(Icons.edit_outlined,color: Colors.white,), onPressed: () {
    //
    //         },),
    //
    //
    //       ],
    //     ),
    //     onPressed: () {
    //
    //       EasyLoading.show(status: 'Please wait...');
    //       locationData.getCurrentPosition();
    //       if(locationData.permissionAllowed==true){
    //         EasyLoading.dismiss();
    //
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => Mapma(),
    //             )
    //         );
    //
    //       }else{
    //         EasyLoading.dismiss();
    //
    //         print('Permission not allowed');
    //       }
    //
    //
    //
    //
    //     },
    //   ),
    //   actions: [
    //     IconButton(icon:const Icon(Icons.account_circle_outlined), onPressed: () {
    //
    //
    //       //signOut();
    //
    //     },),
    //     //IconButton(icon:const Icon(Icons.logout), onPressed: () {  },),
    //
    //   ],
    //   elevation: 0,
    //   centerTitle: true,
    //   backgroundColor:Colors.lightBlue,
    //   bottom:  PreferredSize(
    //     preferredSize: const Size.fromHeight(56),
    //     child:Padding(
    //       padding: const EdgeInsets.all(10.0),
    //       child: Row(
    //         children: [
    //           Expanded(
    //             child: TextField(
    //               decoration: InputDecoration(
    //                 hintText: 'Search Rentals,apartments,land,office space, bangalows,air bnb',
    //                 prefixIcon: const Icon(Icons.search),
    //                 border: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(4),
    //                   borderSide: BorderSide.none,
    //                 ),
    //                 contentPadding: EdgeInsets.zero,
    //                 filled: true,
    //                 fillColor: Colors.grey[300],
    //               ),
    //
    //             ),
    //           ),
    //           IconButton(icon:const Icon(Icons.notifications,color: Colors.white,), onPressed: () {  },),
    //         ],
    //       ),
    //     ) ,
    //   ),
    //   // shape: const RoundedRectangleBorder(
    //   //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
    //   // ),
    //   //flexibleSpace: Image.asset('assets/images/logo.png',fit: BoxFit.cover,),
    // ),
  }
}

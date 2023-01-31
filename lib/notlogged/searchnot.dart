
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';

import '../logged-signup/login.dart';

class SearchNot extends StatefulWidget {
  const SearchNot({Key? key}) : super(key: key);

  @override
  State<SearchNot> createState() => _SearchNotState();
}

class _SearchNotState extends State<SearchNot> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
      //leading: IconButton(icon:const Icon(Icons.menu), onPressed: () {  },),
      //leading: Image.asset("assets/images/logo.png",color: Colors.white,),
      title: const Text('Contact Us',style: TextStyle(color: Colors.white),),
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
    ) ,
        body:Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Please Login First',style: TextStyle(color: Colors.grey,fontSize: 14),),

              const Divider(height: 10,),

              NeumorphicButton(
                onPressed: (){


                  Navigator.pushReplacementNamed(context,LoginScreen.id);

                },
                style: const NeumorphicStyle(color:Colors.lightBlue),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.login,size: 16,color: Colors.white,),
                      Text('Login',style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

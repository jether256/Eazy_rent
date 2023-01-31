
import 'package:eazy_rent/notlogged/accontnot.dart';
import 'package:eazy_rent/notlogged/profilenot.dart';
import 'package:eazy_rent/notlogged/searchnot.dart';
import 'package:flutter/material.dart';

import '../catpro/catpronot/cartpronot.dart';
import 'homenot.dart';



class DashNot extends StatefulWidget {

  static const  String id='nedaman';

  @override
  State<DashNot> createState() => _DashNotState();
}

class _DashNotState extends State<DashNot> {





  List pages=[

    Homenot(),
    //SearchNot(),
    CatProNot(),
    Profilenot(),
    NotificationNot(),
    // Homenot(),
    // Homenot(),
    // Homenot(),


  ];


  int currentIndex=0;

  void onTap(int index){

    setState(() {
      currentIndex=index;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:Colors.lightBlueAccent,
      body: pages[currentIndex],
      bottomNavigationBar:Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.lightBlue)
        ),
        child: BottomNavigationBar(
          unselectedFontSize: 0,
          selectedFontSize: 0,
          backgroundColor:Colors.white70,
          type: BottomNavigationBarType.fixed,
          onTap: onTap,
          currentIndex:currentIndex,
          selectedItemColor:Colors.lightBlue,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: const [

            BottomNavigationBarItem(label:"Home",icon:Icon(Icons.home_filled)),
            BottomNavigationBarItem(label:"Contact Us",icon:Icon(Icons.call)),
            BottomNavigationBarItem(label:"Profile",icon:Icon(Icons.person)),
            BottomNavigationBarItem(label:"Settings",icon:Icon(Icons.settings)),
          ],

        ),
      ),
    );
  }
}

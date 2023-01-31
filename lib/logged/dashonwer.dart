import 'package:eazy_rent/logged/profile.dart';
import 'package:eazy_rent/logged/search.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'contact.dart';



class DashBoardLogged extends StatefulWidget {

  static const  String id='dashboard Logged';

  @override
  State<DashBoardLogged> createState() => _DashBoardLoggedState();
}

class _DashBoardLoggedState extends State<DashBoardLogged> {




  List pages=[

    Home(),
    Messages(),
    ProfileUser(),
    Contact(),


  ];


  int currentIndex=0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
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

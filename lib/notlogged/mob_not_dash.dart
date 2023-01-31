
import 'package:flutter/material.dart';

import '../responsive/responsive.dart';



class NotDash extends StatefulWidget {

  static const  String id='notdash';

  @override
  State<NotDash> createState() => _NotDashState();
}

class _NotDashState extends State<NotDash> with TickerProviderStateMixin{

//   late AnimationController animationController;
//
//
//   Widget _indexView=Container();
//
//   @override
//   void initState() {
//
//     animationController=AnimationController(
//       duration: const Duration(milliseconds: 400),
//         vsync:this
//     );
//
//     _indexView=Container();
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) { });
//
//     super.initState();
//   }
//
//
//   Future startLoadingScreen() async{
//
//     await Future.delayed( Duration(milliseconds: 400));
//     setState(() {
//       _indexView=HomeNot(
//         animationController:animationController,
//       );
// animationController.forward();
//     });
//
//   }
//
//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body:Column(
        children: [
          Container(
            child:ResponsiveLayoutUser.getResponsiveWidget(context,
              mobile:Center(child: Text('Mobile')) ,
              web:Center(child: Text('Web'))  ,
              tab:Center(child: Text('Tab'))  ,
            ),
          )
        ],
      )
    );
  }
}


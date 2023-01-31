
import 'package:eazy_rent/providers/cat.dart';
import 'package:eazy_rent/providers/chartdetail.dart';
import 'package:eazy_rent/providers/housepro.dart';

import 'package:eazy_rent/providers/sliderpro.dart';
import 'package:eazy_rent/providers/chart.dart';
import 'package:eazy_rent/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'logged-signup/login.dart';
import 'logged-signup/sign.dart';
import 'logged/dashonwer.dart';
import 'notlogged/dashbo.dart';
import 'notlogged/homenot.dart';
import 'notlogged/mob_not_dash.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async{
 await Hive.initFlutter();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
FlutterNativeSplash.remove();
  Provider.debugCheckInvalidValueType=null;
  runApp(

    MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create:(_) => CategoryProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => HouseIDProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => SliderProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => ChartRoomProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => ChatDetailsProvider(),
        ),
      ],
      child: const MyApp(),
    ),

  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eazy Rent',
      theme: ThemeData(
        primarySwatch:Colors.blue,
      ),
      builder:EasyLoading.init(),
      initialRoute: Splash.id,// first route
      routes: {
        //we will add the screens here for easy navigation

        Splash.id:(context)=>Splash(),
        NotDash.id:(context)=>NotDash(),
        DashNot.id:(context)=>DashNot(),
        LoginScreen.id:(context)=>LoginScreen(),
        SignUpScreen.id:(context)=>SignUpScreen(),
        DashBoardLogged.id:(context)=>DashBoardLogged(),
        Homenot.id:(context)=>Homenot(),
      },
    );
  }
}


import 'package:eazy_rent/logged-signup/sign.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../crypt/encrypt.dart';
import '../logged/dashonwer.dart';
import '../shared/pref.dart';

class LoginScreen extends StatefulWidget {

  static const  String id='login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final _formKey=GlobalKey<FormState>();
  final _ema=TextEditingController();
  final _pass=TextEditingController();




  login() async {

    var response=await http.post(Uri.parse('https://eazyrent256.com/api/user/login.php'),

        body:{"email":encryp(_ema.text),"password":encryp(_pass.text),});


    setState(() async {

      EasyLoading.show(status: 'Logging in .....');


      if(response.statusCode==200){
        var userData=json.decode(response.body);

        String ID=userData['id'];
        String name=userData['name'];
        String email=userData['email'];
        String pass=userData['password'];
        String pic=userData['pic'];
        String num=userData['phone'];
        String log=userData['last_log'];
        String create=userData['create_date'];
        String ad=userData['addr'];
        String lat=userData['lat'];
        String lon=userData['lon'];
        String token=userData['token'];
        String type=userData['type'];
        String status=userData['status'];
        String renew=userData['renew_date'];
        String fcm=userData['fcmid'];


        if(userData=="ERROR"){


          EasyLoading.showError('Login Failed..');


          // showDialog(
          //   context: (context),
          //   builder:(context)=> AlertDialog(
          //     shape:Border.all(color: Colors.grey),
          //     backgroundColor: Colors.red,
          //     title:const Text('Message',style: TextStyle(color: Colors.white),),
          //     content:const Text('Logged In Failed',style: TextStyle(color: Colors.white),) ,
          //     actions:<Widget> [
          //       ElevatedButton(
          //         style: ButtonStyle(
          //           backgroundColor:MaterialStateProperty.all(Colors.lightGreen ),
          //         ),
          //         onPressed:(){
          //           Navigator.pop(context);
          //         },
          //         child: const Text('Cancel',style: TextStyle(color: Colors.white),),),
          //
          //     ],
          //   ),
          // );



        }else{




          if(userData['type']=='user' || userData['type']=='owner'){

            savePref(ID, name, email, num, pass, pic, lon, lat, ad, token, renew, status, type, log, create,fcm).then((value){

              Navigator.pushReplacementNamed(context, DashBoardLogged.id);
            });
            EasyLoading.showSuccess(' Logged In...');

            // showDialog(
            //   context: (context),
            //   builder:(context)=> AlertDialog(
            //     shape:Border.all(color: Colors.grey),
            //     backgroundColor: Colors.purple,
            //     title:const Text('Message',style: TextStyle(color: Colors.white),),
            //     content:const Text('Logged In Successfully',style: TextStyle(color: Colors.white),) ,
            //     actions:<Widget> [
            //       ElevatedButton(
            //         style: ButtonStyle(
            //           backgroundColor:MaterialStateProperty.all(Colors.lightGreen ),
            //         ),
            //         onPressed:(){
            //           Navigator.pop(context);
            //         },
            //         child: const Text('Cancel',style: TextStyle(color: Colors.white),),),
            //
            //     ],
            //   ),
            // );

          }

          print(userData);
        }

      }



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



  savePref(
      String ID ,String name,String email, String num,String pass,String pic ,String lon,String lat,
      String ad,String token,String renew,String status ,String type, String log,String create,String fcm
      ) async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    setState(() {
      sharedPreferences.setString(PrefInfo.ID, ID);
      sharedPreferences.setString(PrefInfo.name, name);
      sharedPreferences.setString(PrefInfo.email,email);
      sharedPreferences.setString(PrefInfo.num,num);
      sharedPreferences.setString(PrefInfo.pass, pass);
      sharedPreferences.setString(PrefInfo.pic, pic);
      sharedPreferences.setString(PrefInfo.lon, lon);
      sharedPreferences.setString(PrefInfo.lat, lat);
      sharedPreferences.setString(PrefInfo.ad,ad);
      sharedPreferences.setString(PrefInfo.token, token);
      sharedPreferences.setString(PrefInfo.renew, renew);
      sharedPreferences.setString(PrefInfo.status, status);
      sharedPreferences.setString(PrefInfo.type, type);
      sharedPreferences.setString(PrefInfo.log, log);
      sharedPreferences.setString(PrefInfo.create, create);
      sharedPreferences.setString(PrefInfo.fcm, fcm);
    });

  }



  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(

              image: DecorationImage(
                image: AssetImage("assets/images/ty.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //image section
                Image.asset('assets/images/loo.png',height: size.height * 0.2,color: Colors.white,),
                const Text('Welcome Back,',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                const Text('Find the Best Houses for rent,Just Login',style: TextStyle(color: Colors.white,fontSize: 14),),


                //form
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Form(
                    key: _formKey,
                      child:GlassmorphicContainer(
                        width:MediaQuery.of(context).size.width,
                        height:320,
                        borderRadius: 20,
                        blur: 20,
                        alignment: Alignment.bottomCenter,
                        border: 2,
                        linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFFffffff).withOpacity(0.1),
                              const Color(0xFFFFFFFF).withOpacity(0.05),
                            ],
                            stops: const [
                              0.1,
                              1,
                            ]),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.5),
                            const Color((0xFFFFFFFF)).withOpacity(0.5),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              TextFormField(
                                controller:_ema,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email_outlined),
                                    labelText: 'Email',
                                    hintText: 'Email',
                                    border: OutlineInputBorder()
                                ),

                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Enter Email';

                                    }
                                    bool _isValid= (EmailValidator.validate(value));
                                    if(_isValid==false){
                                      return 'Enter Valid Email Address';

                                    }
                                    return null;




                                  }
                              ),

                              const SizedBox(height: 10,),

                              TextFormField(
                                controller:_pass,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.fingerprint),
                                    labelText: 'Password',
                                    hintText: 'Password',
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(onPressed:(){

                                    }, icon:const Icon(Icons.remove_red_eye_outlined))

                                ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Enter your Password';

                                    }
                                    return null;
                                  }
                              ),

                              const SizedBox(height: 10,),



                              SizedBox(
                                width:double.infinity,
                                child: ElevatedButton(
                                    onPressed:(){

                                      if(_formKey.currentState!.validate()){

                                        login();
                                      }

                                    },
                                    child: Text('Login'.toUpperCase(),style: const TextStyle(color: Colors.white),)
                                ),
                              ),

                              const SizedBox(height: 2,),

                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed:(){
                                      //Navigator.pushReplacementNamed(context, SignUpScreen.id);

                                    },
                                    child:Text('Forgot Password ? ',style: TextStyle(color: Colors.white,fontSize: 12))
                                ),
                              ),

                              TextButton(
                                  onPressed:(){
                                    Navigator.pushReplacementNamed(context, SignUpScreen.id);

                                  },
                                  child:const Text.rich(
                                      TextSpan(
                                          text:'Do not Have an Account  ',style: TextStyle(color: Colors.black,fontSize: 12),
                                          children:[
                                            TextSpan(
                                              text:'Sign Up?',style: TextStyle(color: Colors.white,fontSize: 12),
                                            )
                                          ]
                                      )
                                  )
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import '../../../crypt/encrypt.dart';

import 'login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class SignUpScreen extends StatefulWidget {

  static const  String id='sign';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey=GlobalKey<FormState>();

  final _name=TextEditingController();
  final _num=TextEditingController();
  final _ema=TextEditingController();
  final _pass=TextEditingController();
  final _address=TextEditingController();
  final _lon=TextEditingController();
  final _lat=TextEditingController();

  _scaffold(message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(message),
      action: SnackBarAction(label: 'Ok',onPressed: (){
        ScaffoldMessenger.of(context).clearSnackBars();
      },),));
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
                const Text('Get On Board,',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                const Text('Create your profile to start your journey',style: TextStyle(color: Colors.white,fontSize: 14),),


                //form
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                      child:GlassmorphicContainer(
                        width:MediaQuery.of(context).size.width,
                        height:400,
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
                                controller: _name,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person_outline_outlined),
                                    labelText: 'Full Name',
                                    hintText: 'Full Name',
                                    border: OutlineInputBorder(),
                                ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Enter your Name';

                                    }
                                    return null;
                                  }
                              ),

                              const SizedBox(height: 10,),

                              TextFormField(
                                controller: _num,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.call),
                                  labelText: 'Phone No',
                                  hintText: 'Phone No',
                                  border: OutlineInputBorder()
                                ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Enter your Phone Number';

                                    }
                                    return null;
                                  }
                              ),

                              const SizedBox(height: 10,),

                              TextFormField(
                                controller: _ema,
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
                                controller: _pass,
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
                                    onPressed:() async {


                                      if(_formKey.currentState!.validate()) {
                                        var response = await http.post(
                                            Uri.parse(
                                                'https://www.eazyrent256.com/api/user/register.php'),
                                            headers: {"Accept": "headers/json"},
                                            body: {
                                              "name": encryp(_name.text),
                                              "phone": encryp(_num.text),
                                              "email": encryp(_ema.text),
                                              "password": encryp(_pass.text),
                                              //"location":GeoPoint.fromLatLng( point: LatLng(double.parse(encryp('${_authData.shopLatitude}')),double.parse(encryp('${_authData.shopLongitude}')))),
                                              "addr": encryp('0'),
                                              "lon": encryp('0'),
                                              "lat": encryp('0'),
                                            });



                                setState(() async {

                                  EasyLoading.show(status: 'Saving .....');

                                  if (response.statusCode == 200) {
                                    var userData = json.decode(
                                        response.body);

                                    if (userData == "ERROR") {

                                      EasyLoading.showError('Email already exists..');


                                      // showDialog(
                                      //   context: (context),
                                      //   builder: (context) =>
                                      //       AlertDialog(
                                      //         title: const Text(
                                      //             'Message'),
                                      //         content: const Text(
                                      //             'Email already exists'),
                                      //         actions: <Widget>[
                                      //           ElevatedButton(
                                      //             style: ButtonStyle(
                                      //               backgroundColor: MaterialStateProperty
                                      //                   .all(Colors
                                      //                   .lightGreen),
                                      //             ),
                                      //             onPressed: () {
                                      //               Navigator.pop(
                                      //                   context);
                                      //             },
                                      //             child: const Text(
                                      //                 'Cancel'),),
                                      //
                                      //         ],
                                      //       ),
                                      // );
                                    } else {

                                      Navigator.pushReplacementNamed(context, LoginScreen.id);

                                      EasyLoading.showSuccess(' Saved...');

                                      // showDialog(
                                      //   context: (context),
                                      //   builder: (context) =>
                                      //       AlertDialog(
                                      //         title: const Text(
                                      //             'Message'),
                                      //         content: const Text(
                                      //             'Registration successful!!'),
                                      //         actions: <Widget>[
                                      //           ElevatedButton(
                                      //             style: ButtonStyle(
                                      //               backgroundColor: MaterialStateProperty
                                      //                   .all(Colors
                                      //                   .lightGreen),
                                      //             ),
                                      //             onPressed: () {
                                      //               Navigator.pop(
                                      //                   context);
                                      //             },
                                      //             child: const Text(
                                      //                 'Cancel'),),
                                      //
                                      //         ],
                                      //       ),
                                      // );
                                      print(userData);
                                    }
                                  }


                                });



                                      }

                                    },
                                    child: Text('Sign Up'.toUpperCase(),style: const TextStyle(color: Colors.white),)
                                ),
                              ),

                              const SizedBox(height: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [


                                  TextButton(
                                      onPressed:(){
                                        Navigator.pushReplacementNamed(context, LoginScreen.id);

                                      },
                                      child:const Text.rich(
                                        TextSpan(
                                          text:' Have an Account  ',style: TextStyle(color: Colors.black,fontSize: 12),
                                          children:[
                                            TextSpan(
                                              text:'Login?',style: TextStyle(color: Colors.white,fontSize: 12),
                                            )
                                          ]
                                        )
                                      )
                                  ),

                                ],
                              )

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

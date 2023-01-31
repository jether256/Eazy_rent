import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../crypt/encrypt.dart';
import '../notlogged/dashbo.dart';
import '../shared/pref.dart';



class EditAccount extends StatefulWidget {
  static const  String id='editAca';


  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _fomkey=GlobalKey<FormState>();



  final _name=TextEditingController();
  final _num=TextEditingController();
  final _ema=TextEditingController();
  final _pass=TextEditingController();

  @override
  void initState() {
    getPref().then((value){
      getData();

    });

    super.initState();
  }

  getData() async{

    setState(() {
      _name.text='${name}';
      _num.text='${num}';
      _ema.text='${email}';
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



  _scaffold(message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(message),
      action: SnackBarAction(label: 'Ok',onPressed: (){
        ScaffoldMessenger.of(context).clearSnackBars();
      },),));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //form
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        key: _fomkey,
                        child:Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.call),
                                      labelText: 'Password',
                                      hintText: 'Password',
                                      border: OutlineInputBorder()
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Password';

                                    }
                                    return null;
                                  }
                              ),


                              const SizedBox(height: 10,),

                              SizedBox(
                                width:double.infinity,
                                child: ElevatedButton(
                                    onPressed:() async {

                                      EasyLoading.show(status: 'Editing .....');

                                      if(_fomkey.currentState!.validate()) {
                                        var response = await http.post(
                                            Uri.parse(
                                                'https://eazyrent256.com/api/user/upuser.php'),
                                            headers: {
                                              "Accept": "headers/json"
                                            },
                                            body: {
                                              "id": encryp('${userID}'),
                                              "name": encryp(_name.text),
                                              "phone": encryp(_num.text),
                                              "email": encryp(_ema.text),
                                              "pass": encryp(_pass.text),
                                            });


                                        if (response.statusCode == 200) {

                                          EasyLoading.showSuccess(' Account Edited.....');

                                          signOut();

                                        } else {



                                        }

                                        EasyLoading.dismiss();

                                      }




                                    },
                                    child: Text('Update'.toUpperCase(),style: const TextStyle(color: Colors.white),)
                                ),
                              ),

                              const SizedBox(height:40,),


                            ],
                          ),
                        )
                    ),
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

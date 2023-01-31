import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier{


  late String id;
  late String name;
  late String pic;

  getCat(ID,NEM,PIC){
    id=ID;
    name=NEM;
    pic=PIC;
    notifyListeners();
  }

}
import 'package:commune_spring_2020/screens/auth/authScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:commune_spring_2020/Models/User.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //retrun the proper widget
    if(user==null){
      return Authenticate();
    }else{
    return Home(uid: user.uid);
    }


  }
} 
import 'package:commune_spring_2020/Pages/homepage.dart';
import 'package:commune_spring_2020/Pages/register_user.dart';
import 'package:commune_spring_2020/Pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:commune_spring_2020/Pages/loginWelcomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     
   // Future u = AuthServices().signIn("bruh45678@bruhmail.com", "Bruh11");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home()
    );
  } 
}



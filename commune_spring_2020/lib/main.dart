import 'package:commune_spring_2020/Models/User.dart';
import 'package:commune_spring_2020/Pages/householdprofile.dart';
// import 'package:commune_spring_2020/Pages/login.dart';
import 'package:commune_spring_2020/screens/wrapper.dart';
import 'package:commune_spring_2020/screens/auth/AccountAccess.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:commune_spring_2020/Pages/homepage.dart';
// import 'package:commune_spring_2020/Pages/register_user.dart';
// import 'package:commune_spring_2020/Pages/welcome.dart';
import 'package:flutter/material.dart';
import 'Pages/AccountAccessScreens/login.dart';
import 'Pages/householdprofile.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        // home: HouseholdProfile(),
      ),
    );
  }
} 

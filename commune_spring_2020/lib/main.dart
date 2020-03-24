import 'package:commune_spring_2020/Models/User.dart';
import 'package:commune_spring_2020/screens/wrapper.dart';
import 'package:commune_spring_2020/services/auth2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
} 
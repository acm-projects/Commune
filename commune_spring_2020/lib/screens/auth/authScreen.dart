// import 'package:commune_spring_2020/screens/auth/register.dart';
// import 'package:commune_spring_2020/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:commune_spring_2020/Pages/AccountAccessScreens/login.dart';
import 'package:commune_spring_2020/Pages/AccountAccessScreens/register_user.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn=true;
  void changeView(){
    setState(()=> showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
        // return SignIn(changeView: changeView);
        return LoginPage();
      }else{
      // return Register(changeView: changeView);
        return RegisterUser();
    }
    
  }
}
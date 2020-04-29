import 'package:commune_spring_2020/Pages/signIn.dart';
import 'package:commune_spring_2020/Pages/signUp.dart';
import 'package:commune_spring_2020/screens/auth/register.dart';
import 'package:commune_spring_2020/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';


class loginWelcomePage extends StatefulWidget {
  @override
  _loginWelcomePageState createState() => _loginWelcomePageState();
}

class _loginWelcomePageState extends State<loginWelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Welcome To Commune'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
                onPressed: NavigateToLogin,
                child: Text('Login'),
              ),
              RaisedButton(
                onPressed: NavigateToSignUp,
                child: Text('Sign up'),
              )
        ],),
    );
  }

  void NavigateToLogin(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignIn(), fullscreenDialog: true));
  }

  void NavigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Register(), fullscreenDialog: true));
  }

}
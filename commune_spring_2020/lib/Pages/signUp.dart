import 'package:commune_spring_2020/Pages/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signUpPage extends StatefulWidget {
  @override
  _signUpPageState createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
      appBar: new AppBar(),
      body:Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
              TextFormField(
                validator: (input){
                  if(input.isEmpty){
                    return 'Type in an email';
                  }
                  if(input.contains('@')==false){
                    return 'Type in a vaild email';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email'
                ),
              ),
              TextFormField(
                validator: (input){
                  if(input.isEmpty){
                    return 'Type in a password';
                  }
                  if(input.length<6){
                    return 'Password must be at least 6 characters';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: 'Password'
                ),
                obscureText: true,
              ),
              RaisedButton(
                onPressed: signUp,
                child: Text('Create Account'),
              )
            ],
          ),
   ),
   ); 
  }

  Future<void> signUp() async {
    //final formState = _formKey.currentState;
    if(_formKey.currentState.validate())
    {
      _formKey.currentState.save();
      try{
        AuthResult user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password));
        user.user.sendEmailVerification();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> signInPage()));
      }catch(e){
      print(e.message);
     }
    }
  }
}
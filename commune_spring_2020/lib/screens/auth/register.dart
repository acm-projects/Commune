import 'package:commune_spring_2020/screens/HouseloadAccessPages/HouseHoldAccessOptions.dart';
import 'package:commune_spring_2020/screens/auth/sign_in.dart';
import 'package:commune_spring_2020/screens/Home_Files/home.dart';
import 'package:commune_spring_2020/screens/auth/AccountAccess.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:commune_spring_2020/services/database.dart';

class Register extends StatefulWidget {

  final Function changeView;

  Register({this.changeView});

  @override
  _RegisterState createState() => _RegisterState();
}


class _RegisterState extends State<Register> {

  final AuthService _auth= new AuthService(); 
  final _formKey=GlobalKey<FormState>();

  String _email="",_password="", _error="",_firstName="",_lastName="",_age="";
  int _budget=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text("Register to Commune"),
        backgroundColor: Colors.brown[400],
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              widget.changeView();
            },
           icon: Icon(Icons.person),
            label: Text("Sign In")
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (pas)=> pas.isEmpty ? "Enter your First Name" : null,
              decoration: InputDecoration(
                labelText: "First Name",
              ),
              onChanged: (val){
                _firstName=val;
              },
            ),
            TextFormField(
              validator: (pas)=> pas.isEmpty ? "Enter your Last Name" : null,
              decoration: InputDecoration(
                labelText: "Last Name",
              ),
              onChanged: (val){
                _lastName=val;
              },
            ),
            TextFormField(
              validator: (pas)=> pas.isEmpty ? "Enter your age" : null,
              decoration: InputDecoration(
                labelText: "Age",
              ),
              onChanged: (val){
                _age=val;
              },
            ),
            TextFormField(
              validator: (val)=>val.isEmpty ? "Enter an email" : null,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "1234@example.com",
              ),
              onChanged: (val){
                _email=val;
              },
            ),
            TextFormField(
              validator: (pas)=> pas.length<8 ? "Your password needs at least 8 charachters" : null,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
              ),
              onChanged: (val){
                _password=val;
              },
            ),
            // TextFormField(
            //   validator: (b)=>b.isEmpty ? "Enter a budget" : null,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //     labelText: "Budget in USD",
            //     hintText: "e.g. 500"
            //   ),
            //   onChanged: (num){
            //     _budget=int.parse(num);
            //   },
            // ),
            RaisedButton(
              child: Text("Sign Up"),
              onPressed: () async{
                if(_formKey.currentState.validate()){
                  dynamic result = await _auth.signUp(_firstName,_lastName,_email,_age,_budget,_password);
                    if(result==null){
                      setState(()=> _error="something went wrong try again");
                    }
                    else{
                      print("about to go to home");
                      HouseHoldSelectionPage();
                    }
                }   
              }
            ),
            Text(
              _error,
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}

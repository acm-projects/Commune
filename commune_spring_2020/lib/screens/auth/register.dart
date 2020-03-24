import 'package:commune_spring_2020/screens/auth/sign_in.dart';
import 'package:commune_spring_2020/screens/home/home.dart';
import 'package:commune_spring_2020/services/auth2.dart';
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

  String _email="",_password="", _error="",_displayName="";
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
              validator: (pas)=> pas.isEmpty ? "Enter your preffered name" : null,
              decoration: InputDecoration(
                labelText: "name",
              ),
              onChanged: (val){
                _displayName=val;
              },
            ),
            TextFormField(
              validator: (val)=>val.isEmpty ? "Enter an email" : null,
              decoration: InputDecoration(
                labelText: "Gmail",
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
            TextFormField(
              validator: (b)=>b.isEmpty ? "Enter a budget" : null,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Budget in USD",
                hintText: "e.g. 500"
              ),
              onChanged: (num){
                _budget=int.parse(num);
              },
            ),
            RaisedButton(
              child: Text("Sign Up"),
              onPressed: () async{
                if(_formKey.currentState.validate()){
                  dynamic result = await _auth.signUp(_email, _password, _budget, _displayName);
                    if(result==null){
                      setState(()=> _error="Your username or password do not match our records");
                    }
                    else{
                      print("about to go to home");
                      Home();
                    }
                }
                // if(_formKey.currentState.validate()){
                //   dynamic result= await _auth.signUp(_email, _password,budget, _displayName);
                //   print("the result: "+result);
                //   if(result==null){
                //     setState(() => _error="account was not created, enter a valid email");
                //   }
                // }  
                
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
  //  Future<void> signUp() async {
  //   //final formState = _formKey.currentState;
  //   if(_formKey.currentState.validate())
  //   {
  //     _formKey.currentState.save();
  //     try{
  //       AuthResult user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password));
  //       user.user.sendEmailVerification();

  //       //Create a new document for the user with the uid
  //       await DatabaseService(uid: user.user.uid).updateUserData( _email, budget,  _displayName, user.user.uid);


  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignIn()));
  //     }catch(e){
  //    }
  //   }
  // }
}


import 'package:commune_spring_2020/Pages/signIn.dart';
import 'package:commune_spring_2020/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class signUpPage extends StatefulWidget {
  @override
  _signUpPageState createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  String _email, _password, _userFirstName, _userLastName, _age;
  
 // Firestore db = Firestore.instance;


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
                    return 'Type in a First Name';
                  }
                },
                onSaved: (input) => _userFirstName = input,
                decoration: InputDecoration(
                  labelText: 'First Name'
                ),
                
              ),
              ///////////////////////////////
              TextFormField(
                validator: (input){
                  if(input.isEmpty){
                    return 'Type in a Last Name';
                  }
                },
                onSaved: (input) => _userLastName = input,
                decoration: InputDecoration(
                  labelText: 'Last Name'
                ),
                
              ),
              //////////////////////////////
              TextFormField(
                validator: (input){
                  if(input.isEmpty){
                    return 'Type in an age';
                  }
                },
                onSaved: (input) => _age = input,
                decoration: InputDecoration(
                  labelText: 'Age'
                ),
                
              ),
              /////////////////////////////
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

        //Create a new document for the user with the uid
        await DatabaseService(uid: user.user.uid).updateUserData(_userFirstName, _userLastName, _email, _age, 'Null');


        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> signInPage()));
      }catch(e){

       if(e.toString().contains('The email address is already in use by another account'))
        {
          _showDialogForExistingAccount();
        }
     }
    }
  }

  void _showDialogForExistingAccount()
  {
    showDialog(
      context: context,
      builder:(BuildContext context){
        return AlertDialog(
          title: new Text("Account Exists"),
          content: new Text(_email+" has already been used for a commune account. Either reset your password or use a different email."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed:() {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
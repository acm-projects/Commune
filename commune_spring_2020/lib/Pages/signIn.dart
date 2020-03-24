import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:commune_spring_2020/Home/home.dart';

import 'package:commune_spring_2020/Pages/HouseHoldSelection.dart';

class signInPage extends StatefulWidget {
  @override
  _signInPageState createState() => new _signInPageState();
}

class _signInPageState extends State<signInPage> {
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
                onPressed: signIn,
                child: Text('Login'),
              ),
              RaisedButton(
                onPressed: resetPassword,
                child: Text('Reset Password'),
              )
            ],
          ),
   ),
   ); 
  }

  Future<void> resetPassword() async {
    final formState = _formKey.currentState;
    if(formState.validate())
    {
      formState.save();
      
      try
      {
        var auth = FirebaseAuth.instance;
        auth.sendPasswordResetEmail(email: _email);
        _showDialogForPasswordReset();

      }catch(e)
      {
         print(e.message);
      }
      

    }

   }

  Future signIn() async {
   
    final formState = _formKey.currentState;
    if(formState.validate())
    {
      formState.save();
      try{
        AuthResult user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password));

        if(user.user.isEmailVerified){

         var db= Firestore.instance;
         var userDoc = db.collection('users').document(user.user.uid);
         var houseHoldName='';
         await userDoc.get().then((doc){
             houseHoldName=doc['HouseHoldName'];
         });
         

         if(houseHoldName=='Null')
         {
           Navigator.push(context, MaterialPageRoute(builder: (context)=> HouseHoldSelectionPage()));
         }
         else
         {
           Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(userUid: user.user.uid, houseName: houseHoldName)));
         }
          //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(userUid: user.user.uid)));
        }
        else
        {
          _showDialogForUnVerifiedEmail();
        }
      }catch(e){
       
       print(e.toString());
         if(e.toString().contains('ERROR_USER_NOT_FOUND'))
          {
            String error='ERROR_USER_NOT_FOUND';
           _showDialogErroLoginUser(error);
          }

          if(e.toString().contains('The password is invalid or the user does not have a password'))
          {
            String error='ERROR_WRONG_PASSWORD';
           _showDialogErroLoginUser(error);
          }

      return e;
     }
    }
  }

  void _showDialogForUnVerifiedEmail()
  {
    showDialog(
      context: context,
      builder:(BuildContext context){
        return AlertDialog(
          title: new Text("Unverified Email"),
          content: new Text("This Account is unverifed. Please check your email for a verification email from the Commune Team!"),
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

  void _showDialogForPasswordReset()
  {
    showDialog(
      context: context,
      builder:(BuildContext context){
        return AlertDialog(
          title: new Text("Password Reset"),
          content: new Text('A password reset link was sent to '+_email),
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

  void _showDialogErroLoginUser(String error)
  {
    showDialog(
      context: context,
      builder:(BuildContext context){
        if(error=='ERROR_USER_NOT_FOUND')
        {
        return AlertDialog(
          title: new Text("User Does Not Exist"),
          content: new Text("There is no user registered with "+_email+". Try a different email."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed:() {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        }
         if(error=='ERROR_WRONG_PASSWORD')
        {
        return AlertDialog(
          title: new Text("Wrong Password"),
          content: new Text("That password is incorrect for "+_email+". Try again."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed:() {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        }
      },
    );
  }

  
}
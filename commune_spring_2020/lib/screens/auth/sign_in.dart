import 'package:commune_spring_2020/screens/auth/AccountAccess.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function changeView;
  SignIn({this.changeView});

  @override
  _SignInState createState() => _SignInState();
}



class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  //store gmail and pass
  String email="",password="",error="";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Welcome to Commune'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed:(){
              widget.changeView();
            },
              icon: Icon(Icons.person),
              label: Text("Sign up")
            )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (e)=> e.isEmpty ? "Enter an email" :null,
              onChanged: (val){
                email=val.toString();
              },
            ),
            TextFormField(
              validator: (pas)=> pas.isEmpty ? "Enter a password":null,
              obscureText: true,
              onChanged: (val){
                password=val.toString();
              },
            ),
            RaisedButton(
              onPressed: ()async{
                if(_formKey.currentState.validate()){
                  dynamic result = await _auth.signIn(email, password);
                    if(result==null){
                      setState(()=> error="Your username or password do not match our records");
                    }
                    else{
                      
                    }
                }
              },
              color: Colors.blue[200],
              child: Text(
                "Sign In"
              ),
            ),
            Text(
              error,
              style: TextStyle(color:Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
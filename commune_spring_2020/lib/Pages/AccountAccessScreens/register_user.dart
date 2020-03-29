import 'package:commune_spring_2020/Pages/homepage.dart';
import 'package:commune_spring_2020/screens/HouseloadAccessPages/HouseHoldAccessOptions.dart';
import 'package:commune_spring_2020/screens/auth/AccountAccess.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:commune_spring_2020/Pages/app_card.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State {
  //backend code
  final AuthService _auth= new AuthService(); 
  String _email = "",
      _password = "",
      _error = "",
      _firstName = "",
      _lastName = "",
      _age = "";

  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 126, 134, 233),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: AssetImage('assets/logo.png'),
                  width: 200,
                  height: 200),
              Text(
                'Commune',
                style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 242, 242, 242),
                    fontFamily: 'Raleway'),
              ),
              AppCard(
                  child: Container(
                color: Colors.transparent,
                child: Column(children: <Widget>[
                  TextFormField(
                    //update the var
                    onChanged: (val) {
                      _firstName = val;
                    },

                    obscureText: false,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  TextFormField(
                    //update the var
                    onChanged: (val) {
                      _email = val;
                    },
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  TextFormField(
                    //update the var
                    onChanged: (val) {
                      _password = val;
                    },
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  )
                ]),
              )),
              FlatButton(
                onPressed: ()async {
                  
                  dynamic result = await _auth.signUp(
                      _firstName, _lastName, _email, _age, 0, _password);
                  if (result == null) {
                    setState(() => _error = "something went wrong try again");
                  } else {
                    print('88888888888888888888888888888888');
                    print("about to go to home");
                    Home();
                  }
                },
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Raleway',
                    fontSize: 18.0,
                  ),
                ),
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white),
                ),
              )
            ],
          ),
        ));
    // return Scaffold(
    //   backgroundColor: Color( 0xFF7E86DF ),
    //   body: Container(
    //     decoration: BoxDecoration(
    //       gradient: LinearGradient(
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter,
    //         colors: [Color(0xFFAEB5FF), Color(0xFF7982E9)]
    //       )
    //     ),
    //     child: Builder(
    //       builder: (context) => Form(
    //         key: _formKey,
    //         child: Column(
    //           children: <Widget>[
    //             Tab(
    //               icon: Container(
    //                 child: Image.asset(
    //                   'assets/logo.png',
    //                   width: 200,
    //                   height: 200
    //                 ),
    //                 alignment: Alignment.center,
    //                 margin: EdgeInsets.only(top: 30.0)
    //               )
    //             ),
    //             Container(
    //               padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
    //               alignment: Alignment.center,
    //               child: Text(
    //                 'Register',
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                   fontFamily: 'Raleway',
    //                   fontSize: 40.0,
    //                   color: Color( 0xFFF2F2F2 )
    //                 )
    //               )
    //             ),
    //             TextFormField(
    //               validator: (value){
    //                 if( value.isEmpty ){
    //                   return 'Please enter your name';
    //                 }
    //               },
    //               decoration: InputDecoration(
    //                 labelText: 'Name',
    //                 labelStyle: TextStyle(
    //                   color: Color( 0xFFFFD788 ),
    //                   fontFamily: 'Roboto',
    //                   fontSize: 20
    //                 ),
    //                 contentPadding: EdgeInsets.fromLTRB(10, 30, 0, 10)
    //               )
    //             ),
    //             TextFormField(
    //               validator: (value){
    //                 if( value.isEmpty ){
    //                   return 'Please enter your email';
    //                 }
    //               },
    //               decoration: InputDecoration(
    //                 labelText: 'Email',
    //                 labelStyle: TextStyle(
    //                   color: Color( 0xFFFFD788 ),
    //                   fontFamily: 'Roboto',
    //                   fontSize: 20
    //                 ),
    //                 contentPadding: EdgeInsets.fromLTRB(10, 30, 0, 10)
    //               )
    //             ),
    //             TextFormField(
    //               validator: (value){
    //                 if( value.isEmpty ){
    //                   return 'Please enter your age';
    //                 }
    //               },
    //               decoration: InputDecoration(
    //                 labelText: 'Age',
    //                 labelStyle: TextStyle(
    //                   color: Color( 0xFFFFD788 ),
    //                   fontFamily: 'Roboto',
    //                   fontSize: 20
    //                 ),
    //                 contentPadding: EdgeInsets.fromLTRB(10, 30, 0, 10)
    //               ),
    //             ),
    //             RaisedButton(
    //               onPressed: () {
    //                 final form = _formKey.currentState;
    //               },
    //               child: Text(
    //                 'Submit',
    //                 style: TextStyle(
    //                   fontSize: 20,
    //                   fontFamily: 'Roboto',
    //                   color: Color(0xff582d8f)
    //                 )
    //               ),
    //             ),
    //           ],
    //         )
    //       )
    //     )
    //   )
    // );
  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
              ),
              Container(
                child: Image(
                  image: AssetImage('assets/logo.png')
                ),
                margin: EdgeInsets.only(bottom: 100)
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: FlatButton(
                  onPressed: () {},
                  textColor: Colors.white,
                  child: Text('Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Raleway'
                    )
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25),
                    side: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB( 50, 15, 50, 15),
                ),
              ),
              FlatButton(
                onPressed: () {},
                textColor: Colors.white,
                child: Text('Register',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Raleway'
                  )
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25),
                  side: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  )
                ),
                padding: EdgeInsets.fromLTRB( 39, 15, 39, 15),
              )
            ],
          )
        ],
      ),
      backgroundColor: Color( 0xFF7E86DF ),
    );
  }
}
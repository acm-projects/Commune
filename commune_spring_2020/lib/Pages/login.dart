import 'package:flutter/material.dart';
import 'package:propersetupcheck/common/app_card.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 126, 134, 233),
    body: Center(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children:[
        Image(image: AssetImage('assets/CommuneLogo.png'),),
        Text(
        'Commune',
        style: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.w400,
          color: Color.fromARGB(255, 242, 242, 242),
          fontFamily: 'Raleway'
        ),

      ),
       AppCard(
          child: Container(
          color: Colors.transparent,
            child: Column(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(
                    color: Colors.white
                  ),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                    ),
                  
                    ),
                ),
                TextFormField(
                  
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.white
                  ),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                        ),
                        ),
                    ),
                  ]
                ),
              )
            ),
            FlatButton(
              onPressed: () {},
              child: Text("Sign in",
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
      )
    );
  }
}
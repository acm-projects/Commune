import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text('[insert name]',
                  style: TextStyle(
                    color: Color(0xFFF2F2F2),
                    fontSize: 35,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold
                  )
                ),
                Text('Email: [insert email]',
                  style: TextStyle(
                    color: Color(0xFF1b4079),
                    fontSize: 20,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.normal
                  )
                ),
                Text('Age: [insert age]',
                  style: TextStyle(
                    color: Color(0xFF1b4079),
                    fontSize: 20,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.normal
                  )
                ),
                Text('Admin (if admin)',
                  style: TextStyle(
                    color: Color(0xFF1B4079),
                    fontSize: 20,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.normal
                  )
                )
              ]
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFB3B9FA), Color(0xFF6D77E0)]
              ),
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(25)
            ),
            padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
            margin: EdgeInsets.fromLTRB(25, 75, 25, 0),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20),
                  child: Text('LEADERBOARD',
                    style: TextStyle(
                      color: Color(0xFFF2F2F2),
                      fontSize: 40,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold
                    )
                  ),
                  color: Color(0xFF1B4079),
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Trevor',
                              style: TextStyle(
                                color: Color(0xFF1B4079),
                                fontSize: 25,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal
                              )
                            ),
                            Text('8000',
                              style: TextStyle(
                                color: Color(0xFF1B4079),
                                fontSize: 25,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal
                              )
                            )
                          ]
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Olimjon',
                              style: TextStyle(
                                color: Color(0xFF1B4079),
                                fontSize: 25,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal
                              )
                            ),
                            Text('7500',
                              style: TextStyle(
                                color: Color(0xFF1B4079),
                                fontSize: 25,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal
                              )
                            )
                          ]
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Neha',
                              style: TextStyle(
                                color: Color(0xFF1B4079),
                                fontSize: 25,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal
                              )
                            ),
                            Text('6000',
                              style: TextStyle(
                                color: Color(0xFF1B4079),
                                fontSize: 25,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal
                              )
                            )
                          ]
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Swaraaj',
                              style: TextStyle(
                                color: Color(0xFF1B4079),
                                fontSize: 25,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal
                              )
                            ),
                            Text('30',
                              style: TextStyle(
                                color: Color(0xFF1B4079),
                                fontSize: 25,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal
                              )
                            )
                          ]
                        )
                      )
                    ],
                  )
                )
              ]
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 35),
            color: Color(0xFF1B4079),
            width: MediaQuery.of(context).size.width,
            height: 5
          ),
          Container(
            margin: EdgeInsets.only(top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Text( 'Log Out',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Raleway',
                      color: Color(0xFFF2F2F2)
                    )
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25),
                    side: BorderSide(
                      color: Color(0xFF1B4079),
                      width: 2.0,
                    )
                  ),
                  padding: EdgeInsets.fromLTRB( 39, 15, 39, 15),
                  color: Color(0xFF7E86DF),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text( 'Reset Password',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Raleway',
                      color: Color(0xFFF2F2F2)
                    )
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25),
                    side: BorderSide(
                      color: Color(0xFF1B4079),
                      width: 2.0,
                    )
                  ),
                  padding: EdgeInsets.fromLTRB( 39, 15, 39, 15),
                  color: Color(0xFF7E86DF),
                )
              ]
            )
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only( top: 15 ),
            child: FlatButton(
              onPressed: () {},
              child: Text( 'LEAVE HOUSEHOLD',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Raleway',
                  color: Color(0xFFF2F2F2)
                )
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25),
                side: BorderSide(
                  color: Color(0xFF1B4079),
                  width: 2.0,
                )
              ),
              padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
              color: Color(0xFF1b4079),
            )
          )
        ],
      )
    );
  }

}
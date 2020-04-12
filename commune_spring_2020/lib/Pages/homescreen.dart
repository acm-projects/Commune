import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/Pages/bill_expansion.dart';
import 'package:commune_spring_2020/Pages/user_profile.dart';
import 'package:commune_spring_2020/services/choresServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'chore_expansion.dart';

class Homescreen extends StatefulWidget{

  final String uid;
  String hhname;
  Homescreen({this.uid});
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>{
  final List<String> items = List<String>.generate(100, (i) => "Item $i");
  
  @override
  Widget build(BuildContext context){
    choresServices cv=new choresServices();

    final screenSize = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFFFF), Color(0xFFFBF4F5)]
          )
        ),
        child: Column(
          children: <Widget>[
            //set up hhname
            StreamBuilder(
              stream: Firestore.instance.collection('users').document(widget.uid).snapshots(),
              builder:(context, snap){
                if(!snap.hasData){
                  return Text("loading....");
                }
                widget.hhname=snap.data["HouseHoldName"];
                return Text("null");
              }
            ),
            StreamBuilder(
              stream: Firestore.instance.collection('users').document(widget.uid).snapshots(),
              builder: (context, snap){
                if(!snap.hasData){
                  return Text("loading...");
                }
                  return Text("");
              }
            ),
            //to do container
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(15, 15, 0, 30),
              margin: EdgeInsets.fromLTRB(25, 40, 30, 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFB3B9FA), Color(0xFF6D77E0)]
                ),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(25)
              ),
              child: Column(
                children: <Widget>[
                  //To Do title
                  Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: <Widget>[
                        Text('To-Do',
                          style: TextStyle(
                            color: Color(0xFFF2F2F2),
                            fontSize: 40,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Spacer(),
                        FlatButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  content: ChoreExpansion(uid: widget.uid,),
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: new BorderRadius.circular(25.0)
                                  // ),
                                );
                              }
                            );
                          },
                          child: Icon(
                            Icons.add,
                            size: 30,
                            color: Color(0xFF7E86DF)
                          ),
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Color(0xB3FFFFFF),
                              width: 2.0,
                            )
                          ),
                          color: Color(0xB3FFFFFF),
                        )
                      ],
                    )
                  ),
                  //actual list
                  Container(
                    height: 180.0,
                    padding: EdgeInsets.fromLTRB(0, 5.0, 0, 2.0),
                    child: StreamBuilder(
                      stream: Firestore.instance.collection('users').document(widget.uid).snapshots(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return Text("loading...");
                        }
                        List chores=snapshot.data["Chores"];
                        return new ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: chores.length,
                          itemBuilder: (context, index){
                            String desc=cv.getJobFromDescription(chores[index]);
                            String date=cv.getDateFromDescription(chores[index]);
                            int points=cv.getPointFromDescription(chores[index]);

                            return ListTile(
                              title: Text(
                                desc,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                                )
                              ),
                              trailing: Text(
                                date,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 20
                                )
                              ),
                            );
                          }
                        );
                      }
                    )
                  )
                ],
              )
            ),
            //bills container
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(15, 15, 0, 60),
              margin: EdgeInsets.fromLTRB(25, 10, 30, 0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFB3B9FA), Color(0xFF6D77E0)]
                ),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(25)
              ),
              child: Column(
                children: <Widget>[
                  //bills title
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Bills',
                      style: TextStyle(
                        color: Color(0xFFF2F2F2),
                        fontSize: 35,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold
                      )
                    )
                  ),
                  //values
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 15.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            FlatButton(
                              onPressed:(){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      //the BillList class is defined at the bottom of this doc
                                      content: BillList(),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(25.0)
                                      ),
                                    );
                                  }
                                );
                              },
                              child: StreamBuilder(
                                stream: Firestore.instance.collection('users').document(widget.uid).snapshots(),
                                builder: (context, snapshot) {
                                  if(!snapshot.hasData){
                                      return Text("Loading...");
                                  }
                                  return Text(
                                    '\$'+snapshot.data['Budget'].toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 45,
                                      color: Color(0xFFF2F2F2),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600
                                    )
                                  );
                                }
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        FlatButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                    
                                    content: BillsExpansion(),
                                  
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: new BorderRadius.circular(25.0)
                                  // ),
                                );
                              }
                            );
                          },
                          child: Icon(
                            Icons.add,
                            size: 50,
                            color: Color(0xFF7E86DF)
                          ),
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Color(0xB3FFFFFF),
                              width: 2.0,
                            )
                          ),
                          color: Color(0xB3FFFFFF),
                        )
                      ],
                    )
                  )
                ],
              )
            )
          ],
        )
      )
    );
  }  
}

class BillList extends StatefulWidget{
  @override
  _BillListState createState() => _BillListState();
}


class _BillListState extends State<BillList>{
  final List<String> items = List<String>.generate(100, (i) => "Item $i");
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: <Widget>[
          //To Do title
          Container(
            alignment: Alignment.centerLeft,
            child: Text('Bills',
              style: TextStyle(
                color: Color(0xFF6D77E0),
                fontSize: 40,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold
              )
            )
          ),
          //actual list
          Container(
            height: 600.0,
            padding: EdgeInsets.only(top: 2.0),
            child: new ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(
                    //this should be the bill amount
                    '${items[index]}',
                    style: TextStyle(
                      color: Color(0xFF6D77E0),
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    )
                  ),
                  trailing: Text(
                    '04/20/20',
                    style: TextStyle(
                      color: Color(0xFF6D77E0),
                      fontFamily: 'Roboto',
                      fontSize: 20
                    )
                  ),
                );
              }
            )
          )
        ],
      )
    );
  }
}
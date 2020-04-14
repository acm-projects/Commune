import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/Models/User.dart';
import 'package:commune_spring_2020/Pages/bill_expansion.dart';
import 'package:commune_spring_2020/Pages/listofbills.dart';
import 'package:commune_spring_2020/Pages/user_profile.dart';
import 'package:commune_spring_2020/screens/auth/AccountAccess.dart';
import 'package:commune_spring_2020/services/budgetServices.dart';
import 'package:commune_spring_2020/services/choresServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'chore_expansion.dart';

class Homescreen extends StatefulWidget {
  final String uid;
  String hhname;
  Homescreen({this.uid});
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  AuthService _auth = new AuthService();
  final List<String> items = List<String>.generate(100, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    choresServices cv = new choresServices();

    final screenSize = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFFFF), Color(0xFFFBF4F5)]
          ),
        ),
        child: SingleChildScrollView(
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

                              return Dismissible(
                                  child: ListTile(
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
                                ), 
                                key: null,
                                direction: DismissDirection.horizontal,
                                onDismissed: (direction) {
                                    setState2(() {
                                      items.removeAt(index);
                                    });
                                },
                                background: slideBackground()
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
                margin: EdgeInsets.fromLTRB(25, 10, 30, 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFB3B9FA), Color(0xFF6D77E0)]
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(25),
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
              ),
              //sign out button
              RaisedButton(
                  child: Text("sign out"),
                  onPressed: ()async{
                    await _auth.signOut();
                  }
                ),
            ],
          ),
        )
      )
    );
  }  
}

class BillList extends StatefulWidget {
  final String uid;
  BillList({this.uid});
  @override
  _BillListState createState() => _BillListState();
}

class _BillListState extends State<BillList> {
  final List<String> items = List<String>.generate(100, (i) => "Item $i");
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 700,
      child: Scaffold(
          body: Column(
        children: <Widget>[
          //To Do title
          Container(
            height: 40,
              alignment: Alignment.centerLeft,
              child: Text('Bills',
                  style: TextStyle(
                      color: Color(0xFF6D77E0),
                      fontSize: 40,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold))),
          //actual list
          Container(
            height: 600,
            child: StreamBuilder(
              stream: Firestore.instance.collection('users').document(widget.uid).snapshots(),
              builder: (context, snapshot) {
                budgetServices bs= budgetServices();
                if(!snapshot.hasData){
                  return Text("loading...");
                }
                List bills=snapshot.data["Budget Changes"];
                return Container(
                    height: 500.0,
                    padding: EdgeInsets.only(top: 2.0),
                    child: new ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: bills.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 60,
                            child: ListTile(
                              title: Text(
                                  //this should be the bill amount
                                  bs.getAmountFromDescription(bills[index]).toString(),
                                  style: TextStyle(
                                      color: Color(0xFF6D77E0),
                                      fontFamily: 'Roboto',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              trailing: Text(
                                bs.getDateFromDescription(bills[index]),
                                  style: TextStyle(
                                      color: Color(0xFF6D77E0),
                                      fontFamily: 'Roboto',
                                      fontSize: 20)),
                            ),
                          );
                        }));
              }
            ),
          )
        ],
      )),
    );
  }
}

void setState2(Null Function() param0) {}

Widget slideBackground(){
  return Container(
    color: Colors.white,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Color(0xFF582D8F),
          ),
          Text(
            "30 points",
            style: TextStyle(
              color: Color(0xFF582D8F),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}

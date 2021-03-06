import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/screens/Home_Files/choresPage.dart';
import 'package:commune_spring_2020/screens/Home_Files/budget.dart';
import 'package:commune_spring_2020/screens/auth/AccountAccess.dart';
import 'package:commune_spring_2020/screens/auth/register.dart';
import 'package:commune_spring_2020/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String uid;
  bool showSignIn=true;

  Home({this.uid});
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = new AuthService();

  final String uid;
  _HomeState({this.uid});

  String householdName;

  @override
  Widget build(BuildContext context) {
    
    // print(householdName+"&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          RaisedButton(
            color: Colors.blue[100],
            onPressed: () async {
              await _auth.signOut();
            },
            child: Text("Logout"),
          ),
          StreamBuilder(
            stream: Firestore.instance.collection('users').document(widget.uid).snapshots(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Text("loading...");
              }
              householdName=snapshot.data['HouseHoldName'];
              return RaisedButton(
                color: Colors.blue[100],
                child: Text("Chores"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChoresPage(uid: widget.uid,householdName: householdName,)),
                  );
                },
              );
            }
          ),
          RaisedButton(
            color: Colors.blue[200],
            child: Text("Budget"),
            onPressed: () {
              
            },
          ),
          RaisedButton(
            color: Colors.blue[100],
            child: Text("Household"),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.blue[600],
      ),
      body: Column(
        children: <Widget>[
          Budget(
            uid: widget.uid, hhname: 'bruh',
          ),
        ],
      ),
    );
  }

  void updateUserHousehold(String userID) async {
    var db= Firestore.instance;
    var userDoc = db.collection('users').document(userID);
    await userDoc.get().then((doc){
      householdName= doc['HouseHoldName'];
    }); 
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class householdInfo extends StatefulWidget {
  final String houseName;
  householdInfo({this.houseName});

  @override
  _householdInfoState createState() => _householdInfoState(householdName: houseName);
}

class _householdInfoState extends State<householdInfo> {
  final String householdName;
  _householdInfoState({this.householdName});

  
  @override
  Widget build(BuildContext context) {
     return Padding(
        padding: EdgeInsets.fromLTRB(0,30,0,0),
        child: new StreamBuilder(
        stream: Firestore.instance.collection('HouseHoldGroups').document(householdName).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          List list = userDocument["Group Users"];
            return ListView.builder(
            itemCount: list.length,
            itemBuilder:(context,index) {
              Future<String> newString = getUserName(list[index]);
              return new FutureBuilder(
              future: getUserName(list[index]),
              initialData: "Loading text..",
              builder: (BuildContext context, AsyncSnapshot<String> text) {
              return new Text(text.data);
              }
              );
            }
          ); 
        }
      ),
     );
  }

  Future<String> getUserName(var currentUID) async {
    String  _currentUserLastName, _currentUserFirstName;
    var db= Firestore.instance;
    var userDoc = db.collection('users').document(currentUID);
    await userDoc.get().then((doc){
      _currentUserFirstName=doc['First Name'];
      _currentUserLastName=doc['Last Name'];
    });

    return _currentUserFirstName+" "+_currentUserLastName;
  }
}
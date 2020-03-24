
import 'package:commune_spring_2020/Home/Household_info.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/Home/user_info.dart';

class Home extends StatefulWidget {
  final String userUid;
  final String houseName;
  Home({this.userUid,this.houseName});

  @override
  _HomeState createState() => _HomeState(uid: userUid,houseName: houseName);
}

class _HomeState extends State<Home> {
  final String uid;
  final String houseName;
  _HomeState({this.uid,this.houseName});

  
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
       ),
       body: Stack(
        children: <Widget>[
        Text("Users In the Group "+houseName+": "),
        householdInfo(houseName:houseName),
        UserInfoForDisplay(uid:uid),
        new Padding(
        padding: EdgeInsets.fromLTRB(0,120,0,0),
        child: RaisedButton(
           onPressed: _showBoxForAddingChore,
           child: Text("Add"),
         ),
        ),
        ]
       ),
      );
  }

  void _showBoxForAddingChore()
  {
    String chore="";
    showDialog(
      context: context,
      builder:(BuildContext context){
        return Scaffold(
          body:Column(
            children: <Widget>[
            new TextField(
                onChanged: ((val){
                  chore=val;
                }),
            ),
            new FlatButton(
              child: new Text("Add"),
              onPressed:() {
                if(chore!=""){
                addChore(chore);
                }
                Navigator.of(context).pop();
              },
             ),
            ]
          )
        );
      }
    );
    }

    void addChore(String choreName){
      var choreArray = Firestore.instance.collection("users").document(uid);
      choreArray.updateData({
        'Chores': FieldValue.arrayUnion([choreName]),
      });
    }

    
}

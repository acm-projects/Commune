
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:commune_spring_2020/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/Home/user_info.dart';

class Home extends StatefulWidget {
  final String userUid;
  Home({this.userUid});

  @override
  _HomeState createState() => _HomeState(uid: userUid);
}

class _HomeState extends State<Home> {
  final String uid;
  _HomeState({this.uid});

  
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
       ),
       body: Stack(
        children: <Widget>[
        UserInfoForDisplay(uid:uid),
        RaisedButton(
           onPressed: _showBoxForAddingChore,
           child: Text("Add"),
         ),
        ]
       ),
      );
  }

  void yo(){

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

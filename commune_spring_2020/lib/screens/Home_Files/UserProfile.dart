import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class UserProfile extends StatefulWidget {
  final String uid;
  UserProfile({this.uid});

  @override
  _UserProfileState createState() => _UserProfileState(uid: uid);
}

class _UserProfileState extends State<UserProfile> {

  final String uid;
  _UserProfileState({this.uid});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
  
=======
    return Scaffold(
       body: Column(children: <Widget>[
        new StreamBuilder (
        stream: Firestore.instance.collection("users").document(uid).snapshots(),
        builder: (context, snapshot) {
          return Container(
                child: new StreamBuilder(
                stream: Firestore.instance.collection("users").document(uid).snapshots(),
                 builder: (context, snapshot) {
                   if(!snapshot.hasData){
                     return Text("loading");
                   }
                   return Text(
                     snapshot.data["First Name"]+" "+snapshot.data["Last Name"],
                     style: TextStyle(
                      // color: Colors.white,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Raleway'
                     ),
                   );
                 }
               ),
            );
         }
      )
       ]),
    );
      
  /*
   StreamBuilder(
                    stream: Firestore.instance.collection("users").document(admin).snapshots(),
                    builder: (context, snapshot) {
                      return Container(
  */
  /*
  child: StreamBuilder(
                stream: Firestore.instance.collection("users").document(uid).snapshots(),
                builder: (context, snapshot) {
                     String name= snapshot.data["First Name"];
                     return Text(
                        name+" "+snapshot.data["Last Name"],
                        //style: TextStyle(
                        //color: Colors.white,
                        //fontSize: 10.0,
                        //fontWeight: FontWeight.w100,
                        //fontFamily: 'Raleway'),
                       );
                  }
            ),
            */
>>>>>>> f857baf0988b5e5337d5e7fc4988091647d1206c
    return StreamBuilder (
        stream: Firestore.instance.collection("users").document(uid).snapshots(),
        builder: (context, snapshot) {
          return Container(
                child: StreamBuilder(
                stream: Firestore.instance.collection("users").document(uid).snapshots(),
                builder: (context, snapshot) {
                   return Scaffold(
                     appBar: new AppBar(
                       title: Text('User Profile'),
                     ),
                     body:Column(children: <Widget>[
                       Text(
                       snapshot.data["First Name"]+" "+snapshot.data["Last Name"],
                       style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Raleway'),
                      ),
                      Text(
                      snapshot.data["Email"],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Raleway'),
                      ),
                     ]
                    )
                  );
                 }
               ),
            );
         }
      );
  }



}
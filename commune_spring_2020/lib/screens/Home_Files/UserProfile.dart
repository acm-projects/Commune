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
    return StreamBuilder (
        stream: Firestore.instance.collection("users").document(uid).snapshots(),
        builder: (context, snapshot) {
          return Container(
                child: StreamBuilder(
                stream: Firestore.instance.collection("users").document(uid).snapshots(),
                 builder: (context, snapshot) {
                   return Text(
                     snapshot.data["First Name"]+" "+snapshot.data["Last Name"],
                     //style: TextStyle(
                     //color: Colors.white,
                     //fontSize: 10.0,
                     //fontWeight: FontWeight.w100,
                     //fontFamily: 'Raleway'),
                   );
                 }
               ),
            );
         }
      );
  }



}
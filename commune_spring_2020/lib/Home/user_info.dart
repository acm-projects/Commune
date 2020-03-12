
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoForDisplay extends StatefulWidget {
  final String uid;
  UserInfoForDisplay({this.uid});

  @override
  _UserInfoForDisplayState createState() => _UserInfoForDisplayState(uid:uid);
}

class _UserInfoForDisplayState extends State<UserInfoForDisplay> {
   final String uid;

   _UserInfoForDisplayState({this.uid});

  @override
  Widget build(BuildContext context) {
     return Padding(
        padding: EdgeInsets.fromLTRB(0,50,0,0),
        child: new StreamBuilder(
        stream: Firestore.instance.collection('users').document(uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          List list = userDocument["Chores"];
            return ListView.builder(
            itemCount: list.length,
            itemBuilder:(context,index){
              return new Dismissible(
                key: new Key(list[index]),
                onDismissed: (direction){
                  deleteChore(list[index]);
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text("Deleted Chore"),
                    ));
                  },
                  background: new Container(
                    color: Colors.red,
                  ),
                  child: new ListTile(
                    title: new Text(list[index]),
                  ),
                );
            }
            
          ); 
        }
    ),
     );
  }

  
  void deleteChore(String index){
      print(index);
      var choreArray = Firestore.instance.collection("users").document(uid);
      choreArray.updateData({
        'Chores': FieldValue.arrayRemove([index]),
      });
    }
  

}
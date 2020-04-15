import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/screens/auth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:commune_spring_2020/screens/Home_Files/home.dart';

class HouseHoldJoinPage extends StatefulWidget {
  @override
   final String uid;
  HouseHoldJoinPage({this.uid});
  _HouseHoldJoinPageState createState() => _HouseHoldJoinPageState(uid: uid);
}

class _HouseHoldJoinPageState extends State<HouseHoldJoinPage> {
  final String uid;
  _HouseHoldJoinPageState({this.uid});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _houseName, _housePassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Join Household'),
      ),

      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input){
                  if(input.isEmpty){
                    return 'Type in a House name';
                  }
                },
              onSaved: (input) => _houseName = input,
                decoration: InputDecoration(
                  labelText: 'House Name'
                ),
            ),
            TextFormField(
              validator: (input){
                  if(input.isEmpty){
                    return 'Type in a password';
                  }
                },
              onSaved: (input) => _housePassword = input,
                decoration: InputDecoration(
                  labelText: 'Password'
                ),
                 obscureText: true,
            ),
             RaisedButton(
                onPressed: loginInToHouse,
                child: Text('Login'),
              ),
          ],
        )
      ),
    );
  }
  

  Future<void> loginInToHouse() async {
    if(_formKey.currentState.validate())
    {
      _formKey.currentState.save();

      var db= Firestore.instance;
      var houseDoc = db.collection('HouseHoldGroups').document(_houseName);

      houseDoc.get().then((DocumentSnapshot)=>
      {
        if(DocumentSnapshot.exists)
        {
          houseDoc.get().then((doc) async {
            if(_housePassword==doc['Password'])
            {
              FirebaseUser user= (await FirebaseAuth.instance.currentUser());
              updateUserHouseAndUserArray(user.uid);

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(uid: user.uid)));
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignIn()));
            }
            else
            {
              _showDialogForHouseHoldWrongPassword();
            }
          }),
        } 
        else
        {
          _showDialogForNotExistingHouseHold()
        }
      });
    }
  }

  void updateUserHouseAndUserArray(var uid){
    var houseNameVaulue =  Firestore.instance.collection("users").document(uid);
      houseNameVaulue.updateData({
        'HouseHoldName': _houseName
      });

    var houseArrayAddition =  Firestore.instance.collection("HouseHoldGroups").document(_houseName);
      houseArrayAddition.updateData({
        'Group Users':  FieldValue.arrayUnion([uid]),
      });
  }

  void _showDialogForNotExistingHouseHold()
  {
    showDialog(
      context: context,
      builder:(BuildContext context){
        return AlertDialog(
          title: new Text("House Hold Group Does Not Exist"),
          content: new Text(_houseName+" is not a created group. Try Again."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed:() {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogForHouseHoldWrongPassword()
  {
    showDialog(
      context: context,
      builder:(BuildContext context){
        return AlertDialog(
          title: new Text("Wrong Password"),
          content: new Text("Wrong Password for this group. Try Again."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed:() {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
import 'package:commune_spring_2020/screens/Home_Files/home.dart';
import 'package:commune_spring_2020/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:commune_spring_2020/services/database.dart';

class HouseHoldCreation extends StatefulWidget {
  @override
  _HouseHoldCreationState createState() => _HouseHoldCreationState();
}

class _HouseHoldCreationState extends State<HouseHoldCreation> {
  final GlobalKey<FormState> _formKeyy = GlobalKey<FormState>();

  String _admin, _password, _householdName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Create Household'),
      ),

      body: Form(
        key: _formKeyy,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input){
                  if(input.isEmpty){
                    return 'Type in a House name';
                  }
                },
              onSaved: (input) => _householdName = input,
                decoration: InputDecoration(
                  labelText: 'House Name'
                ),
            ),
            TextFormField(
              validator: (input){
                  if(input.isEmpty){
                    return 'Type in a password';
                  }
                  if(input.length<6){
                    return 'Create a password longer than 5 characters';
                  }
                },
              onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  labelText: 'Password'
                ),
                 obscureText: true,
            ),
             RaisedButton(
                onPressed: loginInToHouse,
                child: Text('Create Household'),
              ),
          ],
        )
      ),
    );
  }

  Future<void> loginInToHouse() async {
    if(_formKeyy.currentState.validate())
    {
      _formKeyy.currentState.save();
      FirebaseUser user= (await FirebaseAuth.instance.currentUser());

      //DatabaseService(uid: user.uid).updateHouseHoldData(_password,_householdName);
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(uid: user.uid)));
    }
  }
}


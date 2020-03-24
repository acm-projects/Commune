import 'package:commune_spring_2020/Home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:commune_spring_2020/Services/database.dart';

class HouseHoldCreation extends StatefulWidget {
  @override
  _HouseHoldCreationState createState() => _HouseHoldCreationState();
}

class _HouseHoldCreationState extends State<HouseHoldCreation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _admin, _password, _householdName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Create Household'),
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
    if(_formKey.currentState.validate())
    {
      _formKey.currentState.save();
      FirebaseUser user= (await FirebaseAuth.instance.currentUser());

      DatabaseService(uid: user.uid).updateHouseHoldData(_password,_householdName);

      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(userUid: user.uid,houseName: _householdName)));
    }
  }
}
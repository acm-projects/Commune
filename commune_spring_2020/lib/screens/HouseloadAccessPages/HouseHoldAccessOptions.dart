import 'package:commune_spring_2020/screens/HouseloadAccessPages/HouseHoldCreatePage.dart';
import 'package:commune_spring_2020/screens/HouseloadAccessPages/HouseHoldJoinPage.dart';
import 'package:flutter/material.dart';

class HouseHoldSelectionPage extends StatefulWidget {
  @override
  _HouseHoldSelectionPageState createState() => _HouseHoldSelectionPageState();
}

class _HouseHoldSelectionPageState extends State<HouseHoldSelectionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Household Options'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: switchPageToJoinPage,
            child: Text("Join Existing House")
            ),
          RaisedButton(
            onPressed: switchPageToSignUpPage,
            child: Text("Create A House")
          ),
        ],
      )
    );
  }

  void switchPageToJoinPage()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HouseHoldJoinPage()));
  }
  void switchPageToSignUpPage()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HouseHoldCreation()));
  }
}
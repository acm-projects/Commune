import 'package:commune_spring_2020/screens/home/choresPage.dart';
import 'package:commune_spring_2020/screens/home/users.dart';
import 'package:commune_spring_2020/services/auth2.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String uid;
  Home({this.uid});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = new AuthService();
  final String uid;
  _HomeState({this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          RaisedButton(
            color: Colors.blue[100],
            onPressed: () async {
              await _auth.signOut();
            },
            child: Text("Logout"),
          ),
          RaisedButton(
            color: Colors.blue[100],
            child: Text("Chores"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChoresPage(uid: widget.uid)),
              );
            },
          ),
          RaisedButton(
            color: Colors.blue[100],
            child: Text("Budget"),
            onPressed: () {
              
            },
          ),
          RaisedButton(
            color: Colors.blue[100],
            child: Text("Household"),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.blue[600],
      ),
      body: Column(
        children: <Widget>[
          UsersList(
            uid: widget.uid,
          ),
        ],
      ),
    );
  }
}

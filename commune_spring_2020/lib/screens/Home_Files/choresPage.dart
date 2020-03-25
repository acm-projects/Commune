import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChoresPage extends StatefulWidget {
  final String uid, householdName;
  ChoresPage({this.uid, this.householdName});
  @override
  _ChoresPageState createState() => _ChoresPageState();
}

class _ChoresPageState extends State<ChoresPage> {
  DateTime _now = DateTime.now();
  var _datePicked;
  String desc = '';
  String name;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: 500,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            //row that contains the widgets needed to add a chore
            Form(
              child: Column(children: <Widget>[
                // Text(DateTime.now().toString()),
                //enter desctiption
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter a descitption of the chore",
                  ),
                  onChanged: (s) {
                    desc = s;
                  },
                ),
                //enter date due
                new RaisedButton(
                  child: Text("pick deadline"),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2018),
                            lastDate: DateTime(2100))
                        .then((date) {
                      setState(() {
                        _datePicked = date;
                      });
                    });
                    print(_datePicked.getDate.toString());
                  },
                ),

                new Text(_datePicked == null
                    ? 'please pick a deadline'
                    : 'date picked:' + _datePicked.toString()),
                StreamBuilder(
                    //pass in non hardcoded uid for doc
                    stream: Firestore.instance
                        .collection('households')
                        .document('ZuAK8FRY60wiZm0CdvpA')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return new Text("loading data..");
                      } else {
                        var userDoc = snapshot.data;
                        List roomMatesList = userDoc['roomMates'];
                        if (roomMatesList.length == 0) {
                          return Text("No roomates available");
                        }
                        return SizedBox(
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: roomMatesList.length,
                            itemBuilder: (context, index) {
                              String id = roomMatesList[index];
                              
                             //var OneRoomMate = Firestore.instance
                             //    .collection('users')
                             //    .document(id)
                             //    .get()
                             //    .then((v) {
                             //      // setState(() {
                             //      //   name=name = v.data['Display Name'];
                             //      // }); 
                             //});
                              print("name: "+name.toString());
                              return new RaisedButton(
                                child: Text("user "+ name.toString()),
                                onPressed: () {
                                  // print(name);
                                },
                              );
                            },
                          ),
                        );
                      }
                    }),
              ]),
            ),

            //column of chores to do
            StreamBuilder(
              stream: Firestore.instance
                  .collection('HouseHoldGroups')
                  .document(widget.householdName)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('loading...');
                } else {
                  return Column(children: <Widget>[
                    Column(
                      children: <Widget>[],
                    ),
                    //completed chores
                    Column(
                      children: <Widget>[],
                    ),
                  ]);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

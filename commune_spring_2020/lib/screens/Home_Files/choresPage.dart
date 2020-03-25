import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChoresPage extends StatefulWidget {
  final String uid, householdName = 'bruh';
  ChoresPage({
    this.uid,
    // this.householdName
  });
  @override
  _ChoresPageState createState() => _ChoresPageState();
}

class _ChoresPageState extends State<ChoresPage> {
  var dateFormatter = new DateFormat('MMMM');
  DateTime _now = DateTime.now();
  var _datePicked;
  String desc = '';
  String choreDescription = '';
  String name;
  int pointVal;
  @override
  Widget build(BuildContext context) {
    print(widget.householdName + "***********************'");
    return new Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        height: 600,
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
                        _datePicked = (dateFormatter.format(date)) +
                            " " +
                            (new DateFormat('d').format(date)) +
                            ", " +
                            (new DateFormat('y').format(date));
                      });
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'How many points?'),
                  onChanged: (val) {
                    pointVal = int.parse(val);
                  },
                ),
                RaisedButton(
                    child: Text("Assign Chore"),
                    onPressed: () {
                      choreDescription = pointVal.toString() +
                          "&#" +
                          desc +
                          "&#" +
                          _datePicked.toString();
                      addChore(choreDescription);
                    }),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: StreamBuilder(
                      stream: Firestore.instance
                          .collection('HouseHoldGroups')
                          .document(widget.householdName)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text("loading");
                        } else {
                          List choresList = snapshot.data['Chores'];
                          return ListView.builder(
                              itemCount: choresList.length,
                              itemBuilder: (context, index) {
                                return new Dismissible(
                                  key: Key(choresList[index]),
                                  child: ListTile(
                                        title: Column(
                                          children: <Widget>[
                                            Text(getJobFromDescription(
                                                    choresList[index])
                                                .toString()),
                                            Text("Due: "+getDateFromDescription(choresList[index]))
                                          ],
                                        ),
                                      ),
                                  onDismissed: (direction) {
                                    removeChore(choresList[index]);
                                  },
                                  background: Text(
                                    getPointFromDescription(choresList[index])
                                            .toString() +
                                        "Points",
                                  ),
                                );
                              });
                        }
                      }),
                ),
                // StreamBuilder(
                // stream: Firestore.instance
                //     .collection('HouseHoldGroups')
                //     .document('bruh')
                //     .snapshots(),
                // builder: (context, snapshot) {
                //   if (!snapshot.hasData) {
                //     return new Text("loading data..");
                //   } else {
                //     print("*********************");
                //     var userDoc = snapshot.data;
                //     List roomMatesList = userDoc['roomMates'];
                //     if (roomMatesList.length == 0) {
                //       return Text("No roomates available");
                //     }
                //     return SizedBox(
                //       width: double.infinity,
                //       child: ListView.builder(
                //         shrinkWrap: true,
                //         itemCount: roomMatesList.length,
                //         itemBuilder: (context, index) {
                //           String id = roomMatesList[index];

                //          //var OneRoomMate = Firestore.instance
                //          //    .collection('users')
                //          //    .document(id)
                //          //    .get()
                //          //    .then((v) {
                //          //      // setState(() {
                //          //      //   name=name = v.data['Display Name'];
                //          //      // });
                //          //});
                //           print("name: "+name.toString());
                //           return new RaisedButton(
                //             child: Text("user "+ name.toString()),
                //             onPressed: () {
                //               // print(name);
                //             },
                //           );
                //         },
                //       ),
                //     );
                //   }
                // }),
              ]),
            ),

            //column of chores to do
            // StreamBuilder(
            //   stream: Firestore.instance
            //       .collection('HouseHoldGroups')
            //       .document(widget.householdName)
            //       .snapshots(),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) {
            //       return Text('loading...');
            //     } else {
            //       return Column(children: <Widget>[
            //         Column(
            //           children: <Widget>[],
            //         ),
            //         //completed chores
            //         Column(
            //           children: <Widget>[],
            //         ),
            //       ]);
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  void addChore(String choreDescription) {
    var ChoresArray = Firestore.instance
        .collection("HouseHoldGroups")
        .document(widget.householdName);
    ChoresArray.updateData({
      'Chores': FieldValue.arrayUnion([choreDescription]),
    });
  }

  void removeChore(String chore) {
    var choresArray = Firestore.instance
        .collection('HouseHoldGroups')
        .document(widget.householdName);
    choresArray.updateData({
      'Chores': FieldValue.arrayRemove([chore])
    });
  }

  int getPointFromDescription(String d) {
    String stringAmt = '';
    for (int i = 0; i < d.length - 1; i++) {
      if ((d[i] == '&') && (d[i + 1] == '#')) {
        stringAmt = d.substring(0, i);
        break;
      }
    }
    return int.parse(stringAmt);
  }

  String getJobFromDescription(d) {
    int firstCheckPoint = 0;
    int secondCheckPoint = 0;
    int counter = 0;
    for (int i = 0; i < d.length - 1; i++) {
      if (counter == 0 && (d[i] == '&') && (d[i + 1] == '#')) {
        counter++;
        firstCheckPoint = i;
      }
      if (counter == 1 && ((d[i] == '&') && (d[i + 1] == '#'))) {
        secondCheckPoint = i;
      }
    }
    return d.substring(firstCheckPoint + 2, secondCheckPoint);
  }

  String getDateFromDescription(String d) {
    String date = '';
    int firstCheckPoint = 0;
    int counter = 0;
    for (int i = 0; i < d.length; i++) {
      if ((d[i] == '&') && (d[i + 1] == '#')) {
        counter++;
        firstCheckPoint = i;
      }
      if (counter == 2) {
        return d.substring(firstCheckPoint + 2);
      }
    }
    return date;
  }
}

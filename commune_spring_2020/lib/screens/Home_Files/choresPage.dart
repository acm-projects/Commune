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
    //check if the user is the admin
    bool isAdmin = false;
    if (Firestore.instance
            .collection('HouseHoldGroups')
            .document(widget.householdName)
            .get()
            .then((doc) {
          doc.data['Admin'];
        }).toString() ==
        widget.uid) {
      isAdmin = true;
    }
    return new Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        height: 600,
        child: Column(
          children: <Widget>[
            Column(children: <Widget>[
              //colunmn that contains the widgets needed to add a chore
              StreamBuilder(
                  stream: Firestore.instance
                      .collection('HouseHoldGroups')
                      .document(widget.householdName)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("loading...");
                    }
                    var userDoc = snapshot.data;
                    String adminId = userDoc.data['Admin'];
                    if (widget.uid == adminId) {
                      isAdmin = true;
                    }

                    return Visibility(
                      visible: isAdmin,
                      child: Form(
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
                          decoration:
                              InputDecoration(labelText: 'How many points?'),
                          onChanged: (val) {
                            pointVal = int.parse(val);
                          },
                        ),
                        //box that contains the button to assign a chore to a user in the household
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('HouseHoldGroups')
                                  .document(widget.householdName)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text("Loading...");
                                } else {
                                  List listOfRoomates =
                                      snapshot.data["Group Users"];
                                  return ListView.builder(
                                      itemCount: listOfRoomates.length,
                                      itemBuilder: (context, index) {
                                        return StreamBuilder(
                                            stream: Firestore.instance
                                                .collection('users')
                                                .document(listOfRoomates[index])
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              var userdoc = snapshot.data;
                                              return new RaisedButton(
                                                  //name of users
                                                  child: Text("Assign to: " +
                                                      userdoc['First Name']),
                                                  onPressed: () {
                                                    if (_datePicked != null) {
                                                      choreDescription =
                                                          pointVal.toString() +
                                                              "&#" +
                                                              desc +
                                                              "&#" +
                                                              _datePicked
                                                                  .toString();
                                                      addChoreToHouseHold(
                                                          choreDescription);
                                                      addChoreToUser(
                                                          choreDescription);
                                                    }
                                                    _datePicked = null;
                                                  });
                                            });
                                      });
                                }
                              }),
                        ),
                      ])),
                    );
                  }),
              //show list of user's chores
              Text("My chores:"),
              SizedBox(
                height: 100,
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('users')
                        .document(widget.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      List userChores = snapshot.data['Chores'];
                      if (userChores.length == 0) {
                        return Text('No Chores assigned to you');
                      }
                      return ListView.builder(
                        itemCount: userChores.length,
                        itemBuilder: (context, index) {
                          if (userChores.length == 0) {
                            return null;
                          }
                          return new Dismissible(
                            key: Key(userChores[index]),
                            child: ListTile(
                              title: Column(
                                children: <Widget>[
                                  Text(getJobFromDescription(userChores[index])
                                      .toString()),
                                  Text("Due: " +
                                      getDateFromDescription(userChores[index]))
                                ],
                              ),
                            ),
                            onDismissed: (direction) {
                              updateScore(
                                  getPointFromDescription(userChores[index]));
                              removeChore(userChores[index]);
                              removeChoreFromUser(userChores[index]);
                            },
                            background: DecoratedBox(
                              decoration:
                                  const BoxDecoration(color: Colors.blue),
                              child: Text(
                                getPointFromDescription(userChores[index])
                                        .toString() +
                                    "Points",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
              Divider(
                color: Colors.blue[900],
              ),
              //show list of chores in the household
              Text("Household Chores:"),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('HouseHoldGroups')
                        .document(widget.householdName)
                        .snapshots(),
                    builder: (context, snapshot) {
                      print(isAdmin);
                      if (!snapshot.hasData) {
                        return Text("loading");
                      } else {
                        List choresList = snapshot.data['Chores'];
                        if(choresList.length==0){
                          return Text('No household chores');
                        }
                        return ListView.builder(
                            itemCount: choresList.length,
                            itemBuilder: (context, index) {
                              return new ListTile(
                                // key: Key(choresList[index]),
                                // child: ListTile(
                                title: Column(
                                  children: <Widget>[
                                    Text(
                                        getJobFromDescription(choresList[index])
                                            .toString()),
                                    Text("Due: " +
                                        getDateFromDescription(
                                            choresList[index]))
                                  ],
                                ),
                              );
                            });
                      }
                    }),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  void addChoreToHouseHold(String choreDescription) {
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

  void removeChoreFromUser(String chore) {
    var choresArray = Firestore.instance
        .collection('users')
        .document(widget.uid);
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

  void updateScore(
    int pts,
  ) {
    int currentScore = 0;
    var userDoc = Firestore.instance
        .collection('users')
        .document(widget.uid)
        .get()
        .then((doc) {
      doc.data['Points'];
    });
    print(userDoc.toString());
    Firestore.instance
        .collection('users')
        .document(widget.uid)
        .updateData({'Points': currentScore + pts});
  }

  void addChoreToUser(String choreDescription) {
    var ChoresArray =
        Firestore.instance.collection("users").document(widget.uid);
    ChoresArray.updateData({
      'Chores': FieldValue.arrayUnion([choreDescription]),
    });
  }
}

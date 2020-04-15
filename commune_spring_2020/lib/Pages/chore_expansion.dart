import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/screens/Home_Files/choresPage.dart';
import 'package:commune_spring_2020/services/choresServices.dart';
import 'package:flutter/material.dart';
import 'package:commune_spring_2020/Pages/homescreen.dart';
import 'package:commune_spring_2020/Pages/homepage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/framework.dart';



class ChoreExpansion extends StatefulWidget {
  final String uid;
  String hhname;
  ChoreExpansion({this.uid});
  @override
  _ChoreExpansion createState() => _ChoreExpansion();
}

class _ChoreExpansion extends State<ChoreExpansion> {
  choresServices cv = new choresServices();
  String memo, choreDescription;
  int point;
  DateTime date;
  String dateString = (new DateFormat('MMMM').format(DateTime.now())) +
      " " +
      (new DateFormat('d').format(DateTime.now())) +
      ", " +
      (new DateFormat('y').format(DateTime.now()));
  Color buttonColor = Color.fromARGB(255, 27, 64, 121);

  List persons;
  bool checkBoxValue = false;
  int counter = 0;

  var _datePicked;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    return Material(
        child: Container(
      color: Color.fromARGB(255, 251, 244, 245),
      child: Column(
        children: <Widget>[
          Container(
              height: 0.04 * screenSize.size.height,
              color: Color.fromARGB(255, 251, 244, 245)),
          Container(
            height: 0.85 * screenSize.size.height,
            width: 0.95 * screenSize.size.width,
            child: Column(
              children: <Widget>[
                StreamBuilder(
                    stream: Firestore.instance
                        .collection('users')
                        .document(widget.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("loading...");
                      }
                      widget.hhname = snapshot.data["HouseHoldName"];
                      return StreamBuilder(
                          stream: Firestore.instance
                              .collection("HouseHoldGroups")
                              .document(widget.hhname)
                              .snapshots(),
                          builder: (context, snap) {
                            if (!snap.hasData) {
                              return Text("Loading");
                            }
                            persons = snap.data["Group Users"];
                            return Container(
                              height: 0.05 * screenSize.size.height,
                              width: 1.0 * screenSize.size.width,
                              color: Color.fromARGB(230, 174, 181, 255),
                              child: FittedBox(
                                child: Text(
                                  "Add a Chore",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 245, 229, 252),
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Raleway'),
                                ),
                              ),
                            );
                          });
                    }),
                Container(
                  height: 0.01 * screenSize.size.height,
                  color: Color.fromARGB(230, 174, 181, 255),
                ),
                Container(
                  height: 0.07 * screenSize.size.height,
                  //width: 0.8 * screenSize.size.width,
                  color: Color.fromARGB(230, 174, 181, 255),
                  child: TextFormField(
                      onChanged: (val) {
                        memo = val;
                      },
                      decoration: InputDecoration(
                          labelText: 'Memo',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: 0.005 * screenSize.size.height),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.blueGrey))),
                ),
                Container(
                  height: 0.04 * screenSize.size.height,
                  color: Color.fromARGB(230, 174, 181, 255),
                ),
                Container(
                  height: 0.13 * screenSize.size.height,
                  color: Color.fromARGB(230, 174, 181, 255),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Text(_datePicked == null
                            ? 'No Date Chosen Yet'
                            : _datePicked.toString()),
                        Container(
                          height: 0.1 * screenSize.size.height,
                          width: 0.30 * screenSize.size.width,
                          child: FittedBox(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2019),
                                              lastDate: DateTime(2021))
                                          .then((date) {
                                            _datePicked=
                                          _datePicked = (new DateFormat('MMMM')
                                                  .format(date)) +
                                              " " +
                                              (new DateFormat('d')
                                                  .format(date)) +
                                              ", " +
                                              (new DateFormat('y')
                                                  .format(date));
                                        
                                      });
                                    },
                                    child: FittedBox(
                                      child: Text(
                                        "Choose a Date",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Raleway',
                                          //fontSize: 17.0,
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                          color: Color.fromARGB(255, 159, 166, 248),
                          // shape: RoundedRectangleBorder(
                          // borderRadius: new BorderRadius.circular(12.0),
                          // side: BorderSide(color: Colors.white),
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 0.02 * screenSize.size.height,
                  color: Color.fromARGB(230, 174, 181, 255),
                ),
                Container(
                  height: 0.07 * screenSize.size.height,
                  color: Color.fromARGB(230, 174, 181, 255),
                  //width: 0.8 * screenSize.size.width,
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        point = int.parse(val);
                      },
                      decoration: InputDecoration(
                          labelText: 'Point Value (Numbers Only)',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: 0.005 * screenSize.size.height),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.blueGrey))),
                ),
                Container(
                  height: 0.02 * screenSize.size.height,
                  color: Color.fromARGB(230, 174, 181, 255),
                ),
                Container(
                    color: Color.fromARGB(230, 174, 181, 255),
                    height: 0.05 * screenSize.size.height,
                    //width: 0.95 * screenSize.size.width,

                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Text(
                          "Assign Chore to:",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Raleway'),
                        ),
                      ),
                    )),
                Container(
                  height: 0.31 * screenSize.size.height,
                  width: 1 * screenSize.size.width,
                  color: Color.fromARGB(255, 159, 166, 248),
                  child: Column(
                    children: [
                      StreamBuilder(
                          stream: Firestore.instance
                              .collection("HouseHoldGroups")
                              .document(widget.hhname)
                              .snapshots(),
                          builder: (context, snap) {
                            if (!snap.hasData) {
                              return Text("loading....");
                            }
                            return StreamBuilder(
                                stream: Firestore.instance
                                    .collection("HouseHoldGroups")
                                    .document(widget.hhname)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text("loading...");
                                  }
                                  List roomates = snapshot.data["Group Users"];
                                  return Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: roomates.length,
                                        itemBuilder: (context, index) {
                                          return StreamBuilder(
                                              stream: Firestore.instance
                                                  .collection("users")
                                                  .document(roomates[index])
                                                  .snapshots(),
                                              builder: (context, snap) {
                                                if (!snap.hasData) {
                                                  return null;
                                                }
                                                return new RaisedButton(
                                                  color: Color.fromARGB(
                                                      230, 174, 181, 255),
                                                  child: Text(
                                                    snap.data["First Name"],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Raleway',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24.0,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    String d=_datePicked.toString();
                                                    String des=createChoreDescription(
                                                        point,
                                                        memo,
                                                        d);
                                                    cv.addChoreToHouseHold(des, widget.hhname);
                                                    cv.addChoreToUser(des, widget.uid);
                                                  },
                                                );
                                              });
                                        }),
                                  );
                                });
                          }),
                    ],
                  ),
                ),
                Container(
                    height: 0.02 * screenSize.size.height,
                    width: 1 * screenSize.size.width,
                    color: Color.fromARGB(230, 174, 181, 255),
                    child: Container(
                      height: 0.05 * screenSize.size.height,
                      width: 0.35 * screenSize.size.width,
                      child: FlatButton(),
                    )),
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 0.03 * screenSize.size.height,
                    color: Color.fromARGB(230, 174, 181, 255)),
                borderRadius: BorderRadius.all(Radius.circular(9.0))),
          ),
          Container(
              height: 0.035 * screenSize.size.height,
              color: Color.fromARGB(255, 251, 244, 245)),
          Container(height: 0.075 * screenSize.size.height, color: Colors.blue),
        ],
      ),
    ));
  }

  String createChoreDescription(int points, String memo, String deadline) {
    /*
    e.g.
    1000&#dishes plzzzzz :(&#March 27, 2020
    */
    String desc = (points.toString() + "&#d" + memo + "&#d" + deadline);
    return desc;
  }
}

// void setState(Null Function() param0) {}

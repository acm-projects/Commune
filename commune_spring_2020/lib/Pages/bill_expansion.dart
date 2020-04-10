import 'package:commune_spring_2020/services/budgetServices.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/Pages/homescreen.dart';
import 'package:commune_spring_2020/Pages/homepage.dart';
import 'package:intl/intl.dart';

// im not sure how to read in the people organically and process that
// in addition right now the page only supports up to four people

class BillsExpansion extends StatefulWidget {
  final String uid;
  String hhname;
  BillsExpansion({this.uid});
  @override
  _BillsExpansionState createState() => _BillsExpansionState();
}

class _BillsExpansionState extends State<BillsExpansion> {
  budgetServices budgetService = new budgetServices();
  final formKey = GlobalKey<FormState>();
  String title;
  List<String> persons = ["olimjon", "olimjon", "olimjon", "olimjon"];

  String desc=" ";
  double budgetChange=0, original;
  bool add;
  String date=(new DateFormat('MMMM').format(DateTime.now())) +
        " " +
        (new DateFormat('d').format(DateTime.now())) +
        ", " +
        (new DateFormat('y').format(DateTime.now()));
  Color buttonColor = Color.fromARGB(255, 27, 64, 121);
  String budgetProfile;
  @override
  bool checkBoxValue = false;
  int counter = 0;
  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    return Material(
        child: Container(
            color: Color.fromARGB(255, 251, 244, 245),
            child: Column(
              children: <Widget>[
                Container(
                  height: 0.14 * screenSize.size.height,
                  color: Color.fromARGB(255, 251, 244, 245),
                ),
                Container(
                  height: 0.55 * screenSize.size.height,
                  width: 0.95 * screenSize.size.width,
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 0.05 * screenSize.size.height,
                          width: 0.95 * screenSize.size.width,
                          color: Color.fromARGB(230, 174, 181, 255),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FittedBox(
                                  child: StreamBuilder(
                                      stream: Firestore.instance
                                          .collection('users')
                                          .document(widget.uid)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Text("loading...");
                                        } else {
                                          widget.hhname =
                                              snapshot.data["HouseHoldName"];
                                          return StreamBuilder(
                                            stream: Firestore.instance.collection("HouseHoldGroups").document(widget.hhname).snapshots(),
                                            builder: (context, snapshot) {
                                              return StreamBuilder(
                                                stream: Firestore.instance.collection("HouseHoldGroups").document(widget.hhname).snapshots(),
                                                builder: (context, snap) {
                                                  if(!snap.hasData){
                                                    return Text("Loading...");
                                                  }
                                                  original=double.parse(snap.data["Budget"].toString());
                                                  return Text(
                                                    "Current Budget =\$ "+snap.data["Budget"].toStringAsFixed(2),
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 245, 229, 252),
                                                        fontSize: 24.0,
                                                        fontWeight: FontWeight.w400,
                                                        fontFamily: 'Raleway'),
                                                  );
                                                }
                                              );
                                            }
                                          );
                                        }
                                      }),
                                ),
                              ])),
                      Container(
                        height: 0.439 * screenSize.size.height,
                        width: 0.95 * screenSize.size.width,
                        color: Color.fromARGB(230, 174, 181, 255),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.zero)),
                          color: Color.fromARGB(230, 174, 181, 255),
                          elevation: 0,
                          margin: EdgeInsets.all(0.0),
                          child: Form(
                              child: Column(children: <Widget>[
                            Container(
                              height: 0.1 * screenSize.size.height,
                              width: 0.8 * screenSize.size.width,
                              child: TextFormField(
                                  onChanged: (val) {
                                    desc = val;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Memo',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white,
                                            width:
                                                0.005 * screenSize.size.height),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                      border: OutlineInputBorder(),
                                      labelStyle:
                                          TextStyle(color: Colors.blueGrey))),
                            ),

                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0, 0, 0, 0.02 * screenSize.size.height)),

                            Container(
                              height: 0.1 * screenSize.size.height,
                              width: 0.8 * screenSize.size.width,
                              child: TextFormField(
                                  onChanged: (val) {
                                    print("hello" +
                                        desc +
                                        "\n" +
                                        original.toString() +
                                        "\n" +
                                        budgetChange.toString() +
                                        "\n");

                                    budgetChange = double.parse(val);
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Bill Amount',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white,
                                            width:
                                                0.005 * screenSize.size.height),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                      border: OutlineInputBorder(),
                                      labelStyle:
                                          TextStyle(color: Colors.blueGrey))),
                            ),

                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0, 0, 0, 0.02 * screenSize.size.height)),

                            Container(
                              height: 0.1 * screenSize.size.height,
                              width: 0.8 * screenSize.size.width,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        budgetProfile=createDescription(desc,budgetChange, date);
                                        addBudgetChangeDescription(budgetProfile);
                                        changeBudget(original, budgetChange);
                                      },
                                      child: FittedBox(
                                        child: Text(
                                          "Plus",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Raleway',
                                            fontSize: 17.0,
                                          ),
                                        ),
                                      ),
                                      color: Color.fromARGB(255, 27, 64, 121),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(12.0),
                                        side: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        budgetChange=budgetChange*(-1);
                                        budgetProfile=createDescription(desc,budgetChange, date);
                                        addBudgetChangeDescription(budgetProfile);
                                        changeBudget(original, budgetChange);
                                      },
                                      child: FittedBox(
                                        child: Text(
                                          "Minus",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Raleway',
                                            //fontSize: 17.0,
                                          ),
                                        ),
                                      ),
                                      color: Color.fromARGB(255, 27, 64, 121),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(12.0),
                                        side: BorderSide(color: Colors.white),
                                      ),
                                    )
                                  ]),
                            ),
                          ])),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.05 * screenSize.size.width,
                          color: Color.fromARGB(230, 174, 181, 255)),
                      borderRadius: BorderRadius.all(Radius.circular(14.0))),
                ),
                Container(
                  height: 0.235 * screenSize.size.height,
                  color: Color.fromARGB(255, 251, 244, 245),
                ),
                Container(
                  height: 0.075 * screenSize.size.height,
                  color: Color.fromARGB(255, 27, 64, 121),
                ),
              ],
            )));
  }
  String createDescription(String memo, double change,String date){
    //example: amt&#description&#date
    String desc=change.toString()+"&#"+memo+"&#"+date;
    return desc;
  }
  void addBudgetChangeDescription(String budgetDesctiption) {
    var budgetDiscArray = Firestore.instance
        .collection("HouseHoldGroups")
        .document(widget.hhname);
    budgetDiscArray.updateData({
      'Budget Changes': FieldValue.arrayUnion([budgetDesctiption]),
    });
  }

  void changeBudget(double original, double change) {
    Firestore.instance
        .collection('HouseHoldGroups')
        .document(widget.hhname)
        .updateData({'Budget': original + change});
  }
}

void setState(Null Function() param0) {}

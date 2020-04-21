import 'package:commune_spring_2020/Models/User.dart';
import 'package:commune_spring_2020/screens/auth/AccountAccess.dart';
import 'package:commune_spring_2020/services/budgetServices.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/Pages/homescreen.dart';
import 'package:commune_spring_2020/Pages/homepage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/framework.dart';
// im not sure how to read in the people organically and process that
// in addition right now the page only supports up to four people

class BillsExpansion extends StatefulWidget {
  final String uid;
  final bool userChange;
  String hhname;
  BillsExpansion({this.uid, this.userChange, this.onSignedOut});

  //------------------------------------------------------------------
  final VoidCallback onSignedOut;

  Future<void> _signOut(BuildContext context) async {
    try {
      final AuthService auth = new AuthService();
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  //------------------------------------------------------------------
  @override
  _BillsExpansionState createState() => _BillsExpansionState();
}

class _BillsExpansionState extends State<BillsExpansion> {
  budgetServices budgetService = new budgetServices();
  final formKey = GlobalKey<FormState>();
  String title;

  String desc = " ";
  double budgetChange = 0, original;
  bool add;
  String date = (new DateFormat('MMMM').format(DateTime.now())) +
      " " +
      (new DateFormat('d').format(DateTime.now())) +
      ", " +
      (new DateFormat('y').format(DateTime.now()));
  Color buttonColor = Color.fromARGB(255, 27, 64, 121);
  String budgetProfile;
  @override
  bool checkBoxValue = true;
  int counter = 0;
  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    return SingleChildScrollView(
          child: Material(
          child: Center(
              child: Container(
                  decoration:  BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFF59F9B), Color(0xFFE5625C)]
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(15, 35, 15, 0),
                  child: Column(
                    children: <Widget>[
                      // Container(
                      //   height: 0.15 * screenSize.size.height,
                      //   color: Color.fromARGB(255, 251, 244, 245),
                      // ),
                      Container(
                        //height: 0.55 * screenSize.size.height,
                        width: 0.95 * screenSize.size.width,
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: 0.00 * screenSize.size.height,
                                width: 0.95 * screenSize.size.width,
                                //color: Color.fromARGB(230, 174, 181, 255),
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
                                                widget.hhname = snapshot
                                                    .data["HouseHoldName"];
                                                return StreamBuilder(
                                                    stream: Firestore.instance
                                                        .collection(
                                                            "HouseHoldGroups")
                                                        .document(widget.hhname)
                                                        .snapshots(),
                                                    builder: (context, snapshot) {
                                                      return StreamBuilder(
                                                          stream: Firestore
                                                              .instance
                                                              .collection(
                                                                  "HouseHoldGroups")
                                                              .document(
                                                                  widget.hhname)
                                                              .snapshots(),
                                                          builder:
                                                              (context, snap) {
                                                            if (!snap.hasData) {
                                                              return Text(
                                                                  "Loading...");
                                                            }
                                                            original =
                                                                double.parse(snap
                                                                    .data[
                                                                        "Budget"]
                                                                    .toString());
                                                            return Text(
                                                              "Current Budget =\$ " +
                                                                  snap.data[
                                                                          "Budget"]
                                                                      .toStringAsFixed(
                                                                          2),
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          245,
                                                                          229,
                                                                          252),
                                                                  fontSize: 24.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      'Raleway'),
                                                            );
                                                          });
                                                    });
                                              }
                                            }),
                                      ),
                                    ])),
                            Container(
                              //height: 0.49 * screenSize.size.height,
                              width: 0.95 * screenSize.size.width,
                              child: Container(
                                margin: EdgeInsets.all(0.0),
                                child: Form(
                                  child: Column(children: <Widget>[
                                  Container(
                                      height: 0.02 * screenSize.size.height
                                  ),
                                  Container(
                                    height: 0.05 * screenSize.size.height,
                                    width: 1.0 * screenSize.size.width,
                                    child: FittedBox(
                                      child: Text(
                                        "Add a Bill",
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            //fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Raleway')
                                      ),
                                    ),
                                  ),
                                  Container(
                                      height: 0.02 * screenSize.size.height,
                                      //color: Color.fromARGB(230, 174, 181, 255)
                                  ),
                                  Container(
                                    height: 0.1 * screenSize.size.height,
                                    width: 0.8 * screenSize.size.width,
                                    child: TextFormField(
                                        onChanged: (val) {
                                          desc = val;
                                        },
                                        style: TextStyle(
                                          color: Colors.white
                                        ),
                                        decoration: InputDecoration(
                                            labelText: 'Memo',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 0.002 * screenSize.size.height
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                            ),
                                            border: OutlineInputBorder(),
                                            labelStyle: TextStyle(
                                                color: Colors.white))),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0,
                                          0.02 * screenSize.size.height)),
                                  Container(
                                    height: 0.1 * screenSize.size.height,
                                    width: 0.8 * screenSize.size.width,
                                    child: TextFormField(
                                        onChanged: (val) {
                                          budgetChange = double.parse(val);
                                        },
                                        style: TextStyle(
                                          color: Colors.white
                                        ),
                                        decoration: InputDecoration(
                                            labelText: 'Bill Amount',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 0.002 * screenSize.size.height
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                            ),
                                            border: OutlineInputBorder(),
                                            labelStyle: TextStyle(
                                                color: Colors.white))),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0,
                                          0.06 * screenSize.size.height)),
                                  Container(
                                   // height: 0.1 * screenSize.size.height,
                                    //width: 0.8 * screenSize.size.width,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          StreamBuilder(
                                              stream: Firestore.instance
                                                  .collection('users')
                                                  .document(widget.uid)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return Text("loading....");
                                                }
                                                return FlatButton(
                                                  onPressed: () {
                                                    print("adding bill");
                                                    double o = double.parse(
                                                        snapshot.data["Budget"].toString());
                                                    if (widget.userChange) {
                                                      budgetProfile =
                                                          createDescription(desc,
                                                              budgetChange, date);
                                                      print("1");
                                                      addBudgetChangeDescription2(
                                                          budgetProfile);
                                                      print("2");
                                                      changeBudget2(
                                                          o, budgetChange);
                                                      print("3");
                                                      
                                                    } else {
                                                      print("executing the budgetChange");
                                                      budgetProfile =
                                                          createDescription(desc,
                                                              budgetChange, date);
                                                      addBudgetChangeDescription(
                                                          budgetProfile);
                                                      changeBudget(
                                                          original, budgetChange);
                                                    }
                                                    Navigator.pop(context);
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
                                                  //color: Color.fromARGB(255, 27, 64, 121),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius.circular(12.0),
                                                    side: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                );
                                              }),
                                          StreamBuilder(
                                            stream: Firestore.instance.collection('users').document(widget.uid).snapshots(),
                                            builder: (context, snapshot) {
                                              if(!snapshot.hasData){
                                                return Text("loading...");
                                              }
                                              return FlatButton(
                                                onPressed: () {
                                                   budgetChange = budgetChange * (-1);
                                                    double o = double.parse(
                                                        snapshot.data["Budget"].toString());
                                                    if (widget.userChange) {
                                                      budgetProfile =
                                                          createDescription(desc,
                                                              budgetChange, date);
                                                      print("1");
                                                      addBudgetChangeDescription2(
                                                          budgetProfile);
                                                      print("2");
                                                      changeBudget2(
                                                          o, budgetChange);
                                                      print("3");
                                                      
                                                    } else {
                                                      print("executing the budgetChange");
                                                      budgetProfile =
                                                          createDescription(desc,
                                                              budgetChange, date);
                                                      addBudgetChangeDescription(
                                                          budgetProfile);
                                                      changeBudget(
                                                          original, budgetChange);
                                                    }
                                                    //Navigator.pop(context);
                                                    Navigator.of(context).pop();
                                                  },
                                                // onPressed: () {
                                                //   Navigator.pop(context);
                                                //   budgetChange = budgetChange * (-1);
                                                //    double o = double.parse(
                                                //             snapshot.data["Budget"].toString());
                                                //   if(widget.userChange){
                                                //     budgetProfile =
                                                //               createDescription(desc,
                                                //                   budgetChange, date);
                                                //           addBudgetChangeDescription2(
                                                //               budgetProfile);
                                                //           changeBudget2(
                                                //               o, budgetChange);
                                                //   }else{
                                                //   budgetProfile = createDescription(
                                                //       desc, budgetChange, date);
                                                //   addBudgetChangeDescription(
                                                //       budgetProfile);
                                                //   changeBudget(
                                                //       original, budgetChange);
                                                //   }
                                                // },
                                                child: FittedBox(
                                                  child: Text(
                                                    "Minus",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Raleway',
                                                      fontSize: 17.0,
                                                    ),
                                                  ),
                                                ),
                                                //color: Color.fromARGB(255, 27, 64, 121),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(12.0),
                                                  side:
                                                      BorderSide(color: Colors.white),
                                                ),
                                              );
                                            }
                                          ),
                                        ]),
                                  ),
                                ])),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Container(
                      //   height: 0.215 * screenSize.size.height,
                      //   color: Color.fromARGB(255, 251, 244, 245),
                      // ),
                      // Container(
                      //   height: 0.075 * screenSize.size.height,
                      //   color: Color.fromARGB(255, 27, 64, 121),
                      // ),
                    ],
                  )))),
    );
  }

  String createDescription(String memo, double change, String date) {
    //example: amt&#description&#date
    String desc = change.toString() + "&#" + memo + "&#" + date;
    return desc;
  }

//------------------------------------------------------------------------------------------
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

  //------------------------------------------------------------------------------------------
  void addBudgetChangeDescription2(String budgetDesctiption) {
    var budgetDiscArray =
        Firestore.instance.collection("users").document(widget.uid);
    budgetDiscArray.updateData({
      'Budget Changes': FieldValue.arrayUnion([budgetDesctiption]),
    });
  }

  void changeBudget2(double original, double change) {
    print(change.toString() + "00000000000000000000000000000000000000");
    double newTot= original+change;
    print(newTot);
    Firestore.instance
        .collection('users')
        .document(widget.uid)
        .updateData({'Budget': newTot});
  }
  //------------------------------------------------------------------------------------------
}

// void setState(Null Function() param0) {}

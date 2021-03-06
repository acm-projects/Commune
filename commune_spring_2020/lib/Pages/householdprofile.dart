import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/Pages/bill_expansion.dart';
import 'package:commune_spring_2020/Pages/chore_expansion.dart';
import 'package:commune_spring_2020/services/choresServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class HouseholdProfile extends StatefulWidget {
  final String uid;
  // const HouseholdProfile({Key key, this.uid}) : super(key: key);
  const HouseholdProfile({this.uid});

  @override
  _HouseholdProfileState createState() => _HouseholdProfileState();
}

class _HouseholdProfileState extends State<HouseholdProfile> {
 
  String adminUid;
  @override
  Widget build(BuildContext context) {
     bool isAdmin=true;
    String householdName, admin;
    choresServices cs = new choresServices();

    final screenSize = MediaQuery.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
                  child: Container(
            child: Column(children: <Widget>[
      Container(
              height: 0.1 * screenSize.size.height,
              color: Color.fromARGB(255, 251, 244, 245)),
      Container(
            color: Color.fromARGB(255, 251, 244, 245),
            height: 0.875 * screenSize.size.height,
            child: Column(
              children: <Widget>[
                Container(
                  height: 0.1 * screenSize.size.height,
                  child: Image(
                    //height: 100.0,
                    //width: 100.0,
                    image: AssetImage('assets/LogoV2.png'),
                  ),
                ),

                Container(
                  height: 0.1 * screenSize.size.height,
                  width: 0.9 * screenSize.size.width,
                  child: FittedBox(
                    alignment: Alignment.center,
                    child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('users')
                            .document(widget.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text('loading');
                          }
                          householdName = snapshot.data['HouseHoldName'].toString();
                          return Text(
                            snapshot.data['HouseHoldName'].toString(),
                            // "Swaraaj's Clubhouse yessirrski",
                            style: TextStyle(
                                color: Color.fromARGB(255, 27, 64, 121),
                                fontSize: 24.0,
                                fontFamily: 'Raleway'),
                          );
                        }),
                  ),
                ),
                Container(
                  height: 0.05 * screenSize.size.height,
                ),
                Container(
                  height: 0.1 * screenSize.size.height,
                  width: 0.95 * screenSize.size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        color: Color.fromARGB(255, 159, 166, 248),
                        height: 0.1 * screenSize.size.height,
                        width: 0.07 * screenSize.size.width,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            const IconData(0xe900, fontFamily: 'chore'),
                            color: Color.fromARGB(255, 27, 64, 121),
                          ),
                        ),
                      ),

                      //spacing
                      Container(
                          width: 0.03 * screenSize.size.width,
                          color: Color.fromARGB(255, 159, 166, 248)),

                      Container(
                        color: Color.fromARGB(255, 159, 166, 248),
                        height: 0.1 * screenSize.size.height,
                        width: 0.45 * screenSize.size.width,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Next Chore(s) Due: ",
                            style: TextStyle(
                                color: Colors.white,
                                //fontSize: 24.0,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Raleway'),
                          ),
                        ),
                      ),

                      new StreamBuilder(
                          stream: Firestore.instance
                              .collection('HouseHoldGroups')
                              .document(householdName)
                              .snapshots(),
                          builder: (context, snapshots) {
                            if (!snapshots.hasData) {
                              return Text("loading...");
                            }
                            return Container(
                              color: Color.fromARGB(255, 159, 166, 248),
                              height: 0.1 * screenSize.size.height,
                              width: 0.30 * screenSize.size.width,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                child: StreamBuilder(
                                    stream: Firestore.instance
                                        .collection("HouseHoldGroups")
                                        .document(householdName)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text("Loading...");
                                      }
                                      admin = snapshot.data["Admin"];

                                      List chores = snapshot.data["Chores"];
                                      if(chores.isEmpty){
                                        return Text("No chores!",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 27, 64, 121),
                                            fontSize: 10,
                                            fontFamily: 'Raleway'
                                          )
                                        );
                                      }
                                      return Text(
                                        cs.getDateFromDescription(chores[0]),
                                        style: TextStyle(
                                            color: Colors.white,
                                            //fontSize: 24.0,
                                            fontWeight: FontWeight.w100,
                                            fontFamily: 'Raleway'),
                                      );
                                    }),
                              ),
                            );
                          })
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.05 * screenSize.size.width,
                          color: Color.fromARGB(255, 159, 166, 248)),
                      borderRadius: BorderRadius.all(Radius.circular(14.0))),
                ),

                Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, 0, 0, 0.01 * screenSize.size.height)),

                Container(
                  height: 0.1 * screenSize.size.height,
                  width: 0.95 * screenSize.size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        color: Color.fromARGB(255, 159, 166, 248),
                        height: 0.1 * screenSize.size.height,
                        width: 0.07 * screenSize.size.width,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            const IconData(0xe900, fontFamily: 'rent'),
                            color: Color.fromARGB(255, 27, 64, 121),
                          ),
                        ),
                      ),
                      Container(
                          width: 0.03 * screenSize.size.width,
                          color: Color.fromARGB(255, 159, 166, 248)),
                      Container(
                        color: Color.fromARGB(255, 159, 166, 248),
                        height: 0.1 * screenSize.size.height,
                        width: 0.45 * screenSize.size.width,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Admin: ",
                            style: TextStyle(
                                color: Colors.white,
                                //fontSize: 24.0,
                                fontWeight: FontWeight.w100,
                                fontFamily: 'Raleway'),
                          ),
                        ),
                      ),
                      StreamBuilder(
                          stream: Firestore.instance
                              .collection("HouseHoldGroups")
                              .document(householdName)
                              .snapshots(),
                          builder: (context, snap) {
                            if (!snap.hasData) {
                              return Text("loading...");
                            }
                            return StreamBuilder(
                                stream: Firestore.instance
                                    .collection("users")
                                    .document(admin)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text("loading...");
                                  }
                                  return Container(
                                    color: Color.fromARGB(255, 159, 166, 248),
                                    height: 0.1 * screenSize.size.height,
                                    width: 0.30 * screenSize.size.width,
                                    child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      child: StreamBuilder(
                                          stream: Firestore.instance
                                              .collection("users")
                                              .document(admin)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Text("loading...");
                                            }
                                            String firstName =
                                                snapshot.data["First Name"];
                                            String lastName =
                                                snapshot.data["Last Name"];
                                            String name =
                                                firstName + " " + lastName;
                                            return Text(
                                              name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  //fontSize: 24.0,
                                                  fontWeight: FontWeight.w100,
                                                  fontFamily: 'Raleway'),
                                            );
                                          }),
                                    ),
                                  );
                                });
                          })
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.05 * screenSize.size.width,
                          color: Color.fromARGB(255, 159, 166, 248)),
                      borderRadius: BorderRadius.all(Radius.circular(14.0))),
                ),

                //spacing
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, 0, 0, 0.01 * screenSize.size.height)),

                Container(
                  height: 0.1 * screenSize.size.height,
                  width: 0.95 * screenSize.size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        color: Color.fromARGB(255, 159, 166, 248),
                        height: 0.1 * screenSize.size.height,
                        width: 0.07 * screenSize.size.width,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            const IconData(0xe900, fontFamily: 'budget'),
                            color: Color.fromARGB(255, 27, 64, 121),
                          ),
                        ),
                      ),
                      Container(
                          width: 0.03 * screenSize.size.width,
                          color: Color.fromARGB(255, 159, 166, 248)),
                      Container(
                        color: Color.fromARGB(255, 159, 166, 248),
                        height: 0.1 * screenSize.size.height,
                        width: 0.45 * screenSize.size.width,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Monthly Budget: ",
                            style: TextStyle(
                                color: Colors.white,
                                //fontSize: 24.0,
                                fontWeight: FontWeight.w100,
                                fontFamily: 'Raleway'),
                          ),
                        ),
                      ),
                      Container(
                        color: Color.fromARGB(255, 159, 166, 248),
                        height: 0.1 * screenSize.size.height,
                        width: 0.30 * screenSize.size.width,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('HouseHoldGroups')
                                  .document(householdName)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text('loading');
                                }
                                return StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('HouseHoldGroups')
                                        .document(householdName)
                                        .snapshots(),
                                    builder: (context, snap) {
                                      if (!snap.hasData) {
                                        return Text("loading...");
                                      }
                                      double t=0;
                                      t = double.parse(snap.data["Budget"].toString());
                                      return Text(
                                        "\$" + t.toStringAsFixed(2),
                                        style: TextStyle(
                                            color: Colors.white,
                                            //fontSize: 24.0,
                                            fontWeight: FontWeight.w100,
                                            fontFamily: 'Raleway'),
                                      );
                                    });
                              }),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.05 * screenSize.size.width,
                          color: Color.fromARGB(255, 159, 166, 248)),
                      borderRadius: BorderRadius.all(Radius.circular(14.0))),
                ),

                //spacing
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, 0, 0, 0.05 * screenSize.size.height)),

                Container(
                  height: 0.1 * screenSize.size.height,
                  width: 0.95 * screenSize.size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Visibility(
                          visible: isAdmin,
                          child: FlatButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                     child: Container(
                                       child: ChoreExpansion(uid: widget.uid),
                                       height: 650
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0)
                                      )
                                    );
                                  }
                              );
                            },
                            splashColor: Color(0xFF582D8F),
                            child: Text( 'Add a Chore',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Raleway',
                                color: Color.fromARGB(255, 27, 64, 121)
                              )
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(25),
                              side: BorderSide(
                                color: Color.fromARGB(255, 27, 64, 121),
                                width: 2.0,
                              )
                            ),
                            padding: EdgeInsets.fromLTRB(35, 15, 35, 15),                       
                          ),
                        ),
                        StreamBuilder(
                          stream: Firestore.instance.collection('HouseHoldGroups').document(householdName).snapshots(),
                          builder: (context, snap){
                            if(!snap.hasData){
                              return Text("loading...");
                            }
                            if(admin==widget.uid){
                                isAdmin=true;
                                // isAdmin=true;
                            }else{
                                isAdmin=false;
                              // isAdmin=false;
                            }
                            return Text(" ");
                          }
                            ,
                        ),
                        Visibility(
                          visible:(isAdmin),
                          child: FlatButton(
                            onPressed: () {
                              if(!isAdmin){
                                print("false");
                              }else{
                                print("true");
                              }
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Container(
                                        height: 450,
                                        child: BillsExpansion(
                                          uid: widget.uid,
                                          userChange: false,
                                        ),
                                      ),

                                      // shape: RoundedRectangleBorder(
                                      //   borderRadius: new BorderRadius.circular(25.0)
                                      // ),
                                    );
                                  });
                            },
                            splashColor: Color(0xFF582D8F),
                            child: Text( 'Add a Bill',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Raleway',
                                color: Color.fromARGB(255, 27, 64, 121)
                              )
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(25),
                              side: BorderSide(
                                color: Color.fromARGB(255, 27, 64, 121),
                                width: 2.0,
                              )
                            ),
                            padding: EdgeInsets.fromLTRB(35, 15, 35, 15), 
                          ),
                        )
                      ]),
                ),
              ],
            ),
      ),
      // Container(
      //       height: 0.075 * screenSize.size.height,
      //       color: Colors.blueGrey,
      // ),
    ]),
          ),
        ));
    // }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/services/choresServices.dart';
import 'package:flutter/material.dart';

class HouseholdProfile extends StatefulWidget {
  final String uid;
  // const HouseholdProfile({Key key, this.uid}) : super(key: key);
const HouseholdProfile({this.uid});

  @override
  _HouseholdProfileState createState() => _HouseholdProfileState();
}

class _HouseholdProfileState extends State<HouseholdProfile> {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(home: Foundation(uid: widget.uid));
//   }
// }

// class Foundation extends StatelessWidget {
  // final String uid;
  // const Foundation({Key key, this.uid}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
    String householdName,admin;
    choresServices cs= new choresServices();
    // print(uid+"8888888888888888888888888888888888888888");
    final screenSize = MediaQuery.of(context);
    return Scaffold(
        body: Column(children: <Widget>[
      Container(
          height: 0.05 * screenSize.size.height,
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
                      if(!snapshot.hasData){
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
                    stream: Firestore.instance.collection('HouseHoldGroups').document(householdName).snapshots(),
                    builder: (context, snapshots) {
                      if(!snapshots.hasData){
                        return Text("loading...");
                      }
                      // print(snapshots.data["Admin"].toString());
                      return Container(
                        color: Color.fromARGB(255, 159, 166, 248),
                        height: 0.1 * screenSize.size.height,
                        width: 0.30 * screenSize.size.width,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: StreamBuilder(
                            stream: Firestore.instance.collection("HouseHoldGroups").document(householdName).snapshots(),
                            builder: (context, snapshot) {
                              if(!snapshot.hasData){
                                return Text("Loading...");
                              }
                              admin=snapshot.data["Admin"];
                              List chores= snapshot.data["Chores"];
                              return Text(
                                cs.getDateFromDescription(chores[0]),
                                style: TextStyle(
                                    color: Colors.white,
                                    //fontSize: 24.0,
                                    fontWeight: FontWeight.w100,
                                    fontFamily: 'Raleway'),
                              );
                            }
                          ),
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
                    stream: Firestore.instance.collection("users").document(admin).snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return Text("loading...");
                      }
                      print(admin);
                      return Container(
                        color: Color.fromARGB(255, 159, 166, 248),
                        height: 0.1 * screenSize.size.height,
                        width: 0.30 * screenSize.size.width,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: StreamBuilder(
                            stream: Firestore.instance.collection("users").document(admin).snapshots(),
                            builder: (context, snapshot) {
                              if(!snapshot.hasData){
                                return Text("loading...");
                              }
                              String name=snapshot.data["First Name"]+" "+snapshot.data["Last Name"];
                              return Text(
                                name,
                                style: TextStyle(
                                    color: Colors.white,
                                    //fontSize: 24.0,
                                    fontWeight: FontWeight.w100,
                                    fontFamily: 'Raleway'),
                              );
                            }
                          ),
                        ),
                      );
                    }
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
                          builder: (context, snapshot){                        
                            if(snapshot.hasData==null){
                              return Text('loading');
                            }
                            return StreamBuilder(
                              stream: Firestore.instance.collection('HouseHoldGroups').document(householdName).snapshots(),
                              builder: (context, snapshot) {
                                if(!snapshot.hasData){
                                  return Text("loading...");
                                }
                                return Text(
                                  "\$"+snapshot.data["Budget"].toStringAsFixed(2),
                                  style: TextStyle(
                                      color: Colors.white,
                                      //fontSize: 24.0,
                                      fontWeight: FontWeight.w100,
                                      fontFamily: 'Raleway'),
                                );
                              }
                            );
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
                    FlatButton(
                      onPressed: () {},
                      child: FittedBox(
                        child: Text(
                          "Add a Chore",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Raleway',
                            //fontSize: 17.0,
                          ),
                        ),
                      ),
                      color: Color.fromARGB(255, 27, 64, 121),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(12.0),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: FittedBox(
                        child: Text(
                          "Add a Bill",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Raleway',
                            //fontSize: 17.0,
                          ),
                        ),
                      ),
                      color: Color.fromARGB(255, 27, 64, 121),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(12.0),
                        side: BorderSide(color: Colors.white),
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
      Container(
        height: 0.075 * screenSize.size.height,
        color: Colors.blueGrey,
      ),
    ]));
  // }

}
}
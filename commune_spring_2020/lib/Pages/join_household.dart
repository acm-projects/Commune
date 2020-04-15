import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/Pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class JoinHousehold extends StatefulWidget {
  JoinHousehold({Key key}) : super(key: key);

  @override
  _JoinHouseholdState createState() => _JoinHouseholdState();
}

class _JoinHouseholdState extends State<JoinHousehold> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _houseName, _housePassword;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    return Material(
    
    child: Container(
      height: 1.0 * screenSize.size.height,
      width: 1.0 * screenSize.size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 245, 159, 155), Color.fromARGB(255, 229, 98, 92)]
        ),
      ),
       child: Column(
         children: <Widget>[
           Container(height: 0.1 * screenSize.size.height, color: Colors.transparent,),
           Container(
             height: 0.10 * screenSize.size.height,
             width: 0.75 * screenSize.size.width,
             child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                     Text(
                      "Join an Existing Household",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          //fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway'),
                    ),
                ],
              ),
             ),
           ),
           Container(
             height: 0.6 * screenSize.size.height,
             width: 0.8 * screenSize.size.width,
             child: Card(
               elevation: 0,
               color: Colors.transparent,
               child: Form(
                 key: _formKey,
                 child: Column(
                   children: <Widget>[
                    
                     Container(height: 0.03 * screenSize.size.height, color: Colors.transparent),

                     Container(
                      height: 0.1 * screenSize.size.height,
                      width: 0.8 * screenSize.size.width,
                      color: Colors.transparent,
                      child: TextFormField(
                        validator: (input){
                        if(input.isEmpty){
                        return 'Type in a House name';
                         }
                        },
                        onSaved: (input) => _houseName = input,
                        decoration: InputDecoration(
                          labelText: 'Household Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.002 * screenSize.size.height),
                            borderRadius: BorderRadius.all(
                                Radius.circular(8.0)),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle:
                              TextStyle(color: Colors.white))),
                    ),

                    Container(height: 0.03 * screenSize.size.height, color: Colors.transparent),

                    Container(
                      height: 0.1 * screenSize.size.height,
                      width: 0.8 * screenSize.size.width,
                      color: Colors.transparent,
                      child: TextFormField(
                        validator: (input){
                         if(input.isEmpty){
                          return 'Type in a password';
                         }
                        },
                        onSaved: (input) => _housePassword = input,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Household Password',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.002 * screenSize.size.height),
                            borderRadius: BorderRadius.all(
                                Radius.circular(8.0)),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle:
                              TextStyle(color: Colors.white,
                              ))),
                    ),

                    Container(height: 0.03 * screenSize.size.height, color: Colors.transparent),

                    Spacer(),

                   ]
                 )
               )
             ),
           ),

            FlatButton(
              onPressed: () {loginInToHouse();},
              child: FittedBox(
                child: Text(
                  "Join!",
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Raleway',
                    fontSize: 24.0,
                  ),
                )
              ),
              color: Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius:
                    new BorderRadius.circular(25.0),
                side: BorderSide(color: Colors.white),
              ),
              padding: EdgeInsets.fromLTRB(30, 8, 30, 8)
            ),

         ],
       ),
    ));
  }

  Future<void> loginInToHouse() async {
    if(_formKey.currentState.validate())
    {
      _formKey.currentState.save();

      var db= Firestore.instance;
      var houseDoc = db.collection('HouseHoldGroups').document(_houseName);

      houseDoc.get().then((DocumentSnapshot)=>
      {
        if(DocumentSnapshot.exists)
        {
          houseDoc.get().then((doc) async {
            if(_housePassword==doc['Password'])
            {
              FirebaseUser user= (await FirebaseAuth.instance.currentUser());
              updateUserHouseAndUserArray(user.uid);

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(uid: user.uid)));
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignIn()));
            }
            else
            {
              _showDialogForHouseHoldWrongPassword();
            }
          }),
        } 
        else
        {
          _showDialogForNotExistingHouseHold()
        }
      });
    }
  }

  void updateUserHouseAndUserArray(var uid){
    var houseNameVaulue =  Firestore.instance.collection("users").document(uid);
      houseNameVaulue.updateData({
        'HouseHoldName': _houseName
      });

    var houseArrayAddition =  Firestore.instance.collection("HouseHoldGroups").document(_houseName);
      houseArrayAddition.updateData({
        'Group Users':  FieldValue.arrayUnion([uid]),
      });
  }

  void _showDialogForNotExistingHouseHold()
  {
    showDialog(
      context: context,
      builder:(BuildContext context){
        return AlertDialog(
          title: new Text("House Hold Group Does Not Exist"),
          content: new Text(_houseName+" is not a created group. Try Again."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed:() {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogForHouseHoldWrongPassword()
  {
    showDialog(
      context: context,
      builder:(BuildContext context){
        return AlertDialog(
          title: new Text("Wrong Password"),
          content: new Text("Wrong Password for this group. Try Again."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed:() {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
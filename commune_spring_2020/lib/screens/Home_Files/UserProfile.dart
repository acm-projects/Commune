

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/Pages/AccountAccessScreens/login.dart';
import 'package:commune_spring_2020/Pages/join_or_create.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:commune_spring_2020/screens/auth/AccountAccess.dart';


class UserProfile extends StatefulWidget {
  final String uid;
  UserProfile({this.uid});

  @override
  _UserProfileState createState() => _UserProfileState(uid: uid);
}

class _UserProfileState extends State<UserProfile> {
  AuthService _auth = new AuthService();
  final String uid;
  _UserProfileState({this.uid});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) { 
   
    return StreamBuilder (
        stream: Firestore.instance.collection("users").document(uid).snapshots(),
         builder: (context, snapshot) {
          if (!snapshot.hasData) {
           return new Text("Loading");
          }
         //isAdminCheck(snapshot.data["HouseHoldName"]);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topCenter
                  ),
                  Container(
                    alignment: Alignment.center,
                    //user info
                    child: Column(
                      children: <Widget>[
                        Text(snapshot.data["First Name"]+" "+snapshot.data["Last Name"],
                          style: TextStyle(
                          color: Color(0xFF582D8F),
                          fontSize: 40,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold
                          )
                        ),
                        StreamBuilder(
                          stream: Firestore.instance.collection('HouseHoldGroups').document(snapshot.data["HouseHoldName"]).snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return new Text("Loading");
                            }
                            if(uid==snapshot.data["Admin"])
                            {
                              return Text('(Admin)',
                                style: TextStyle(
                                  color: Color(0xFFB3B9FA),
                                  fontSize: 20,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.normal
                                )
                              );
                            }
                          }
                        ),
                        Container(                
                          margin: EdgeInsets.fromLTRB(10,65,10,0),    
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: Color(0xfF582D8F)
                                )
                              )
                            ),
                          child: Row(
                            children: <Widget>[
                              Text(snapshot.data["Email"],
                                style: TextStyle(
                                  color: Color(0XFF6D77E0),
                                  fontSize: 18,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.normal
                                )
                              ),
                              Spacer(),
                              Text('Age: '+snapshot.data["Age"],
                                style: TextStyle(
                                  color: Color(0XFF6D77E0),
                                  fontSize: 18,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.normal,
                                )
                              ),
                            ],
                          )
                        ),
                      ]
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        //borderRadius: new BorderRadius.circular(25)
                      ),
                    padding: EdgeInsets.fromLTRB(0, 125, 0, 25)
                  ),
                  //leaderboard
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0XFFDADADA),
                            blurRadius: 10.0, // has the effect of softening the shadow
                            spreadRadius: 5.0, // has the effect of extending the shadow
                            offset: Offset(
                              10.0, // horizontal, move right 10
                              10.0, // vertical, move down 10
                            ),
                          )
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          //leaderboard header
                          Container(
                            alignment: Alignment.centerLeft,
                            //margin: EdgeInsets.only(top: 20),
                            child: StreamBuilder (
                              stream: Firestore.instance.collection("users").document(uid).snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                return new Text("Loading");
                                }
                                return Container(
                                  margin: EdgeInsets.fromLTRB(15, 25, 0, 0),
                                  child: Text(snapshot.data["HouseHoldName"],
                                    style: TextStyle(
                                      color: Color(0xFF1F1B38),
                                      fontSize: 30,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                );
                              }
                            ),
                            width: MediaQuery.of(context).size.width
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xfF582D8F),
                              borderRadius: new BorderRadius.circular(25)
                            ),
                            margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                            width: MediaQuery.of(context).size.width,
                            height: 5
                          ),
                        Container(
                         child :StreamBuilder(
                           stream: Firestore.instance.collection('HouseHoldGroups').document(snapshot.data["HouseHoldName"]).snapshots(),
                           builder: (context, snapshot) {
                           if (!snapshot.hasData) {
                            return new Text("Loading");
                           }
                           List groupOfUsersList = snapshot.data["Group Users"];                            
                           sortList(groupOfUsersList); 
                           return Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               for(var item in groupOfUsersList)
                               StreamBuilder(
                                 stream: Firestore.instance.collection('users').document(item).snapshots(),
                                 builder: (context, snapshot) {
                                   if (!snapshot.hasData) {
                                    return new Text("Loading");
                                   }
                                   sortList(groupOfUsersList);
                                   return Container(
                                     margin: EdgeInsets.fromLTRB(20,20,20,0),
                                     child: Column(
                                       children: <Widget>[
                                         Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: <Widget>[
                                           Text(snapshot.data["First Name"]+" "+snapshot.data["Last Name"],
                                            style: TextStyle(
                                               color: Color(0xFF1F1B38),
                                               fontSize: 25,
                                               fontFamily: 'Raleway',
                                               fontWeight: FontWeight.normal
                                             )
                                            ),
                                            Spacer(),
                                            Text(snapshot.data["Points"].toString(),
                                            style: TextStyle(
                                              color: Color(0xFF1F1B38),
                                              fontSize: 25,
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.normal
                                             )
                                            )
                                         ]
                                       )
                                      ]
                                     )
                                   );
                                 }
                               )
                             ],
                           );
                          }
                        ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xfF582D8F),
                            borderRadius: new BorderRadius.circular(25)
                          ),
                          margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                          width: MediaQuery.of(context).size.width,
                          height: 5
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.fromLTRB(0, 5, 15, 15),
                          child: Text('(Leaderboard)',
                            style: TextStyle(
                              color: Color(0xFF1F1B38),
                              fontSize: 20,
                              fontFamily: 'Raleway',
                            )
                          )
                        ),
                      ]
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () async {
                            await _auth.signOut();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                          },
                          splashColor: Color(0xFF582D8F),
                          child: Text( 'Sign Out',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Raleway',
                              color: Color(0XFF6D77E0)
                            )
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25),
                            side: BorderSide(
                              color: Color(0XFF6D77E0),
                              width: 2.0,
                            )
                          ),
                          padding: EdgeInsets.fromLTRB( 39, 15, 39, 15)
                        ),
                        Container(
                          height: 10.0
                        ),
                        FlatButton(
                          onPressed: () async {
                               var db = Firestore.instance;
                               var adminDoc = db.collection('users').document(uid);
                               String userEmail;
                               await adminDoc.get().then((doc){
                                userEmail = doc['Email'];
                              });
                              print(userEmail+"dfgfdd");
                              resetPassword(userEmail);
                          },
                          child: Text( 'Reset Password',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Raleway',
                              color: Color(0XFF6D77E0)
                            )
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25),
                            side: BorderSide(
                              color: Color(0XFF6D77E0),
                              width: 2.0,
                            )
                          ),
                          padding: EdgeInsets.fromLTRB( 39, 15, 39, 15)
                        )
                      ]
                    )
                  ),
                  StreamBuilder(
                            stream: Firestore.instance.collection('HouseHoldGroups').document(snapshot.data["HouseHoldName"]).snapshots(),
                            builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                            return new Text("Loading");
                            }
                            if(uid==snapshot.data["Admin"])
                            {
                              return 
                                  Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                    child: Column(
                                      children: <Widget>[
                                        FlatButton(
                                      onPressed: () {
                                        leaveHouse(true);
                                      },
                                      child: Text( 'Leave Household',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Raleway',
                                          color: Color(0XFF6D77E0)
                                        )
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(25),
                                        side: BorderSide(
                                          color: Color(0XFF6D77E0),
                                          width: 2.0,
                                        )
                                      ),
                                      padding: EdgeInsets.fromLTRB(50, 15, 50, 15)
                                    ),
                                    Container(
                                      height: 10
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        leaveHouse(true);
                                      },
                                      child: Text( 'Kick Member',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Raleway',
                                          color: Color(0XFF6D77E0)
                                        )
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(25),
                                        side: BorderSide(
                                          color: Color(0XFF6D77E0),
                                          width: 2.0,
                                        )
                                      ),
                                      padding: EdgeInsets.fromLTRB(50, 15, 50, 15)
                                    )
                                  ],
                                )
                              );
                            }
                          }
                        ),
                      ]
                    ),
                  )
              );
            }
        );
      }
        
      void sortList(List listUsers) async
      {
        String houseHoldName;
        var db= Firestore.instance;
        bool swapped = true;
        int count = 0;
        String temp = "";
        while(swapped){
          swapped = false;
          count++;
          for(var item = 0; item < listUsers.length-count; item++)
          {
            var userDoc = db.collection('users').document(listUsers[item]);
            var userDoc2 = db.collection('users').document(listUsers[item+1]);

            int pointValue1=0;
            int pointValue2=0;

            await userDoc.get().then((doc){
              pointValue1= doc['Points'];
              houseHoldName = doc['HouseHoldName'];
            }); 
            await userDoc2.get().then((doc){
              pointValue2= doc['Points'];
            }); 
            if(pointValue1 < pointValue2)
            {
              temp = listUsers[item];
              listUsers[item]= listUsers[item+1];
              listUsers[item+1] = temp;
              swapped = true;
            }
          }
        }
        var householdDoc = db.collection('HouseHoldGroups').document(houseHoldName);
        await householdDoc.updateData({
           'Group Users': listUsers,
        });
      }

    void leaveHouse( bool isAdmin)
     {
       String error="", email="";
       if(isAdmin)
       {
         showDialog(
               context: context,
               builder:(BuildContext context){
                 return AlertDialog(
                   title: new Text("Leave Household"),
                   content: new Column(
                     children: <Widget>[
                       Text("Since you are the admin of this household, you need to select the new Admin. Type the email of the user below."),
                       Form(
                         key: _formKey,
                         child: Column(
                           children: <Widget>[
                             TextFormField(
                               validator: (input) {
                                  if(input.isEmpty){
                                    return 'Type in a Email';
                                  }
                                  if(!input.contains('@')){
                                    return 'Not a valid email';
                                  }
                                },
                               onChanged: (val){
                                 email=val.toString();
                               },
                             ),
                           ],
                         ),
                       ),
                       
                       Row(children: <Widget>[
                         RaisedButton(
                           child: new Text("Cancel"),
                           onPressed:() {
                             Navigator.of(context).pop();
                           },
                         ),
                         RaisedButton(
                         child: Text("Confirm"),
                         color: Colors.red[200],
                         onPressed: ()async{
                         if(_formKey.currentState.validate()){

                              String householdName, adimnEmail="";
                              String newAdminUID;
                              List listOfUserUIDS;
                              var db= Firestore.instance;
                              bool foundUser=false;
                              int adminIndex;
                              var adminDoc = db.collection('users').document(uid);
                              await adminDoc.get().then((doc){
                                adimnEmail = doc['Email'];
                                householdName = doc["HouseHoldName"];
                              });

                              var householdDoc = db.collection('HouseHoldGroups').document(householdName);

                              await householdDoc.get().then((doc){
                                listOfUserUIDS = doc['Group Users'];
                              });

                              for(int x=0; x<listOfUserUIDS.length; x++)
                              {
                                String currentEmail = "";
                                var currentUsers = db.collection('users').document(listOfUserUIDS[x]);

                                await currentUsers.get().then((doc){
                                 currentEmail = doc['Email'];
                                });

                                if(currentEmail==adimnEmail)
                                {
                                  adminIndex=x;
                                }

                                if(currentEmail==email && currentEmail!=adimnEmail)
                                {
                                  foundUser=true;
                                  newAdminUID=listOfUserUIDS[x];
                                }
                              }
                              
                              if(foundUser)
                              { 
                                listOfUserUIDS.removeAt(adminIndex);
                                await householdDoc.updateData({
                                          'Group Users': listOfUserUIDS,
                                          'Admin': newAdminUID,
                                          
                               });
                               await adminDoc.updateData({
                                          'HouseHoldName': "Null",
                                          'Budget Changes': new List(),
                                          'Chores': new List(),   
                                          'Points':0,
                               });
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> JoinOrCreate()));
                              }
                              else
                              {
                                
                                 setState((){ 
                                   error = "A user with that email is not in your household. Try Again";
                                });
                                  
                              }

                           }
                         }
                        ),
                       ],),
                       Text(
                         error,
                         style: TextStyle(color:Colors.red),
                       ),
                     ],
                    ),
                    
                 );
               },
             );
       }
       else
       {
         //Put this where the user confirms the want to leave
         //Navigator.of(context).pop();
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HouseHoldSelectionPage()));
          //var db= Firestore.instance;
          //var userDoc = db.collection('users').document(uid);
          //await userDoc.updateData({
          //              'HouseHoldName': "Null",
          //               'Budget Changes': new List(),
          //               'Chores': new List(),   
          //              'Points':0,
          // });
                              
         showDialog(
           context: context,
           builder:(BuildContext context){
             return AlertDialog(
               title: new Text("Leave Household"),
               content:new Column(
                children: <Widget>[
                 new Text("You are about to leave this household. Are you sure you would like to leave?"),
                 new Row(
                   children: <Widget>[
                     new FlatButton(onPressed: null, child: null)
                   ],
                   )
                ]
               ),
               actions: <Widget>[
                 new FlatButton(
                   child: new Text("No"),
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


     Future<void> resetPassword(String _email) async {     
          var auth = FirebaseAuth.instance;     
          auth.sendPasswordResetEmail(email: _email);
          passwordResetAlert(_email);
    }
 
     void passwordResetAlert(String email)
     {
       showDialog(
      context: context,
      builder:(BuildContext context){
        return AlertDialog(
          title: new Text("Password Reset"),
          content: new Text('A password reset link was sent to '+email),
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
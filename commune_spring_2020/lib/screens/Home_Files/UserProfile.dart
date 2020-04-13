

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/screens/HouseloadAccessPages/HouseHoldAccessOptions.dart';
import 'package:flutter/material.dart';


class UserProfile extends StatefulWidget {
  final String uid;
  UserProfile({this.uid});

  @override
  _UserProfileState createState() => _UserProfileState(uid: uid);
}

class _UserProfileState extends State<UserProfile> {

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
                     body:Column(
                       children: <Widget>[
                        Align(
                           alignment: Alignment.topCenter
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Text(snapshot.data["First Name"]+" "+snapshot.data["Last Name"],
                               style: TextStyle(
                               color: Color(0xFFF2F2F2),
                               fontSize: 35,
                               fontFamily: 'Raleway',
                               fontWeight: FontWeight.bold
                                )
                               ),
                               Text(snapshot.data["Email"],
                                 style: TextStyle(
                                   color: Color(0xFF1b4079),
                                   fontSize: 20,
                                   fontFamily: 'Raleway',
                                   fontWeight: FontWeight.normal
                                 )
                               ),
                               Text('Age: '+snapshot.data["Age"],
                                 style: TextStyle(
                                   color: Color(0xFF1b4079),
                                   fontSize: 20,
                                   fontFamily: 'Raleway',
                                   fontWeight: FontWeight.normal
                                 )
                               ),
                               StreamBuilder(
                                   stream: Firestore.instance.collection('HouseHoldGroups').document(snapshot.data["HouseHoldName"]).snapshots(),
                                   builder: (context, snapshot) {
                                   if (!snapshot.hasData) {
                                   return new Text("Loading");
                                   }
                                   String isAdminYesNo="No";
                                   if(uid==snapshot.data["Admin"])
                                   {
                                     isAdminYesNo="Yes";
                                   }
                                   return Text('Admin:'+isAdminYesNo,
                                    style: TextStyle(
                                    color: Color(0xFF1B4079),
                                    fontSize: 20,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.normal
                                 )
                                 );
                                }),

                            ]
                          ),
                          decoration: BoxDecoration(
                             gradient: LinearGradient(
                               begin: Alignment.topCenter,
                               end: Alignment.bottomCenter,
                               colors: [Color(0xFFB3B9FA), Color(0xFF6D77E0)]
                             ),
                             shape: BoxShape.rectangle,
                             borderRadius: new BorderRadius.circular(25)
                           ),
                           padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                           margin: EdgeInsets.fromLTRB(25, 75, 25, 0),
                          ),
                          Container(
                             alignment: Alignment.center,
                             child: Column(
                               children: <Widget>[
                                 Container(
                                   alignment: Alignment.center,
                                   margin: EdgeInsets.only(top: 20),
                                   child: Text('LEADERBOARD',
                                     style: TextStyle(
                                       color: Color(0xFFF2F2F2),
                                       fontSize: 40,
                                       fontFamily: 'Raleway',
                                       fontWeight: FontWeight.bold
                                     )
                                   ),
                                   color: Color(0xFF1B4079),
                                   width: MediaQuery.of(context).size.width,
                                   height: 60,
                                 ),
                                 Container(
                                   alignment: Alignment.center,
                                   //margin: EdgeInsets.only(top: 20),
                                   child:StreamBuilder (
                                     stream: Firestore.instance.collection("users").document(uid).snapshots(),
                                      builder: (context, snapshot) {
                                       if (!snapshot.hasData) {
                                        return new Text("Loading");
                                       }
                                       return Text(snapshot.data["HouseHoldName"],
                                         style: TextStyle(
                                           color: Color(0xFF1B4079),
                                           fontSize: 32,
                                           fontFamily: 'Raleway',
                                           fontWeight: FontWeight.bold
                                         )
                                       );
                                      }
                                   ),
                                   width: MediaQuery.of(context).size.width,
                                   height: 60,
                                 ),
                                 Container(
                                  child:StreamBuilder(
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
                                              margin: EdgeInsets.only(top: 20),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    Text(snapshot.data["First Name"]+" "+snapshot.data["Last Name"],
                                                     style: TextStyle(
                                                     color: Color(0xFF1B4079),
                                                     fontSize: 25,
                                                     fontFamily: 'Raleway',
                                                     fontWeight: FontWeight.normal
                                                      )
                                                     ),
                                                     Text(snapshot.data["Points"].toString(),
                                                     style: TextStyle(
                                                       color: Color(0xFF1B4079),
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
                                   margin: EdgeInsets.only(top: 35),
                                   color: Color(0xFF1B4079),
                                   width: MediaQuery.of(context).size.width,
                                   height: 5
                                 ),
                               ]
                             )
                          ),
                         Container(
                           margin: EdgeInsets.only(top: 35),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: <Widget>[
                               FlatButton(
                                 onPressed: () {},
                                 child: Text( 'Log Out',
                                   style: TextStyle(
                                     fontSize: 20,
                                     fontFamily: 'Raleway',
                                     color: Color(0xFFF2F2F2)
                                   )
                                 ),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: new BorderRadius.circular(25),
                                   side: BorderSide(
                                     color: Color(0xFF1B4079),
                                     width: 2.0,
                                   )
                                 ),
                                 padding: EdgeInsets.fromLTRB( 39, 15, 39, 15),
                                 color: Color(0xFF7E86DF),
                               ),
                               FlatButton(
                                 onPressed: () {},
                                 child: Text( 'Reset Password',
                                   style: TextStyle(
                                     fontSize: 20,
                                     fontFamily: 'Raleway',
                                     color: Color(0xFFF2F2F2)
                                   )
                                 ),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: new BorderRadius.circular(25),
                                   side: BorderSide(
                                     color: Color(0xFF1B4079),
                                     width: 2.0,
                                   )
                                 ),
                                 padding: EdgeInsets.fromLTRB( 39, 15, 39, 15),
                                 color: Color(0xFF7E86DF),
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
                                     return Row(
                                       children: <Widget>[
                                         Container(
                                          alignment: Alignment.bottomRight,
                                          margin: EdgeInsets.only( top: 15 ),
                                          child: FlatButton(
                                            onPressed: () {
                                             leaveHouse(true);
                                            },
                                            child: Text( 'LEAVE HOUSEHOLD',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Raleway',
                                                color: Color(0xFFF2F2F2)
                                              )
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(25),
                                              side: BorderSide(
                                                color: Color(0xFF1B4079),
                                                width: 2.0,
                                              )
                                            ),
                                            padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                                            color: Color(0xFF1b4079),
                                          )
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only( top: 10 ),
                                          child: FlatButton(
                                            onPressed: () {},
                                            child: Text( 'Kick Member',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Raleway',
                                                color: Color(0xFFF2F2F2)
                                              )
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(25),
                                              side: BorderSide(
                                                color: Color(0xFF1B4079),
                                                width: 2.0,
                                              )
                                            ),
                                            padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                                            color: Color(0xFF1b4079),
                                          )
                                        ),

                                       ],);
                                   }
                                   return Container(
                                   alignment: Alignment.center,
                                   margin: EdgeInsets.only( top: 15 ),
                                   child: FlatButton(
                                     onPressed: () {},
                                     child: Text( 'LEAVE HOUSEHOLD',
                                       style: TextStyle(
                                         fontSize: 20,
                                         fontFamily: 'Raleway',
                                         color: Color(0xFFF2F2F2)
                                       )
                                     ),
                                     shape: RoundedRectangleBorder(
                                       borderRadius: new BorderRadius.circular(25),
                                       side: BorderSide(
                                         color: Color(0xFF1B4079),
                                         width: 2.0,
                                       )
                                     ),
                                     padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                                     color: Color(0xFF1b4079),
                                   )
                                 );
                          }),
                       ]
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
            //print(pointValue1.toString() +" < "+pointValue2.toString());
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
                               validator: (e)=> e.isEmpty? "Enter an email" : null,
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
                         color: Colors.blue[200],
                         onPressed: ()async{
                         if(_formKey.currentState.validate()){

                              String householdName, adimnEmail="";
                              String newAdminUID;
                              List listOfUserUIDS;
                              var db= Firestore.instance;
                              bool foundUser=false;
                              int adminIndex;
<<<<<<< HEAD
                              
                              
=======
                              
                              
>>>>>>> d50d9c910e979a30c5264122dffd1920ce7b6da9
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
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HouseHoldSelectionPage()));
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

       }
     }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/services/choresServices.dart';
import 'package:flutter/material.dart';


class ChoreList extends StatefulWidget {
  final String uid;
  ChoreList({this.uid}); 
  String hhname; 

  @override
  _ChoreListState createState() => _ChoreListState();
}

class _ChoreListState extends State<ChoreList> {
  choresServices cs= new choresServices();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    final List<String> items = List<String>.generate(100, (i) => "Chore $i");
    return Material(
        child: Container(
          height: 1 * screenSize.size.height,
          width: 1 * screenSize.size.width,
          //color: Color.fromARGB(255, 251, 244, 245),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFFFFF), Color(0xFFFBF4F5)]),
          ),
          child: Column(
            children: <Widget>[
             StreamBuilder(
                stream: Firestore.instance.collection('users').document(widget.uid).snapshots(),
                builder: (context, snap) {
                 if(!snap.hasData){
                    return Text("loading...");
                  }
                    widget.hhname=snap.data["HouseHoldName"];
                    return Container(height: 0.1 * screenSize.size.height,);
                }
              ),
             
                
                Container(
                height: 0.8 * screenSize.size.height,
                width: 0.95 * screenSize.size.width,
                // foregroundDecoration: BoxDecoration(
                //   border: Border.all(
                //   width: 0.005 * screenSize.size.width,
                //   color: Colors.black),
                //   borderRadius: BorderRadius.all(Radius.circular(10.0))),
                
                child: Container(
                //color: Color.fromARGB(255, 255, 255, 255),
                
                  height: 0.8 * screenSize.size.height,
                  width: 0.85 * screenSize.size.width,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 0.05 * screenSize.size.height,
                        width: 0.85 * screenSize.size.width,
                        margin: EdgeInsets.all(0.0),
                        padding: EdgeInsets.all(0.0),
                        // decoration: BoxDecoration(
                        // border: Border(
                        //   top: BorderSide(width: 0.007 * screenSize.size.width, color: Color.fromARGB(255, 251, 244, 245)),
                        //   left: BorderSide(width: 0.007 * screenSize.size.width, color: Color.fromARGB(255, 251, 244, 245)),
                        //   right: BorderSide(width: 0.007 * screenSize.size.width, color: Color.fromARGB(255, 251, 244, 245)),
                        //   bottom: BorderSide(width: 0.002 * screenSize.size.width, color: Colors.blueGrey)
                        //   // width: 0.005 * screenSize.size.width,
                        //   // color: Color.fromARGB(255, 251, 244, 245)
                        //   )
                        // ),


                        child: Container(
                        height: 0.03 * screenSize.size.height,
                        width: 0.85 * screenSize.size.width,
                          color: Color.fromARGB(255, 255, 255, 255),
                              child: FittedBox(
                                child: Text(
                                  "Chores",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 128, 88, 178),
                                      //fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Raleway'),
                                ),
                              ),

                          
                        ),

                        
                        //decoration: BoxDecoration(border: Border.all(width: 0.005 * screenSize.size.width, color: Colors.transparent)),
                      ),
                        
                        Container(height: 0.03 * screenSize.size.height, color: Color.fromARGB(255, 255, 255, 255),),
                        Container(
                          height: 0.04 * screenSize.size.height,
                          width: 0.7 * screenSize.size.width,
                          color: Color.fromARGB(255, 255, 255, 255),
                            child: Row(
                              
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FittedBox(
                                  child: Text(
                                  "All Chores",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 159, 166, 248),
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway'
                                    ),
                                ),

                                ),
                                
                                FittedBox(
                                  child: Text(
                                    "Due Date ",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 159, 166, 248),
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Raleway'
                                      ),
                                  ),
                                ),
                              ]
                            ),
                        ),



                        Container(child: 
                        Divider(color: Colors.black, thickness: 0.003 * screenSize.size.width,), 
                        color: Color.fromARGB(255, 255, 255, 255),
                        height: 0.01*screenSize.size.height,),
                        
                        //Container(height: 0.01 * screenSize.size.height, color: Color.fromARGB(255, 83, 185, 249),),

                        StreamBuilder(
                          stream: Firestore.instance.collection('HouseHoldGroups').document(widget.hhname).snapshots(),
                          builder: (context, snapshot) {
                            if(!snapshot.hasData){
                              return Text("data");
                            }
                            return StreamBuilder(
                              stream: Firestore.instance.collection('HouseHoldGroups').document(widget.hhname).snapshots(),
                              builder: (context, snap) {
                                if(!snap.hasData){
                                  return Text("loading...");
                                }
                                List chores=snap.data["Chores"];
                                return Container(
                                  height: 0.6 * screenSize.size.height,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: chores.length,
                                    itemBuilder: (context, index){
                                      return Container(
                                        margin: EdgeInsets.fromLTRB(0.03 * screenSize.size.width, 0, 0.03 * screenSize.size.width, 0.03 * screenSize.size.width),
                                        // height: 0.07 * screenSize.size.height,
                                        // width: 0.90 * screenSize.size.width,
                                        decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 0.003 * screenSize.size.width,
                                          //color: Color.fromARGB(255, 29, 30, 24)),
                                          color: Color.fromARGB(255, 128, 88, 178)),
                                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                        child: ListTile(
                                          title: Text(
                                            cs.getJobFromDescription(chores[index]),
                                            style: TextStyle(
                                              //color: Color.fromARGB(255, 159, 166, 248),
                                              color: Color.fromARGB(255, 128, 88, 178),
                                              fontFamily: 'Roboto',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300
                                            )
                                          ),
                                          trailing: Text(
                                            cs.getDateFromDescription(chores[index]),
                                            style: TextStyle(
                                              //color: Color.fromARGB(255, 159, 166, 248),
                                              color: Color.fromARGB(255, 128, 88, 178),
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w300,
                                              fontSize: 20
                                            )
                                          ),
                                      ));
                                    }
                                    )
                                );
                              }
                            );
                          }
                        ),

                        Container(child: Divider(color: Colors.black, thickness: 0.005 * screenSize.size.width,), color: Color.fromARGB(255, 255, 255, 255),
                        height: 0.01*screenSize.size.height,),
                        Expanded(child: Container(color: Colors.transparent,))
                      ]
                  ),
                ),
                )
            ],
          ),

        ),
    );
  }
}
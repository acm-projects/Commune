import 'package:flutter/material.dart';


class JoinHousehold extends StatefulWidget {
  JoinHousehold({Key key}) : super(key: key);

  @override
  _JoinHouseholdState createState() => _JoinHouseholdState();
}

class _JoinHouseholdState extends State<JoinHousehold> {
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
                 child: Column(
                   children: <Widget>[
                    
                     Container(height: 0.03 * screenSize.size.height, color: Colors.transparent),

                     Container(
                      height: 0.1 * screenSize.size.height,
                      width: 0.8 * screenSize.size.width,
                      color: Colors.transparent,
                      child: TextFormField(
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
              onPressed: () {},
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
}
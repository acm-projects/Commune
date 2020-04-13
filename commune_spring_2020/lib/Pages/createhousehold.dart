import 'package:flutter/material.dart';


class CreateHousehold extends StatefulWidget {
  CreateHousehold({Key key}) : super(key: key);

  @override
  _CreateHouseholdState createState() => _CreateHouseholdState();
}

class _CreateHouseholdState extends State<CreateHousehold> {
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
        // shape: BoxShape.rectangle,
        // borderRadius: new BorderRadius.circular(25)
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
                      "Create a new household",
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
                              width: 0.005 * screenSize.size.height),
                            borderRadius: BorderRadius.all(
                                Radius.circular(8.0)),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle:
                              TextStyle(color: Colors.white))),
                    ),

                    Container(height: 0.05 * screenSize.size.height, color: Colors.transparent),

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
                              width: 0.005 * screenSize.size.height),
                            borderRadius: BorderRadius.all(
                                Radius.circular(8.0)),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle:
                              TextStyle(color: Colors.white))),
                    ),

                    Container(height: 0.05 * screenSize.size.height, color: Colors.transparent),

                    Container(
                      height: 0.1 * screenSize.size.height,
                      width: 0.8 * screenSize.size.width,
                      color: Colors.transparent,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Budget/Base Rent',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.005 * screenSize.size.height),
                            borderRadius: BorderRadius.all(
                                Radius.circular(8.0)),
                          ),
                          border: OutlineInputBorder(),
                          labelStyle:
                              TextStyle(color: Colors.white))),
                    ),

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
                  "Create",
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Raleway',
                    fontSize: 24.0,
                    fontWeight: FontWeight.w300
                  ),
                ),
              ),
              color: Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius:
                    new BorderRadius.circular(12.0),
                side: BorderSide(color: Colors.white),
              ),
            ),

         ],
       ),
    ));
  }
}
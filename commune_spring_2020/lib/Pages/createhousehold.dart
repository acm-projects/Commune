import 'package:commune_spring_2020/Pages/homepage.dart';
import 'package:commune_spring_2020/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CreateHousehold extends StatefulWidget {
  CreateHousehold({Key key}) : super(key: key);

  @override
  _CreateHouseholdState createState() => _CreateHouseholdState();
}

class _CreateHouseholdState extends State<CreateHousehold> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _pass, _houseHoldName = "";
  String budget;
  
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
                          if(input.isEmpty)
                          {
                            return "Enter a Name";
                          }
                        },
                        onSaved: (input) => _houseHoldName = input,
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

                    Container(height: 0.05 * screenSize.size.height, color: Colors.transparent),

                    Container(
                      height: 0.1 * screenSize.size.height,
                      width: 0.8 * screenSize.size.width,
                      color: Colors.transparent,
                      child: TextFormField(
                         validator: (input){
                          if(input.isEmpty)
                          {
                            return "Enter a Password";
                          }
                          if(input.length<6)
                          {
                            return "Make a Longer Password";
                          }
                        },
                        onSaved: (input) => _pass = input,
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
                              TextStyle(color: Colors.white))),
                    ),

                    Container(height: 0.05 * screenSize.size.height, color: Colors.transparent),

                    Container(
                      height: 0.1 * screenSize.size.height,
                      width: 0.8 * screenSize.size.width,
                      color: Colors.transparent,
                      child: TextFormField(
                        validator: (input){
                          if(input.isEmpty)
                          {
                            return "Enter a Buget";
                          }
                          if(input.contains('-'))
                          {
                            return "Please Give A Number Greater Than 0";
                          }
                        },
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ], 
                        onSaved: (input) => budget = input,
                        decoration: InputDecoration(
                          labelText: 'Budget/Base Rent',
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

                    Spacer(),

                   ]
                 )
               )
             ),
           ),

            FlatButton(
              onPressed: () {
                if(_formKey.currentState.validate())
               {
                _formKey.currentState.save();
                loginInToHouse(_pass, _houseHoldName, budget);
               }
              },
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
                    new BorderRadius.circular(25.0),
                side: BorderSide(color: Colors.white),
              ),
              padding: EdgeInsets.fromLTRB(30, 8, 30, 8)
            ),
         ],
       ),
    ));
  }

  Future<void> loginInToHouse(String password, String houseName, String budget) async {
    if(_formKey.currentState.validate())
    {
      _formKey.currentState.save();
      FirebaseUser user= (await FirebaseAuth.instance.currentUser());
      DatabaseService(uid: user.uid).updateHouseHoldData(password,houseName,budget);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(uid:user.uid)));
    }
  }
}
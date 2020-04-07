import 'package:flutter/material.dart';
import 'package:commune_spring_2020/Pages/homescreen.dart';
import 'package:commune_spring_2020/Pages/homepage.dart';



class ChoreExpansion  extends StatefulWidget {

  @override
  _ChoreExpansion createState() => _ChoreExpansion();
}



class _ChoreExpansion extends State<ChoreExpansion > {
  List<String> persons =
  [ "Swaraaj Bhattacharya", "Neha Rode", "Olimjon Nematov", "Trevor Tomer" ];
  bool checkBoxValue = false;
    int counter = 0;

    void incrementCounter(){
      setState(() {
        counter++;
      });
    }
  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    return Material(
      child: Container( color: Color.fromARGB(255, 251, 244, 245),
        child: Column(
          children: <Widget>[
            Container(height: 0.04 * screenSize.size.height, color: Color.fromARGB(255, 251, 244, 245)),
            Container(
              
              height: 0.85 * screenSize.size.height,
              width: 0.95 * screenSize.size.width,
              child: Column(
                children: <Widget>[

                  Container(
                    height: 0.05 * screenSize.size.height,
                    width: 1.0* screenSize.size.width,
                    color: Color.fromARGB(230, 174, 181, 255),
                    child: FittedBox(
                      child: Text(
                        "Add a Chore",
                        style: TextStyle(
                          color: Color.fromARGB(255, 245, 229, 252),
                          fontSize: 24.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Raleway'
                        ),
                      ),
                    ),

                  ),

                  Container(height: 0.01 * screenSize.size.height, color: Color.fromARGB(230, 174, 181, 255),),

                  Container(
                    height: 0.07 * screenSize.size.height,
                    //width: 0.8 * screenSize.size.width,
                    color: Color.fromARGB(230, 174, 181, 255),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Memo',
                        enabledBorder: OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.white, width: 0.005 * screenSize.size.height),
                          borderRadius:  BorderRadius.all(
                              Radius.circular(8.0)
                          ),
                         ),
                          border:  OutlineInputBorder(),
                          labelStyle: TextStyle(
                          color: Colors.blueGrey
                          )
                        )
                      ),
                    ),

                    Container(height: 0.04 * screenSize.size.height, color: Color.fromARGB(230, 174, 181, 255),),

                    Container(
                      height: 0.13 * screenSize.size.height,
                      color: Color.fromARGB(230, 174, 181, 255),
                        child: Align( alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            Text(_dateTime == null ? 'No Date Chosen Yet' : _dateTime.toString()),
                              Container(
                                height: 0.1 * screenSize.size.height,
                                width: 0.30 * screenSize.size.width,
                                  child: FittedBox(
                                    child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                    FlatButton(
                                    onPressed: () {
                                      showDatePicker(context: context, 
                                      initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime(2021)
                                      ).then((date) {
                                        setState(() {
                                          _dateTime = date;
                                        });
                                      });
                                    },
                                    child: FittedBox(
                                    child: Text("Choose a Date",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Raleway',
                                        //fontSize: 17.0,
                                      ),
                                      ),
                                    ),
                                    )
                                    ]
                                    ),
                                  ),
                                color: Color.fromARGB(255, 159, 166, 248),
                                // shape: RoundedRectangleBorder(
                                // borderRadius: new BorderRadius.circular(12.0),
                                // side: BorderSide(color: Colors.white),
                                // ), 
                              ),
                          ],
                        ),
                      ),
                    ),

                    Container(height: 0.02 * screenSize.size.height, color: Color.fromARGB(230, 174, 181, 255),),

                    Container(
                    height: 0.07 * screenSize.size.height,
                    color: Color.fromARGB(230, 174, 181, 255),
                    //width: 0.8 * screenSize.size.width,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Point Value (Numbers Only)',
                        enabledBorder: OutlineInputBorder(
                          borderSide:  BorderSide(color: Colors.white, width: 0.005 * screenSize.size.height),
                          borderRadius:  BorderRadius.all(
                              Radius.circular(8.0)
                          ),
                         ),
                          border:  OutlineInputBorder(),
                          labelStyle: TextStyle(
                          color: Colors.blueGrey
                          )
                        )
                      ),
                    ),

                    Container(height: 0.02 * screenSize.size.height, color: Color.fromARGB(230, 174, 181, 255),),

                    Container(
                    color: Color.fromARGB(230, 174, 181, 255),
                    height: 0.05 * screenSize.size.height,
                    //width: 0.95 * screenSize.size.width,
                    
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Text(
                          "Assign Bill to:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w100,
                            fontFamily: 'Raleway'
                            ),
                         ),
                        ),
                      )
                   ),

                    Container(
                              height: 0.28 * screenSize.size.height,
                              width: 1 * screenSize.size.width,
                              color: Color.fromARGB(255, 159, 166, 248),
                                child: Column(
                                  children: <Widget> [
                                    Container(
                                      height: 0.07 * screenSize.size.height,
                                      width: (0.95) * screenSize.size.width,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: FittedBox(
                                          child: Row(
                                            children: <Widget>[
                                              Checkbox(
                                                  value: checkBoxValue,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      checkBoxValue = value;
                                                    });
                                                  },
                                                ),
                                                FittedBox(
                                                  child: Text(
                                                      persons[0],
                                                      style: TextStyle(
                                                        //color: Colors.white,
                                                        //fontSize: 18.0
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      
                                    Container(
                                      height: 0.07 * screenSize.size.height,
                                      width: (0.95) * screenSize.size.width,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: FittedBox(
                                          child: Row(
                                          children: <Widget>[
                                            Checkbox(
                                                value: checkBoxValue,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    checkBoxValue = value;
                                                  });
                                                },
                                            ),
                                            FittedBox(
                                              child: Text(
                                                  persons[1],
                                                  style: TextStyle(
                                                    //color: Colors.white,
                                                    //fontSize: 18.0
                                                  ),
                                              ),
                                            ),
                                          ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 0.07 * screenSize.size.height,
                                      width: (0.95) * screenSize.size.width,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: FittedBox(
                                          child: Row(
                                          children: <Widget>[
                                            Checkbox(
                                                value: checkBoxValue,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    checkBoxValue = value;
                                                  });
                                                },
                                            ),
                                            FittedBox(
                                              child: Text(
                                                  persons[2],
                                                  style: TextStyle(
                                                    //color: Colors.white,
                                                    //fontSize: 18.0
                                                  ),
                                              ),
                                            ),
                                          ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height: 0.07 * screenSize.size.height,
                                      width: (0.95) * screenSize.size.width,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: FittedBox(
                                          child: Row(
                                          children: <Widget>[
                                            Checkbox(
                                                value: checkBoxValue,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    checkBoxValue = value;
                                                  });
                                                },
                                            ),
                                            FittedBox(
                                              child: Text(
                                                  persons[3],
                                                  style: TextStyle(
                                                    //color: Colors.white,
                                                    //fontSize: 18.0
                                                  ),
                                              ),
                                            ),
                                          ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                              height: 0.05 * screenSize.size.height,
                              width: 1 * screenSize.size.width,
                              color: Color.fromARGB(230, 174, 181, 255),
                              child: Container(
                                height: 0.05 * screenSize.size.height,
                                width: 0.35 * screenSize.size.width,
                                child: FlatButton(
                                  onPressed: () {},
                                  child: FittedBox(
                                    child: Text("Add",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    ),
                                    ),
                                  ),
                                  color: Colors.deepPurple,
                                  ),
                              )
                            ),




                  ],
                ),

              decoration: BoxDecoration(
              border: Border.all(
                width: 0.03 * screenSize.size.height,
                color: Color.fromARGB(230, 174, 181, 255)
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(9.0)
                )
              ),

            ),

            Container(height: 0.035*screenSize.size.height, color: Color.fromARGB(255, 251, 244, 245)),
            Container(height: 0.075*screenSize.size.height, color: Colors.blue),

          ],
         ),
        )  
      );
    }
}

void setState(Null Function() param0) {
}
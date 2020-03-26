import 'package:flutter/material.dart';



class BillsExpansion extends StatelessWidget {
  
  final formKey = GlobalKey<FormState>();
  String title;
  
  final List<String> persons =
  [ "Swaraaj Bhattacharya", "Neha Rode", "Olimjon Nematov", "Trevor Tomer" ];

  @override

    bool checkBoxValue = false;
    int counter = 0;

    void incrementCounter(){
      setState(() {
        counter++;
      });
    }

  Widget build(BuildContext context) {
    return Material(
      child: Column (

      children: <Widget>[
      

        Container(
          color: Color.fromARGB(255, 251, 244, 245),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 50, 20, 40),
          width: 500,
          height: 806,
          decoration: BoxDecoration(
            border: Border.all(
              width: 6.0,
              color: Color.fromARGB(255, 88, 45, 143),
            ),
            borderRadius: BorderRadius.all(
                          Radius.circular(21.0)
                        )
          ),
          child: Container(
            
          color: Color.fromARGB(255, 88, 45, 143),
          child: Container(
            //margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
            color: Color.fromARGB(255, 88, 45, 143),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 460,
                      height: 100,
                      color: Color.fromARGB(235, 174, 181, 255),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                              Text(
                                "Add a bill",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 245, 229, 252),
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Raleway'
                                ),
                              ),
                        ]
                      )
                    ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.zero
                                  )
                                ),
                                color: Color.fromARGB(235, 174, 181, 255),
                                elevation: 0,
                                margin: EdgeInsets.all(0.0),
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Form(
                                  key: formKey, 
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>
                                      [
                                        
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Memo',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.white, width: 3.0),
                                                borderRadius: const BorderRadius.all(
                                                  const Radius.circular(8.0)
                                                ),
                                              ),
                                              border: const OutlineInputBorder(),
                                              labelStyle: TextStyle(
                                                color: Colors.blueGrey
                                              )
                                            )
                                          ),
                                        
                                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 40)),

                                        TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Bill Amount',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.white, width: 3.0),
                                                borderRadius: const BorderRadius.all(
                                                  const Radius.circular(8.0)
                                                ),
                                              ),
                                              border: const OutlineInputBorder(),
                                              labelStyle: TextStyle(
                                                color: Colors.blueGrey
                                              )
                                            )
                                          ),

                                            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 40)),

                                        TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Due Date',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.white, width: 3.0),
                                                borderRadius: const BorderRadius.all(
                                                  const Radius.circular(8.0)
                                                ),
                                              ),
                                              border: const OutlineInputBorder(),
                                              labelStyle: TextStyle(
                                                color: Colors.blueGrey
                                              )
                                            )
                                          ),

                                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 40)),


                                          Container(
                                            padding: EdgeInsets.fromLTRB(6, 0, 0, 10),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                            "Assign Bill to:",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w100,
                                              fontFamily: 'Raleway'
                                            ),
                                          ),
                                            )
                                            
                                          ),
                                          
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide (width: 2.0, color: Colors.white),
                                                left: BorderSide (width: 2.0, color: Colors.white),
                                                right: BorderSide (width: 2.0, color: Colors.white),
                                              )
                                            ),
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
                                                Text(
                                                    persons[0],
                                                    style: TextStyle(
                                                      //color: Colors.white,
                                                      fontSize: 18.0
                                                    ),
                                                ),
                                            ]
                                          ),
                                          ),
                                          
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide (width: 2.0, color: Colors.white),
                                                right: BorderSide (width: 2.0, color: Colors.white),
                                              )
                                            ),
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
                                                Text(
                                                    persons[1],
                                                    style: TextStyle(
                                                    // color: Colors.white,
                                                      fontSize: 18.0
                                                    ),
                                                ),
                                            ]
                                          ),
                                          ),
                                          
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide (width: 2.0, color: Colors.white),
                                                right: BorderSide (width: 2.0, color: Colors.white),
                                              )
                                            ),
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
                                                Text(
                                                    persons[2],
                                                    style: TextStyle(
                                                    //  color: Colors.white,
                                                      fontSize: 18.0
                                                    ),
                                                ),
                                            ]
                                          ),
                                          ),
                                          
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide (width: 2.0, color: Colors.white),
                                                right: BorderSide (width: 2.0, color: Colors.white),
                                                bottom: BorderSide (width: 2.0, color: Colors.white),
                                              )
                                            ),
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
                                                  Text(
                                                      persons[3],
                                                      style: TextStyle(
                                                    //  color: Colors.white,
                                                      fontSize: 18.0
                                                    ),
                                                  ),
                                              ]
                                            )
                                          ),

                                            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 55)),

                                          FlatButton(
                                            onPressed: () {},
                                            child: Text("Assign",
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 245, 229, 252),
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0,
                                            ),
                                            ),
                                            color: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              
                                              borderRadius: new BorderRadius.circular(18.0),
                                              side: BorderSide(color: Colors.white),
                                              )
                                            ),

                                            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 33))

                                      ]
                                    )
                                  )
                                )
                              )
                  ],
                ),
              decoration: BoxDecoration(
                  border: Border.all(
                          width: 10.0,
                          color: Color.fromARGB(235, 174, 181, 255)
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(21.0)
                        )
                ),
              )
            )
          
          ),
        )
      )
      ]
      )
    );
  }
}

void setState(Null Function() param0) {
}
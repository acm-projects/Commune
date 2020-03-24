import 'package:flutter/material.dart';





class HouseholdProfile extends StatelessWidget {
  const HouseholdProfile({Key key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 244, 245),
      body: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(0, 60, 0, 0)),

            Container(
              child: Image(
              height: 100.0,
              width: 100.0,
              image: AssetImage('assets/LogoV2.png'),),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 23)
            ),
            Text(
              "Swaraaj's Clubhouse yessirrski",
              style: TextStyle(
                  color: Color.fromARGB(255, 88, 45, 143),
                  fontSize: 24.0,
                  fontFamily: 'Raleway'
                ),
            ),

          // begin 
          Container(
            width: 400,
            height: 120,
            
            margin: EdgeInsets.fromLTRB(18, 35, 18 ,10),

            child: Container(
             
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[ 


                Container( 
                  
                  margin: EdgeInsets.fromLTRB(0, 0, 0 ,0),
                  color: Color.fromARGB(255, 159, 166, 248),
                  padding: EdgeInsets.fromLTRB(14.0, 40, 40, 40),
                
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 120,
                        child: FittedBox(
                          child: Icon(
                        const IconData(0xe900, fontFamily: 'chore'),
                        color: Colors.white,
                        ),
                        ),
                        padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                        
                      ),

                
                 Container(
                   width: 171,
                   height: 120,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text(
                  "Next Chore(s) Due:",
                  style: TextStyle(
                    color: Colors.white,
                    //fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway'
                      ),
                     ),
                    ),
                  
                  ),
                

                  Container(
                    width: 80,
                    height: 120,
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: FittedBox(
                       child: Text(
                    "4/12/20",
                    style: TextStyle(
                    color: Colors.white,
                    //fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Raleway'
                  ),
                  )
                    )
                   
                  )
                ]
                )
                ),
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4.0,
                  color: Color.fromARGB(255, 159, 166, 248)
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(14.0)
                )
              ),
        ),

            
          ),
            // Base Rent 
            Container(
              width: 400,
              height: 120,
              margin: EdgeInsets.fromLTRB(18, 30, 18 ,10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[ 
              Container( 
              margin: EdgeInsets.fromLTRB(0, 0, 0 ,0),
              color: Color.fromARGB(255, 159, 166, 248),
              padding: EdgeInsets.fromLTRB(14.0, 40, 40, 40),
             
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 120,
                    padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                    child: FittedBox(
                      child: Icon(
                    const IconData(0xe900, fontFamily: 'rent'),
                    color: Colors.white,
               //     size: 28.0,
                    ),
                    )
                    
                  ),

                Container(
                   width: 171,
                   height: 120,
                   child: FittedBox(
                     alignment: Alignment.centerLeft,
                    child: Text(
                    "Base Rent:",
                    style: TextStyle(
                      color: Colors.white,
                 //     fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway'
                    ),
                    ),
                   )
                ),
                
                Container(
                    width: 80,
                    height: 120,
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: FittedBox(
                       child: Text(
                  "\$436",
                  style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                //  fontSize: 24.0,
                  fontFamily: 'Raleway'
                ),
                )
                    )
                 
                )
              ]
              )
              ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 4.0,
                color: Color.fromARGB(255, 159, 166, 248)
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(14.0)
              )
            ),
            ),


            // Monthly Budget
            Container(
              width: 400,
              height: 120,
               margin: EdgeInsets.fromLTRB(18, 30, 18 ,28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[ 
              Container( 
              margin: EdgeInsets.fromLTRB(0, 0, 0 ,0),
              color: Color.fromARGB(255, 159, 166, 248),
              padding: EdgeInsets.fromLTRB(14.0, 40, 40, 40),
             
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 120,
                    padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Icon(
                    const IconData(0xe900, fontFamily: 'budget'),
                    color: Colors.white,
                   // size: 28.0,
                    ),
                    ),
                    
                  ),
              
                   Container(
                   width: 171,
                   height: 120,
                   child: FittedBox(
                     alignment: Alignment.centerLeft,
                      child: Text(
                          "Monthly Budget:",
                          style: TextStyle(
                            color: Colors.white,
                            //fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'
                          ),
                          ),
                   )
                   ),
                Container(
                  width: 80,
                  height: 120,
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                     child: Text(
                  "\$1500",
                  style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                 // fontSize: 24.0,
                  fontFamily: 'Raleway'
                ),
                )
                  )
                 
                )
              ]
              )
              ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 4.0,
                color: Color.fromARGB(255, 159, 166, 248)
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(14.0)
              )
            ),
            ),


            Row(              
              children: <Widget>[  
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 18, 0)),
              FlatButton(
                padding: EdgeInsets.all(6.0),
                onPressed: () {},
                child: Text("Add a Chore",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontSize: 17.0,
              ),
              ),
              color: Color.fromARGB(255, 27, 64, 121),
              shape: RoundedRectangleBorder(
                
                borderRadius: new BorderRadius.circular(12.0),
                side: BorderSide(color: Colors.white),
                 ),
                 
            ),
              Padding(
                padding: EdgeInsets.fromLTRB(160,0,18,0) 
              ),
              
              
              FlatButton(
              padding: EdgeInsets.all(6.0),
              onPressed: () {},
              child: Text("Add a Bill",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Raleway',
                fontSize: 17.0,
              ),
              ),
              color: Color.fromARGB(255, 27, 64, 121),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12.0),
                side: BorderSide(color: Colors.white),
                 ),
                 
            )
              ],
              
            )
          ]
        ,

      ),
      );
    
  }
}


// Container(
//             width: 400,
//             height: 120,
            
//             margin: EdgeInsets.fromLTRB(18, 35, 18 ,10),

//             child: Container(
             
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[ 




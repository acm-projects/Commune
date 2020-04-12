import 'package:flutter/material.dart';


class BillsList extends StatefulWidget {
  BillsList({Key key}) : super(key: key);

  @override
  _BillsListState createState() => _BillsListState();
}

class _BillsListState extends State<BillsList> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    final List<String> items = List<String>.generate(100, (i) => "Expense $i");
    return Material(
       child: Container(
          height: 1 * screenSize.size.height,
          width: 1 * screenSize.size.width,
          color: Color.fromARGB(255, 251, 244, 245),
          child: Column(
            children: <Widget>[
              Container(height: 0.1 * screenSize.size.height,),
                
                Container(
                height: 0.8 * screenSize.size.height,
                width: 0.95 * screenSize.size.width,
                foregroundDecoration: BoxDecoration(
                  border: Border.all(
                  width: 0.005 * screenSize.size.width,
                  color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                
                child: Container(
                color: Color.fromARGB(255, 183, 209, 251),
                
                  height: 0.8 * screenSize.size.height,
                  width: 0.90 * screenSize.size.width,
                  child: Column(
                    children: <Widget>[

                      // Expanded(child: Container(height: 0.02 * screenSize.size.height,color: Color.fromARGB(230, 174, 181, 255))),
                      // Container(height: 1.0, 
                      //   // child: Spacer(),
                      //   decoration: BoxDecoration(
                      //   border: Border.all(
                      //   width: 0.001 * screenSize.size.width,
                      //   color: Colors.black),
                      //   borderRadius: BorderRadius.all(Radius.circular(25.0))),
                        
                      //   ),

                      //Container(height: 0.02 * screenSize.size.height, color: Color.fromARGB(255, 183, 209, 251),),
                      Container(
                        height: 0.05 * screenSize.size.height,
                        width: 0.95 * screenSize.size.width,
                        margin: EdgeInsets.all(0.0),
                        padding: EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 0.007 * screenSize.size.width, color: Color.fromARGB(255, 251, 244, 245)),
                          left: BorderSide(width: 0.007 * screenSize.size.width, color: Color.fromARGB(255, 251, 244, 245)),
                          right: BorderSide(width: 0.007 * screenSize.size.width, color: Color.fromARGB(255, 251, 244, 245)),
                          bottom: BorderSide(width: 0.002 * screenSize.size.width, color: Colors.blueGrey)
                          // width: 0.005 * screenSize.size.width,
                          // color: Color.fromARGB(255, 251, 244, 245)
                          )
                        ),


                        child: Container(
                        height: 0.03 * screenSize.size.height,
                          //width: 1.0 * screenSize.size.width,
                          color: Color.fromARGB(255, 183, 209, 251),
                              child: FittedBox(
                                child: Text(
                                  "Household Bills",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 29, 30, 24),
                                      //fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Raleway'),
                                ),
                              ),

                          
                        ),

                        
                        //decoration: BoxDecoration(border: Border.all(width: 0.005 * screenSize.size.width, color: Colors.transparent)),
                      ),
                        
                        Container(height: 0.03 * screenSize.size.height, color: Color.fromARGB(255, 183, 209, 251),),
                        Container(
                          height: 0.04 * screenSize.size.height,
                          width: 0.95 * screenSize.size.width,
                          color: Color.fromARGB(255, 183, 209, 251),
                            child: Row(
                              
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FittedBox(
                                  child: Text(
                                  " All Expenses - Amount",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 29, 30, 24),
                                    //fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway'
                                    ),
                                ),

                                ),

                                
                                FittedBox(
                                  child: Text(
                                    "Due Date ",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 29, 30, 24),
                                      //fontSize: 24.0,
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
                        color: Color.fromARGB(255, 183, 209, 251),
                        height: 0.01*screenSize.size.height,),
                        
                        //Container(height: 0.01 * screenSize.size.height, color: Color.fromARGB(255, 83, 185, 249),),

                        Container(
                          height: 0.6 * screenSize.size.height,
                          color: Color.fromARGB(255, 83, 185, 249),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: items.length,
                            itemBuilder: (context, index){
                              return Container(
                                margin: EdgeInsets.fromLTRB(0.03 * screenSize.size.width, 0, 0.03 * screenSize.size.width, 0.03 * screenSize.size.width),
                                // height: 0.07 * screenSize.size.height,
                                // width: 0.90 * screenSize.size.width,
                                decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.003 * screenSize.size.width,
                                  color: Colors.white),
                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: ListTile(
                                  title: Text(
                                    '${items[index]}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300
                                    )
                                  ),

                                  subtitle: Text(
                                    '\$400.00',
                                    ),

                                  trailing: Text(
                                    '4/12/20',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20
                                    )
                                  ),
                              ));
                            }
                            )
                        ),

                        Container(child: Divider(color: Colors.black, thickness: 0.005 * screenSize.size.width,), color: Color.fromARGB(255, 83, 185, 249),
                        height: 0.01*screenSize.size.height,),
                        // Container(height: 0.022 * screenSize.size.height, color: Color.fromARGB(255, 183, 209, 251),),

                        // Container(
                        //   height: 0.04 * screenSize.size.height,
                        //   width: 0.95 * screenSize.size.width,
                        //   color: Color.fromARGB(255, 183, 209, 251),
                        //     child: Row(
                              
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: <Widget>[
                        //         FittedBox(
                        //           child: Text(
                        //             " All Chores",
                        //             style: TextStyle(
                        //               color: Color.fromARGB(255, 29, 30, 24),
                        //               fontSize: 24.0,
                        //               fontWeight: FontWeight.bold,
                        //               fontFamily: 'Raleway'
                        //               ),
                        //           ),
                        //         ),
                        //       ]
                        //     ),
                        // ),

                        // Container(child: Divider(color: Colors.black, thickness: 0.005 * screenSize.size.width), color: Color.fromARGB(255, 83, 185, 249),
                        // height: 0.01*screenSize.size.height,),

                        // Container(
                        //   height: 0.305 * screenSize.size.height,
                        //   color: Color.fromARGB(255, 83, 185, 249),
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.vertical,
                        //     itemCount: items.length,
                        //     itemBuilder: (context, index){
                        //       return Container(
                        //         margin: EdgeInsets.fromLTRB(0.03 * screenSize.size.width, 0, 0.03 * screenSize.size.width, 0.03 * screenSize.size.width),
                        //         // height: 0.07 * screenSize.size.height,
                        //         // width: 0.90 * screenSize.size.width,
                        //         decoration: BoxDecoration(
                        //         border: Border.all(
                        //             width: 0.003 * screenSize.size.width,
                        //             color: Colors.white),
                        //         borderRadius: BorderRadius.all(Radius.circular(10.0))),

                        //       child: ListTile(
                        //       title: Text(
                        //         '${items[index]}',
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontFamily: 'Roboto',
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.w300
                        //         )
                        //       ),
                        //       trailing: Text(
                        //         '4/12/20',
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontFamily: 'Roboto',
                        //           fontWeight: FontWeight.w300,
                        //           fontSize: 20
                        //         )
                        //       ),
                              
                        //     ));
                        //     }
                        //     )
                        // ),
                        // Container(child: Divider(color: Colors.black, thickness: 0.005 * screenSize.size.width), color: Color.fromARGB(255, 83, 185, 249),
                        // height: 0.01*screenSize.size.height,),
                        Expanded(child: Container(color: Colors.transparent,))
                      ]
                  ),

                    // decoration: BoxDecoration(
                    // border: Border.all(
                    //     width: 0.008 * screenSize.size.width,
                    //     color: Colors.black),
                    // borderRadius: BorderRadius.all(Radius.circular(10.0))),

                ),

                )
            ],
          ),
       
        ),
    );
  }
}
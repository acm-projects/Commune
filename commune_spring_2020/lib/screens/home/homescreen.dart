import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget{
  final List<String> entries = <String>['A', 'B', 'C'];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFFFFF), Color(0xFFFBF4F5)]
        )
      ),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                    alignment: Alignment.topCenter,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text('To-Do',
                          style: TextStyle(
                            color: Color(0xFFF2F2F2),
                            fontSize: 40,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold
                          )
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
                        padding: EdgeInsets.fromLTRB(15, 15, 0, 380),
                        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      )
                      // Container(
                      //   child: ListView.builder(
                      //     padding: const EdgeInsets.all(8),
                      //     itemCount: entries.length,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return Container(
                      //         height: 50,
                      //         color: Colors.amber,
                      //         child: Center(child: Text('Entry ${entries[index]}')),
                      //       );
                      //     }
                      //   )
                      // )
                    ],
                  )
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text('Bills',
                          style: TextStyle(
                            color: Color(0xFFF2F2F2),
                            fontSize: 40,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold
                          )
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
                        padding: EdgeInsets.fromLTRB(15, 15, 0, 150),
                        margin: EdgeInsets.fromLTRB(25, 20, 25, 0),
                      )
                    ],
                  )
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
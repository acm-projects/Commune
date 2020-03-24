import 'package:flutter/material.dart';

class AppCard extends StatefulWidget {

final Widget child;


AppCard({@required this.child,});

  @override
  _AppCardState createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisSize: MainAxisSize.max,
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: <Widget>[
         new Card(
           elevation: 0,
           margin: EdgeInsets.all(30.0),
           
           color: Colors.transparent,
           child: new Container(
             padding: EdgeInsets.all (20.0),
             child: widget.child,
             ),
           ),
       ]
    );
  }
}
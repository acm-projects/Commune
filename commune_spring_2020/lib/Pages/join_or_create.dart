import 'package:flutter/material.dart';

class JoinOrCreate extends StatefulWidget {
  @override
  _JoinOrCreateState createState() => _JoinOrCreateState();
}

class _JoinOrCreateState extends State<JoinOrCreate>{
  @override
  Widget build( BuildContext context){
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        alignment: Alignment.center,
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF59F9B), Color(0xFFE5625C)]
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                MaterialButton(
                  onPressed: (){},
                  elevation: 20.0,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Container(
                        child: Padding(padding: EdgeInsets.all(70.0),),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                        )
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/LogoV2.png'),
                            fit: BoxFit.fitWidth
                          ),
                          shape: BoxShape.circle
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(40.0)
                        )
                      )
                    ]
                  )
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 7.0),
                  child: Text(
                    'Create a Household',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Raleway',
                      color: Colors.white
                    )
                  )
                )
              ],
            ),
            Column(
              children: <Widget>[
                MaterialButton(
                  onPressed: (){},
                  elevation: 20.0,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Container(
                        child: Padding(padding: EdgeInsets.all(70.0),),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                        )
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/group_icon.png'),
                            fit: BoxFit.fitWidth
                          ),
                          shape: BoxShape.circle
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(40.0)
                        )
                      )
                    ]
                  )
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 7.0),
                  child: Text(
                    'Join an Existing Household',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Raleway',
                      color: Colors.white
                    )
                  )
                )
              ],
            )
          ]
        )
      )
    );
  }
}
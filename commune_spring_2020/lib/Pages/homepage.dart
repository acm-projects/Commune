import 'package:commune_spring_2020/Pages/homescreen.dart';
import 'package:commune_spring_2020/Pages/householdprofile.dart';
import 'package:commune_spring_2020/Pages/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'placeholder_widget.dart';

class Home extends StatefulWidget{
  final String uid;

  Home({this.uid});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  int _currentIndex = 2;
  final List<Widget> _children = [
    UserHome(),
    PlaceholderWidget(Colors.blue),
    Homescreen(),
    PlaceholderWidget(Colors.yellow),
    HouseholdProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        backgroundColor: Color( 0xFFFBF4F5 ),
        selectedItemColor: Color( 0xFF7E86DF ),
        unselectedItemColor: Color( 0xFF1B4079 ),
        items: [
         BottomNavigationBarItem(
            icon: new Icon( Icons.person ),
            title: new Text('Profile'),
         ),
          BottomNavigationBarItem(
           icon: new Icon(Icons.hourglass_empty),
           title: new Text('Chores'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.home),
           title: new Text('Home'),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.attach_money),
           title: new Text('Bills')
         ),
         BottomNavigationBarItem(
           icon: new Icon( Icons.people ),
           title: new Text('Household')
         )
        ],
      )
    );
  }
  
  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }

}
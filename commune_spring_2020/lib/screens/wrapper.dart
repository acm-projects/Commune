
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/screens/HouseloadAccessPages/HouseHoldAccessOptions.dart';
import 'package:commune_spring_2020/screens/auth/authScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:commune_spring_2020/Models/User.dart';
import 'package:commune_spring_2020/screens/Home_Files/home.dart';
class Wrapper extends StatelessWidget {
  String currentHouseholdName;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    //retrun the proper widget
    if(user==null){
      return Authenticate();
    }else{
     return Container(
       height: MediaQuery.of(context).size.height/1.5,
       child: FutureBuilder<String>(
          future: getUserHousehold(user.uid),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              if(currentHouseholdName=='Null')
              {
                return HouseHoldSelectionPage();
              }
              else
              {
                return Home(uid: user.uid);
              }
            } else {
              return Text('Getting Household Name...');
            }
          },
        )
     );
     //DatabaseService database = new DatabaseService();
     ////String houseName= database.getUserHousehold(user.uid);
     ////print("///////////"+database.getUserHousehold(user.uid));
     //String householdName= await getUserHousehold(user.uid);
     //
     //if(householdName=='Null')
     //{
     //  print("///////////////////////////////");
     //}else{
     //  return Home(uid: user.uid);
     //}
    }
  }

   Future<String> getUserHousehold(String userID) async {
     String houseName;
      await Firestore.instance.collection("users").document(userID).get().then((doc){
        houseName= doc.data["HouseHoldName"]; 
      });
      currentHouseholdName=houseName;
      return houseName;
   }
} 
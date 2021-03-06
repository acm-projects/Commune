import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/Pages/AccountAccessScreens/login.dart';
import 'package:commune_spring_2020/Pages/join_or_create.dart';
import 'package:commune_spring_2020/Pages/listofbills.dart';
import 'package:commune_spring_2020/Pages/listofchores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:commune_spring_2020/Models/User.dart';
import 'package:commune_spring_2020/Pages/homepage.dart';

class Wrapper extends StatelessWidget {
  String currentHouseholdName;

  /*
   *          This widget returns either the home screen or the auth screen. If the user is signed in it will 
   *          return the home widget. otherwise it will return the sign in page.
   * 
   * 
   * 
   *                           -> if user is signed in      -> Home      ->rest of the app    
   *                          |                                 ^  
   *                          |                                 |
   *          main  ->  wrapper                                  -----------------------                         
   *                          |                                                         |
   *                           -> if user is not signed in  ->  Sign In  ->   once singed in/up
   *                                          
   *          
   *          Don't add a wiget bc it will mess up the provider (widget that listens to when ).
   *          Instead, in the home page, create an if statement to return the proper widget
   *    
   *          e.g. 
   *          if (userHouseHoldName== null)
   *              return HouseHoldSelectionPage();
   *          
   *          
   *          
  */
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    if (user == null){ 
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
      return LoginPage();
    } else {
      //return Home(uid:user.uid);
      //return ChoreList();
      return FutureBuilder(
      future: householdIsNull(user.uid),
      builder: (context, AsyncSnapshot<bool> snapshot)
      {
         if(snapshot.hasData)
         {
           if(snapshot.data)
           {
             return JoinOrCreate();
           }
           else
           {
             return Home(uid:user.uid);
           }
         }
         else
         {
           return Text("error");
         }
      });
    
    }


  }

   Future<bool> householdIsNull(String userID) async {
     String houseName;
      await Firestore.instance.collection("users").document(userID).get().then((doc){
        houseName= doc.data["HouseHoldName"]; 
      });
      if(houseName=="Null")
      {
        return true;
      }
      return false;
   }

} 
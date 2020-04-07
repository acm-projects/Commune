
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune_spring_2020/Pages/AccountAccessScreens/login.dart';
import 'package:commune_spring_2020/Pages/AccountAccessScreens/register_user.dart';
import 'package:commune_spring_2020/Pages/homescreen.dart';
import 'package:commune_spring_2020/Pages/householdprofile.dart';
import 'package:commune_spring_2020/screens/Home_Files/UserProfile.dart';
import 'package:commune_spring_2020/screens/Home_Files/budget.dart';
import 'package:commune_spring_2020/screens/Home_Files/choresPage.dart';
import 'package:commune_spring_2020/Pages/bill_expansion.dart';
import 'package:commune_spring_2020/Pages/chore_expansion.dart';
import 'package:commune_spring_2020/Pages/householdprofile.dart';
import 'package:commune_spring_2020/screens/HouseloadAccessPages/HouseHoldAccessOptions.dart';
import 'package:commune_spring_2020/screens/auth/authScreen.dart';
import 'package:commune_spring_2020/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:commune_spring_2020/Models/User.dart';
import 'package:commune_spring_2020/Pages/homepage.dart';
// import 'package:commune_spring_2020/screens/Home_Files/home.dart';
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
      //return Authenticate();
       return ChoreExpansion();
    } else {
      return UserProfile(uid:user.uid);
      // return Home(uid:user.uid);
    }
    //retrun the proper widget
    //DO NOT DELETE
  //   if(user==null){
  //     return Authenticate();
  //   }else{
  //    return Container(
  //      height: MediaQuery.of(context).size.height/1.5,
  //      child: FutureBuilder<String>(
  //         future: getUserHousehold(user.uid),
  //         builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
  //           if (snapshot.hasData) {
  //             if(currentHouseholdName=='Null')
  //             {
  //               return HouseHoldSelectionPage();
  //             }
  //             else
  //             {
  //               return Home(uid: user.uid);
  //             }
  //           } else {
  //             return Text('Getting Household Name...');
  //           }
  //         },
  //       )
  //    );
  //   }
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
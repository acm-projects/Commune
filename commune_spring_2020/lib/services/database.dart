import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  String userHHName;
  DatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference householdCollection = Firestore.instance.collection('HouseHoldGroups');

  Future updateUserData(String firstName, String lastName, String email, String age, int budget, String userID) async {
    return await userCollection.document(uid).setData({
      'First Name': firstName,
      'Last Name': lastName,
      'Email':email,
      'Age':age,
      'HouseHoldName':"Null",
      'uid':userID,
      'Chores':new List(),
      'Budget': budget,
      'Budget Changes':new List()
      //'Display Name': displayName,
      //'name': email,
    });
  }

  void updateHouseHoldData( String password, String householdName) async{
    List <String> usersInGroup;
    await householdCollection.document(householdName).setData({
        'Admin': uid,
        'Password': password,
        'Group Users':usersInGroup,
        'Budget Changes':new List(),
        'Budget':0,
    });
    await  householdCollection.document(householdName).updateData({
        'Group Users':  FieldValue.arrayUnion([uid]),
      });
    await userCollection.document(uid).updateData({
       'HouseHoldName': householdName,
    });
  }

  Future<void> addUserToHoushold(String uid, String householdName) async {
    await userCollection.document(uid).updateData({
       'HouseHoldName': householdName,
    });
    await  householdCollection.document(householdName).updateData({
        'Group Users':  FieldValue.arrayUnion([uid]),
    });
  }
  
  //get the user stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  //add to update Budget
  void updateData(selectedDoc, newVal) {
    Firestore.instance.collection('users').document(selectedDoc).updateData({
      'budget': newVal
    }).catchError((e){
      print(e);
    });
  }
  
}

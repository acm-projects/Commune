import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference users2Collection =
      Firestore.instance.collection("users2");

  Future updateUserData(
      String email, int budget, String displayName, String uid) async {
    return await users2Collection.document(uid).setData({
      'name': email,
      'budget': budget,
      'Display Name': displayName,
      'uid:': uid, 
      'chores':new List(),
      'Budget changes':new List(),
    });
  }

  //get the user stream
  Stream<QuerySnapshot> get users {
    return users2Collection.snapshots();
  }

  //add to update Budget
  void updateData(selectedDoc, newVal) {
    Firestore.instance.collection('users2').document(selectedDoc).updateData({
      'budget': newVal
    }).catchError((e){
      print(e);
    });
  }
}

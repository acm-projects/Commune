import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //Collection Reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String firstName, String lastName, String email, String age, String householdName) async{
    return await userCollection.document(uid).setData({
        'First Name': firstName,
        'Last Name': lastName,
        'Email':email,
        'Age':age,
        'HouseHoldName':householdName,
        'uid':uid
    });
  }

  //Get Users Stream
  Stream<QuerySnapshot> get userInfo{
    return userCollection.snapshots();
  }
}
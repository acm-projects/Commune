import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //Collection Reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference householdCollection = Firestore.instance.collection('HouseHoldGroups');

  Future updateUserData(String firstName, String lastName, String email, String age, String householdName) async{
    List <String> chores;
    return await userCollection.document(uid).setData({
        'First Name': firstName,
        'Last Name': lastName,
        'Email':email,
        'Age':age,
        'HouseHoldName':householdName,
        'uid':uid,
        'Chores':chores
    });
  }

  void updateHouseHoldData( String password, String householdName) async{
    List <String> usersInGroup;
    await householdCollection.document(householdName).setData({
        'Admin': uid,
        'Password': password,
        'Group Users':usersInGroup
    });
    await  householdCollection.document(householdName).updateData({
        'Group Users':  FieldValue.arrayUnion([uid]),
      });
    await userCollection.document(uid).updateData({
       'HouseHoldName': householdName,
    });
  }

  //Get Users Stream
  Stream<QuerySnapshot> get userInfo{
    return userCollection.snapshots();
  }
}
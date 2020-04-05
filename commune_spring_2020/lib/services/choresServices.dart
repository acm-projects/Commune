import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class choresServices{


  void addChoreToHouseHold(String choreDescription, String householdName) {
    var ChoresArray = Firestore.instance
        .collection("HouseHoldGroups")
        .document(householdName);
    ChoresArray.updateData({
      'Chores': FieldValue.arrayUnion([choreDescription]),
    });
  }

  void removeChore(String chore,String householdName) {
    var choresArray = Firestore.instance
        .collection('HouseHoldGroups')
        .document(householdName);
    choresArray.updateData({
      'Chores': FieldValue.arrayRemove([chore])
    });
  }

  void removeChoreFromUser(String chore, String uid) {
    var choresArray = Firestore.instance
        .collection('users')
        .document(uid);
    choresArray.updateData({
      'Chores': FieldValue.arrayRemove([chore])
    });
  }

  int getPointFromDescription(String d) {
    String stringAmt = '';
    for (int i = 0; i < d.length - 1; i++) {
      if ((d[i] == '&') && (d[i + 1] == '#')) {
        stringAmt = d.substring(0, i);
        break;
      }
    }
    return int.parse(stringAmt);
  }

  String getJobFromDescription(d) {
    int firstCheckPoint = 0;
    int secondCheckPoint = 0;
    int counter = 0;
    for (int i = 0; i < d.length - 1; i++) {
      if (counter == 0 && (d[i] == '&') && (d[i + 1] == '#')) {
        counter++;
        firstCheckPoint = i;
      }
      if (counter == 1 && ((d[i] == '&') && (d[i + 1] == '#'))) {
        secondCheckPoint = i;
      }
    }
    return d.substring(firstCheckPoint + 2, secondCheckPoint);
  }

  String getDateFromDescription(String d) {
    String date = '';
    int firstCheckPoint = 0;
    int counter = 0;
    for (int i = 0; i < d.length; i++) {
      if ((d[i] == '&') && (d[i + 1] == '#')) {
        counter++;
        firstCheckPoint = i;
      }
      if (counter == 2) {
        return d.substring(firstCheckPoint + 2);
      }
    }
    return date;
  }

  void updateScore(int pts, String uid ){
    int currentScore = 0;
    var userDoc = Firestore.instance
        .collection('users')
        .document(uid)
        .get()
        .then((doc) {
      doc.data['Points'];
    });
    print(userDoc.toString());
    Firestore.instance
        .collection('users')
        .document(uid)
        .updateData({'Points': currentScore + pts});
  }

  void addChoreToUser(String choreDescription,String uid) {
    var ChoresArray =
        Firestore.instance.collection("users").document(uid);
    ChoresArray.updateData({
      'Chores': FieldValue.arrayUnion([choreDescription]),
    });
  }

}
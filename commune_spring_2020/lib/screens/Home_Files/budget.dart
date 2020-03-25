import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Budget extends StatefulWidget {
  final String uid, hhname;
  Budget({this.uid,this.hhname});

  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  // TODO: implement widget
  @override
  Widget build(BuildContext context) {
    var dateFormatter = new DateFormat('MMMM');
    String BudgetChangeDescription = '';
    String date = (dateFormatter.format(DateTime.now())) +
        " " +
        (new DateFormat('d').format(DateTime.now())) +
        ", " +
        (new DateFormat('y').format(DateTime.now()));
    String fullDesc = '';
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: new StreamBuilder(
            stream: Firestore.instance
                .collection('HouseHoldGroups')
                .document(widget.hhname)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading");
              }

              var userDoc = snapshot.data;
              int budgetInt = userDoc.data['Budget'];
              int tempCost = 0;
              TextEditingController _con = new TextEditingController();
              TextEditingController _desc = new TextEditingController();
              return Form(
                child: Column(
                  children: <Widget>[
                    Text("Current Budget= \$" + budgetInt.toString()),
                    TextFormField(
                      controller: _con,
                      decoration: InputDecoration(
                        labelText: "amount to add/minus to budget",
                      ),
                      onChanged: (val) {
                        tempCost = int.parse(val);
                      },
                    ),
                    TextFormField(
                      controller: _desc,
                      decoration: InputDecoration(
                        labelText: "Enter a descitption of the change",
                      ),
                      onChanged: (val) {
                        BudgetChangeDescription = val.toString();
                      },
                    ),
                    RaisedButton(
                      child: Text("add"),
                      onPressed: () {
                        //change the budget
                        changeBudget(true, userDoc.data['Budget'], tempCost);
                        /*
                        budget description format:
                        amt &# description &# date
                        */
                        fullDesc = tempCost.toString() +
                            "&#" +
                            BudgetChangeDescription +
                            "&#" +
                            date;
                        addBudgetChangeDescription(fullDesc);
                        _con.clear();
                        _desc.clear();
                      },
                    ),
                    RaisedButton(
                      child: Text("minus"),
                      onPressed: () {
                        changeBudget(false, userDoc.data['budget'], tempCost);
                        fullDesc = "-" +
                            tempCost.toString() +
                            "&#" +
                            BudgetChangeDescription +
                            "&#" +
                            date;
                        addBudgetChangeDescription(fullDesc);
                        _con.clear();
                        _desc.clear();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        //print history of change-------------------------------------------------------------------------------
        SizedBox(
          height: 300.0,
          width: double.infinity,
          child: Row(
            children: <Widget>[
              //amt col
              SizedBox(
                height: 300.0,
                width: 100.0,
                child: Column(
                  children: <Widget>[
                    Text("Amount"),
                    new StreamBuilder(
                        stream: Firestore.instance
                            .collection('HouseHoldGroups')
                            .document(widget.hhname)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text("loading");
                          } else {
                            var userDoc = snapshot.data;
                            List budgetChangeList = userDoc["Budget changes"];
                            if (budgetChangeList.length == 0) {
                              return Text("No history");
                            } else {
                              List amtsList =
                                  getlistOfAmounts(budgetChangeList);
                              return SizedBox(
                                width: double.infinity,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: amtsList.length,
                                    itemBuilder: (context, index) {
                                      return new ListTile(
                                        title: new Text(
                                          "\$" + amtsList?.elementAt(index) ??
                                              "",
                                        ),
                                      );
                                    }),
                              );
                            }
                          }
                        })
                  ],
                ),
              ),
              //description col
              SizedBox(
                height: 300.0,
                width: 200.0,
                child: Column(
                  children: <Widget>[
                    Text("Description"),
                    new StreamBuilder(
                        stream: Firestore.instance
                            .collection('HouseHoldGroups')
                            .document(widget.hhname)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text('Loading...');
                          }
                          var userDoc = snapshot.data;
                          List descriptionsList = userDoc['Budget changes'];
                          if (descriptionsList.length == 0) {
                            return Text('No history');
                          } else {
                            List descriptionList =
                                getlistOfDescriptions(descriptionsList);
                            return SizedBox(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: descriptionList.length,
                                itemBuilder: (context, index) {
                                  return new ListTile(
                                    title: new Text(
                                        descriptionList?.elementAt(index)),
                                  );
                                },
                              ),
                            );
                          }
                        })
                  ],
                ),
              ),
              //date col
              SizedBox(
                width: 100.0,
                height: 300.0,
                child: Column(children: <Widget>[
                  Text("Date Changed"),
                  new StreamBuilder(
                    stream: Firestore.instance
                        .collection('HouseHoldGroups')
                        .document(widget.hhname)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('loading...');
                      } else {
                        List datesList = snapshot.data['Budget changes'];
                        if (datesList.length == 0) {
                          return Text("no history");
                        } else {
                          List dateList = getlistOfDates(datesList);
                          return SizedBox(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: dateList.length,
                                itemBuilder: (context, index) {
                                  return new ListTile(
                                    title: Text(dateList?.elementAt(index)),
                                  );
                                }),
                          );
                        }
                      }
                    },
                  ),
                ]),
              ),
            ],
          ),
        ),
        //--------------------------------------------------------------------------------------------------
      ],
    );
  }

  void addBudgetChangeDescription(String budgetDesctiption) {
    var budgetDiscArray =
        Firestore.instance.collection("HouseHoldName").document(widget.hhname);
    budgetDiscArray.updateData({
      'Budget changes': FieldValue.arrayUnion([budgetDesctiption]),
    });
  }

  void changeBudget(bool add, int original, int change) {
    Firestore.instance
        .collection('HouseHoldName')
        .document(widget.hhname)
        .updateData({'Budget': add ? original + change : original - change});
  }

  //get amount per change
  int getAmountFromDescription(String desc) {
    String stringAmt = '';
    for (int i = 0; i < desc.length - 1; i++) {
      if ((desc[i] == '&') && (desc[i + 1] == '#')) {
        stringAmt = desc.substring(0, i);
        break;
      }
    }
    return int.parse(stringAmt);
  }

  //get date added
  String getDateFromDescription(String desc) {
    String date = '';
    int firstCheckPoint = 0;
    int counter = 0;
    for (int i = 0; i < desc.length; i++) {
      if ((desc[i] == '&') && (desc[i + 1] == '#')) {
        counter++;
        firstCheckPoint = i;
      }
      if (counter == 2) {
        return desc.substring(firstCheckPoint + 2);
      }
    }
    return date;
  }

  //get description
  String getDescriptionFromDescription(String desc) {
    int firstCheckPoint = 0;
    int secondCheckPoint = 0;
    int counter = 0;
    for (int i = 0; i < desc.length - 1; i++) {
      if (counter == 0 && (desc[i] == '&') && (desc[i + 1] == '#')) {
        counter++;
        firstCheckPoint = i;
      }
      if (counter == 1 && ((desc[i] == '&') && (desc[i + 1] == '#'))) {
        secondCheckPoint = i;
      }
    }
    return desc.substring(firstCheckPoint + 2, secondCheckPoint);
  }

  //get array of string from the list of strings
  getlistOfAmounts(List l) {
    List l2 = new List();
    String tempString;
    for (String x in l) {
      tempString = getAmountFromDescription(x).toString();
      l2.add(tempString);
    }
    return l2;
  }

  //get array of string from the list of strings
  getlistOfDescriptions(List l) {
    List l2 = new List();
    String tempString;
    for (String x in l) {
      tempString = getDescriptionFromDescription(x);
      l2.add(tempString);
    }
    return l2;
  }

  //get array of string from the list of strings
  getlistOfDates(List l) {
    List l2 = new List();
    String tempString;
    for (String x in l) {
      tempString = getDateFromDescription(x);
      l2.add(tempString);
    }
    return l2;
  }
}

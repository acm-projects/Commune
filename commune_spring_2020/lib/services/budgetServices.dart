class budgetServices{
  String hhname,uid;

  //get amount per change
  double getAmountFromDescription(String desc) {
    String stringAmt = '';
    for (int i = 0; i < desc.length - 1; i++) {
      if ((desc[i] == '&') && (desc[i + 1] == '#')) {
        stringAmt = desc.substring(0, i);
        break;
      }
    }
    return double.parse(stringAmt);
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
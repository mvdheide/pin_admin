// import 'dart:collection';

// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:pin_admin/Util/dataProvider.dart';
import 'package:pin_admin/models/textFieldModel.dart';
// import 'package:provider/provider.dart';

class OverViewModel extends ChangeNotifier {
  int _clickedDetailID = -1;
  static const int PHONE_MODE = 1;
  static const int TABLET_MODE = 2;

  // String _str1 = "";
  // String _str2 = "";
  // String _str3 = "";

  List<List<String>> _overviewList = [];

  List<String> _dbColumns = [
    "displayName",
    "plaats",
    "tmsNR",
    "shopNR",
    "kassanum",
    "_id"
  ];

  List<List<String>> get overviewItems => _overviewList;

  int get overviewCount => _overviewList.length;

  int get getclickedDetailID => _clickedDetailID;

  void showDetails(int idPAram) {
    _clickedDetailID = idPAram;
    notifyListeners();
  }

  // void changedText(String str1, String str2, String str3) {
  //   _str1 = str1;
  //   _str2 = str2;
  //   _str3 = str3;
  //   _updateOverviewList();
  // }

  // void setPlaceTextField(String placeString) {
  //   _str2 = placeString;
  //   notifyListeners();
  // }

  Future<List<List<String>>> updateOverviewList(
      textFieldValues, int lastButtonClicked, bool asc) async {
    var dbList = await DataProvider.db.getOverviewList(
        textFieldValues[TextFieldModel.SHOP_TEXTFIELD],
        textFieldValues[TextFieldModel.PLACE_TEXTFIELD],
        textFieldValues[TextFieldModel.TMS_TEXTFIELD],
        lastButtonClicked,
        asc);

    _overviewList = dbList
        .map((item) => [
              item[_dbColumns[0]].toString(),
              item[_dbColumns[1]].toString(),
              item[_dbColumns[2]].toString(),
              item[_dbColumns[3]].toString(),
              item[_dbColumns[4]].toString(),
              item[_dbColumns[5]].toString(),
            ])
        .toList();
    // notifyListeners();
    return _overviewList;
  }
}

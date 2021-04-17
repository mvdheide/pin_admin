import 'package:flutter/material.dart';
import 'package:pin_admin/Util/dataProvider.dart';
import 'package:pin_admin/Util/dbLayout.dart';
import 'package:pin_admin/models/textFieldModel.dart';

class OverViewModel extends ChangeNotifier {
  int _clickedDetailID = -1;
  static const int PHONE_MODE = 1;
  static const int TABLET_MODE = 2;

  List<List<String>> _overviewList = [];

//----------------------------------------------------------------------------//

  List<List<String>> get overviewItems => _overviewList;

//----------------------------------------------------------------------------//

  int get overviewCount => _overviewList.length;

//----------------------------------------------------------------------------//

  int get getclickedDetailID => _clickedDetailID;

//----------------------------------------------------------------------------//

  void showDetails(int idPAram) {
    _clickedDetailID = idPAram;
    notifyListeners();
  }

//----------------------------------------------------------------------------//

  Future<List<List<String>>> updateOverviewList(
      textFieldValues, int lastButtonClicked, bool asc) async {
    var dbList = await DataProvider.db.getOverviewList(
        textFieldValues[TextFieldModel.SHOP_TEXTFIELD],
        textFieldValues[TextFieldModel.PLACE_TEXTFIELD],
        textFieldValues[TextFieldModel.TMS_TEXTFIELD],
        lastButtonClicked,
        asc);
    _overviewList = dbList
        .map(
          (item) => [
            item[DBColumns.getShopColumnName()].toString(),
            item[DBColumns.getPlaceColumnName()].toString(),
            item[DBColumns.getTMSColumnName()].toString(),
            item[DBColumns.getShopNRColumnName()].toString(),
            item[DBColumns.getKassaNRColumnName()].toString(),
            item[DBColumns.idColumnName].toString(),
          ],
        )
        .toList();

    return _overviewList;
  }

//----------------------------------------------------------------------------//

}

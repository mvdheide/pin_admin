import 'package:pin_admin/Util/dbLayout.dart';

class DetailModel {
  List<_DetailCard> _detailCards = [];

  DetailModel(List<bool> defaultExpandCategory) {
    int nrOfCategory = DBColumns.categoryTitle.length;
    for (var i = 0; i < nrOfCategory; i++) {
      _detailCards.add(
        _DetailCard(
            DBColumns.categoryTitle[i],
            DBColumns.getDetailDescPerCategory(i)
                .map((descr) => descr + ":")
                .toList(),
            defaultExpandCategory[i]),
      );
    }
  }

  String getGroupValue(int tileNRParam) => _detailCards[tileNRParam].groupValue;

  bool getIsExanded(int tileNRParam) => _detailCards[tileNRParam].isExpanded;

  List<String>? getDataList(int tileNRParam) =>
      _detailCards[tileNRParam].dataList;

  List<String> getDescrList(int tileNRParam) =>
      _detailCards[tileNRParam].descriptionsList;

  void setIsExanded(int tileNRParam, bool isExandedBool) {
    _detailCards[tileNRParam].isExpanded = isExandedBool;
  }

  void setData(var item) {
    int nrOfCategory = DBColumns.categoryTitle.length;
    for (var i = 0; i < nrOfCategory; i++) {
      _detailCards[i].setDataList(
        DBColumns.getDetailColumnNamePerCategory(i)
            .map(
              (columnName) => item[columnName].toString(),
            )
            .toList(),
      );
    }
  }
}

class _DetailCard {
  String groupValue;
  String? descriptionValue;
  List<String> descriptionsList;
  List<String>? dataList;
  bool isExpanded;

//----------------------------------------------------------------------------//

  _DetailCard(
    this.groupValue,
    this.descriptionsList,
    this.isExpanded,
  );

//----------------------------------------------------------------------------//

  void setDataList(List<String> dataParam) {
    dataList = dataParam;
  }

//----------------------------------------------------------------------------//

}

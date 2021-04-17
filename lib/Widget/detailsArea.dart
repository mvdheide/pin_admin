import 'package:flutter/material.dart';

import 'package:pin_admin/Util/dataProvider.dart';
import 'package:pin_admin/models/detailModel.dart';
import 'package:pin_admin/models/overViewModel.dart';
import 'package:provider/provider.dart';

class DetailsArea extends StatelessWidget {
  final Color? textColor;
  final List<bool> defaultExpandCategory = [true, false, true, false, false];

  DetailsArea({
    required this.textColor,
  });

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    print("detailArea - Build start");
    return Provider<DetailModel>(
      create: (_) => DetailModel(defaultExpandCategory),
// dispose needed ?
      child: Consumer<OverViewModel>(
        builder: (context, model, chld) {
          return model.getclickedDetailID == -1
              ? Center(child: Text("selecteer aan de linker kant een item"))
              : FutureBuilder<List<Map<String, Object?>>>(
                  future: DataProvider.db.getDetails(model.getclickedDetailID),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print("detailArea - start future");
                      final item = snapshot.data![0];
                      Provider.of<DetailModel>(context, listen: false)
                          .setData(item);
                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView(
                                children: [
                                  getDetailTile(0, context),
                                  getDetailTile(1, context),
                                  getDetailTile(2, context),
                                  getDetailTile(3, context),
                                  getDetailTile(4, context),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
        },
      ),
    );
  }

//----------------------------------------------------------------------------//

  Widget getDetailTile(int tileNRParam, BuildContext context) {
    return ExpansionTile(
      title: Text(
        Provider.of<DetailModel>(context, listen: false)
            .getGroupValue(tileNRParam),
        style: TextStyle(
          fontSize: 20.0,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      initiallyExpanded: Provider.of<DetailModel>(context, listen: false)
          .getIsExanded(tileNRParam),
      trailing: (Provider.of<DetailModel>(context, listen: false)
                  .getIsExanded(tileNRParam) ==
              true)
          ? Icon(Icons.arrow_drop_down, size: 32, color: textColor)
          : Icon(Icons.arrow_drop_up, size: 32, color: textColor),
      onExpansionChanged: (value) {
        Provider.of<DetailModel>(context, listen: false)
            .setIsExanded(tileNRParam, value);
      },
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            title: getDetailItemData(tileNRParam, context),
          ),
        ),
      ],
    );
  }

//----------------------------------------------------------------------------//
  Column getDetailItemData(int tileNRParam, BuildContext context) {
    var dataList = Provider.of<DetailModel>(context, listen: false)
        .getDataList(tileNRParam)!;
    var descriptionsList = Provider.of<DetailModel>(context, listen: false)
        .getDescrList(tileNRParam);
    var listlength = dataList.length;
    List<Row> rowList = [];
    for (int i = 0; i < listlength; i++) {
      rowList.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text(descriptionsList[i]), flex: 12),
            Expanded(child: Text(dataList[i]), flex: 15),
          ],
        ),
      );
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: rowList);
  }

//----------------------------------------------------------------------------//

}

import 'package:flutter/material.dart';
import 'package:pin_admin/Widget/backgroundWidget.dart';
import 'package:pin_admin/Widget/detailsArea.dart';
import 'package:pin_admin/models/overViewModel.dart';
import 'package:provider/provider.dart';

class PhoneDetailPage extends StatelessWidget {
  final changeNotifierProvider;
  PhoneDetailPage(this.changeNotifierProvider);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OverViewModel>.value(
        value: changeNotifierProvider,
        child: BackgroundWidget(
          title: 'PinAdmin gegevens',
          childWidget: Container(
            alignment: Alignment.topLeft,
            // width: 2 * MediaQuery.of(context).size.width / 5,
            // color: Theme.of(context).primaryColor,
            child: DetailsArea(
              // phoneDetailID: detailID,
              textColor: Theme.of(context).textTheme.bodyText2.color,
            ),
          ),
        ));
  }
}

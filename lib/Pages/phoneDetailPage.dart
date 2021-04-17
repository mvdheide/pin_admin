import 'package:flutter/material.dart';
import 'package:pin_admin/Widget/scaffoldTemplate.dart';
import 'package:pin_admin/Widget/detailsArea.dart';
import 'package:pin_admin/models/overViewModel.dart';
import 'package:provider/provider.dart';

/// In this class
class PhoneDetailPage extends StatelessWidget {
  final changeNotifierProvider;
  PhoneDetailPage(this.changeNotifierProvider);

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OverViewModel>.value(
      value: changeNotifierProvider,
      child: ScaffoldTemplate(
        title: 'PinAdmin gegevens',
        childWidget: Container(
          alignment: Alignment.topLeft,
          child: DetailsArea(
            textColor: Theme.of(context).textTheme.bodyText2!.color,
          ),
        ),
      ),
    );
  }

//----------------------------------------------------------------------------//

}

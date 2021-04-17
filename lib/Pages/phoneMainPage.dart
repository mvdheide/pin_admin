import 'package:flutter/material.dart';
import 'package:pin_admin/Widget/filterTextArea.dart';
import 'package:pin_admin/Widget/headerButtonArea.dart';
import 'package:pin_admin/Widget/overviewListArea.dart';
import 'package:pin_admin/models/textFieldModel.dart';

class PhoneMainPage extends StatelessWidget {
//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Column(
              children: [
                // child: Padding(
                // padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                FilterTextArea(
                  textfieldNr: TextFieldModel.PLACE_TEXTFIELD,
                  useGPSIcon: true,
                ),
                FilterTextArea(
                    textfieldNr: TextFieldModel.SHOP_TEXTFIELD,
                    useGPSIcon: false),
                FilterTextArea(
                  textfieldNr: TextFieldModel.TMS_TEXTFIELD,
                  useNumericKeys: true,
                ),
                // Divider(),
                HeaderButtonRow(
                    backGroundColor: Theme.of(context).primaryColor),
                OverViewListArea.phone(),
              ],
            ),
          ),
        ),
      ],
    );
  }

//----------------------------------------------------------------------------//

}

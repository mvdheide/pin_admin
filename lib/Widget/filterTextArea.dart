import 'package:flutter/material.dart';
import 'package:pin_admin/Util/GPSProvider.dart';
import 'package:pin_admin/models/textFieldModel.dart';
import 'package:provider/provider.dart';

class FilterTextArea extends StatelessWidget {
  final int textfieldNr;
  final bool useGPSIcon;
  final bool useNumericKeys;

//----------------------------------------------------------------------------//

  FilterTextArea(
      {Key? key,
      required this.textfieldNr,
      this.useGPSIcon = false,
      this.useNumericKeys = false})
      : super(key: key);

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<TextFieldModel>(context, listen: false);

    String label = model.getLabel(textfieldNr);
    print("TextField $label - build start");
    return Padding(
      padding: const EdgeInsets.only(
          // left: 8.0, right: 8.0,
          bottom: 8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          leading: Icon(Icons.search),
          title: TextField(
            keyboardType:
                useNumericKeys ? TextInputType.number : TextInputType.name,
            controller: model.getController(textfieldNr),
            decoration: new InputDecoration(
              // hintText: hintParam,
              border: InputBorder.none,
              labelText: label,
            ),
            onChanged: (value) {
              model.changedText();
            },
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: getIconButtons(model, textfieldNr, useGPSIcon),
          ),
        ),
      ),
    );
  }
}

//----------------------------------------------------------------------------//

List<Widget> getIconButtons(model, textfieldNr, gps) {
  List<Widget> iconButtons = [];
  if (gps) {
    iconButtons.add(
      IconButton(
        icon: Icon(Icons.gps_fixed_rounded),
        onPressed: () {
          fillInGPSPlace(model);
        },
      ),
    );
  }
  iconButtons.add(
    IconButton(
      icon: Icon(Icons.cancel),
      onPressed: () {
        model.clearTextField(textfieldNr);
      },
    ),
  );

  return iconButtons;
}

//----------------------------------------------------------------------------//

void fillInGPSPlace(TextFieldModel model) {
  GPSProvider.getLocation().then(
    (placeMark) {
      model.fillInText(TextFieldModel.PLACE_TEXTFIELD, placeMark[0].locality!);
    },
  );

//----------------------------------------------------------------------------//
}

// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:pin_admin/Util/GPSProvider.dart';
// import 'package:pin_admin/Util/sharedPrefProvider.dart';
import 'package:pin_admin/models/textFieldModel.dart';
import 'package:provider/provider.dart';

class FilterTextArea extends StatelessWidget {
  final int textfieldNr;
  final bool useGPSIcon;

  FilterTextArea({Key key, @required this.textfieldNr, this.useGPSIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<TextFieldModel>(context, listen: false);

    String label = model.getLabel(textfieldNr);
    print("TextField $label - build start");
    return Padding(
      padding: const EdgeInsets.only(
          // left: 8.0, right: 8.0,
          bottom: 8.0), //const EdgeInsets.all(8.0),
      child: Container(
        // color: Theme.of(context).cardColor,
        height: 60,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          leading: Icon(Icons.search),
          title: TextField(
            // keyboardType: TextInputType.number,
            controller: model.getController(textfieldNr),
            decoration: new InputDecoration(
              // hintText: hintParam,
              border: InputBorder.none,
              labelText: label,
            ),
            onChanged: (value) {
              model.changedText();
              // setState(() {});
              // _counterBarKey.currentState.updateCounterBar(overviewItemCount);
            },
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: getIconButtons(model, textfieldNr, useGPSIcon),
          ),
        ),
      ),
    );
    // Padding(
    //   padding: padje,
    //   child: TextField(
    //     controller: shopController,
    //     onChanged: (value) {
    //       setState(() {});

    //       // _filterList(value);
    //     },
    //     decoration: InputDecoration(hintText: "Winkel"),
    //   ),
    // ),
  }
}

List<Widget> getIconButtons(model, textfieldNr, gps) {
  List<Widget> iconButtons = [];
  if (gps) {
    iconButtons.add(IconButton(
      icon: Icon(Icons.gps_fixed_rounded),
      onPressed: () {
        fillInGPSPlace(model);
      },
    ));
  }

  iconButtons.add(
    IconButton(
      icon: Icon(Icons.cancel),
      onPressed: () {
        model.clearTextField(textfieldNr);
        // model.changedText(shopController.text, placeController.text,
        //     tmsController.text);
        // _counterBarKey.currentState.updateCounterBar(overviewItemCount);
      },
    ),
  );

  return iconButtons;
}

void fillInGPSPlace(TextFieldModel model) {
  // SharedPrefProvider.prefs.getUseGPS().then((useGPS) {
  //   if (useGPS) {
  GPSProvider.getLocation().then(
    (placeMark) {
      model.fillInText(TextFieldModel.PLACE_TEXTFIELD, placeMark[0].locality);
      // setState(() {
      //   placeController.text = placeMark[0].locality;
      // });
      // print("end gps");
    },
  );
  // print("gps en door");
}
// }
// );
// }

//   final Function function;

//   FilterTextArea({Key key, this.function}) : super(key: key);

//   @override
//  FilterTextAreaState createState() => FilterTextAreaState();
// }

// class FilterTextAreaState extends State<FilterTextArea> {

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padje, //const EdgeInsets.all(8.0),
//       child: Container(
//         // color: Theme.of(context).cardColor,
//         height: 60,
//         decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: BorderRadius.all(Radius.circular(8))),
//         child: ListTile(
//           leading: Icon(Icons.search),
//           title: TextField(
//             controller: controllerParam,
//             decoration: new InputDecoration(
//               // hintText: hintParam,
//               border: InputBorder.none,
//               labelText: hintParam,
//             ),
//             onChanged: (value) {
//               setState(() {});
//               // _counterBarKey.currentState.updateCounterBar(overviewItemCount);
//             },
//           ),
//           trailing: IconButton(
//             icon: Icon(Icons.cancel),
//             onPressed: () {
//               controllerParam.clear();
//               setState(() {});
//               // _counterBarKey.currentState.updateCounterBar(overviewItemCount);
//             },
//           ),
//         ),
//       ),
//     );
//     // Padding(
//     //   padding: padje,
//     //   child: TextField(
//     //     controller: shopController,
//     //     onChanged: (value) {
//     //       setState(() {});

//     //       // _filterList(value);
//     //     },
//     //     decoration: InputDecoration(hintText: "Winkel"),
//     //   ),
//     // ),
//   }
// }

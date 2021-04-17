import 'package:flutter/material.dart';

class TextFieldModel extends ChangeNotifier {
  static const int SHOP_TEXTFIELD = 0;
  static const int PLACE_TEXTFIELD = 1;
  static const int TMS_TEXTFIELD = 2;

  List<String> textfieldLabels = ["Winkel", "Plaats", "TMS nummer"];

  List<TextEditingController> textFieldController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

//----------------------------------------------------------------------------//

  TextEditingController getController(int textfieldNr) =>
      textFieldController[textfieldNr];

//----------------------------------------------------------------------------//

  String getLabel(int textfieldNr) {
    return textfieldLabels[textfieldNr];
  }

//----------------------------------------------------------------------------//

  void clearTextField(int textfieldNr) {
    textFieldController[textfieldNr].clear();
    notifyListeners();
  }

//----------------------------------------------------------------------------//

  void fillInText(int textfieldNr, String newValue) {
    textFieldController[textfieldNr].text = newValue;
    notifyListeners();
  }

//----------------------------------------------------------------------------//

  void changedText() {
    notifyListeners();
  }

//----------------------------------------------------------------------------//

  List<String> getAllTextFieldValues() {
    return textFieldController
        .map((controller) => controller.text.toString())
        .toList();
  }

//----------------------------------------------------------------------------//

  void disposeControllers() {
    textFieldController[0].dispose();
    textFieldController[1].dispose();
    textFieldController[2].dispose();
  }

//----------------------------------------------------------------------------//

}

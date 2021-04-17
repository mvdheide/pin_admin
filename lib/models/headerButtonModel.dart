import 'package:flutter/material.dart';

class HeaderButtonModel extends ChangeNotifier {
  int _lastClickedButton = 0;
  bool _ascending = true;

  bool get getAscending => _ascending;
  int get getLastClickedButton => _lastClickedButton;

  List<String> _buttonTitles = ["Winkel", "Plaats", "TMS#", "s#", "k#"];

//----------------------------------------------------------------------------//

  String getHeaderButtonTitle(buttonNR) {
    return _buttonTitles[buttonNR];
  }

//----------------------------------------------------------------------------//

  void setHeaderClicked(int _clickedButtonParam) {
    if (_clickedButtonParam == _lastClickedButton) {
      _ascending = !_ascending;
    } else {
      _ascending = true;
      _lastClickedButton = _clickedButtonParam;
    }
    notifyListeners();
  }

//----------------------------------------------------------------------------//

  Icon? getIconHeaderButton(int buttonNR) {
    return buttonNR == _lastClickedButton
        ? (Icon(_ascending ? Icons.arrow_drop_up : Icons.arrow_drop_down))
        : null;
  }

//----------------------------------------------------------------------------//

}

import 'dart:async';

import 'package:pin_admin/models/overViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// this class provides access to the settings.
/// it can be accessed by [SettingsProvider.settings.method()]
class SettingsProvider {
  SettingsProvider._();
  static final SettingsProvider settings = SettingsProvider._();
  _SharedPrefProvider _pref = _SharedPrefProvider();

  /// the options which are displayed in the settings.
  /// The first string is for the tablet Mode,
  /// the second is for the phone mode,
  /// the third is for manual width
  static const List<String?> deviceModusOptions = const [
    'ipad (aangeraden voor >768 pixels)',
    'mobiele telefoon (aangeraden voor <768 pixels)',
    'zelf instellen'
  ];

//----------------------------------------------------------------------------//

  /// Returns if the app is displayed in tablet or in phone mode
  /// ([OverViewModel.TABLET_MODE] or [OverViewModel.PHONE_MODE]).
  /// The [screenWidth] is used when the option for manual width is selected.
  Future<int?> getDeviceModus(double screenWidth) async {
    int? modus;
    int modusWidth = await _pref.getDeviceModusOptions();
    switch (modusWidth) {
      case 0:
        modus = OverViewModel.TABLET_MODE;
        break;
      case 1:
        modus = OverViewModel.PHONE_MODE;
        break;
      case 2:
        double manualWidth = await _pref.getManualDeviceWidth();
        print("screenWidth = $screenWidth, manualWidth = $manualWidth");
        if (screenWidth >= manualWidth) {
          modus = OverViewModel.TABLET_MODE;
        } else {
          modus = OverViewModel.PHONE_MODE;
        }
        break;
      default:
    }
    return modus;
  }

//----------------------------------------------------------------------------//

  Future<String> getUpdateDate() async => _pref.getUpdateDate();

//----------------------------------------------------------------------------//

  // Future<bool> getUseGPS() async => _pref.getUseGPS();
  Future<int> getDeviceModusOptions() async => _pref.getDeviceModusOptions();

//----------------------------------------------------------------------------//

  Future<double> getManualDeviceWidth() async => _pref.getManualDeviceWidth();

//----------------------------------------------------------------------------//

  void setUpdateDate(String formattedDateParam) async {
    _pref.setUpdateDate(formattedDateParam);
  }

//----------------------------------------------------------------------------//

  void setDeviceModus(int deviceModusIndex) async {
    _pref.setDeviceModus(deviceModusIndex);
  }

//----------------------------------------------------------------------------//

  void setManualDeviceWidth(double manualDeviceWidth) async {
    _pref.setManualDeviceWidth(manualDeviceWidth);
  }
}

class _SharedPrefProvider {
  SharedPreferences? _sharedPreferences;

  // final String _useGPSString = 'useGPS';
  // final bool _initUseGPSValue = true;

  final String _updateDateString = 'updateDate';
  final String _initUpdateDateValue = 'not yet';

  final String _deviceModusString = 'deviceType';
  final int _initDeviceModusValue = 0;

  final String _manualDeviceWidthString = 'manualWidth';
  final double _initManualDeviceWidthString = 600;

//----------------------------------------------------------------------------//

  Future<SharedPreferences?> get pref async {
    // if (_sharedPreferences != null) return _sharedPreferences;
    // print("get pref - start");
    // _sharedPreferences = await initPrefs();
    if (_sharedPreferences == null) {
      _sharedPreferences = await initPrefs();
    }
    print("get pref - start");

    return _sharedPreferences;
  }

//----------------------------------------------------------------------------//

  Future<SharedPreferences?> initPrefs() async {
    print("pref - init");
    return SharedPreferences.getInstance();
  }

//----------------------------------------------------------------------------//

  Future<String> getUpdateDate() async {
    // final prefs = await (pref as FutureOr<SharedPreferences?>);
    final prefs = await pref;
    return prefs!.getString(_updateDateString) ?? _initUpdateDateValue;
  }

//----------------------------------------------------------------------------//

  void setUpdateDate(String formattedDateParam) async {
    // final prefs = await (pref as FutureOr<SharedPreferences?>);
    final prefs = await pref;
    prefs!.setString(_updateDateString, formattedDateParam);
  }

//----------------------------------------------------------------------------//

  Future<int> getDeviceModusOptions() async {
    // final prefs = await (pref as FutureOr<SharedPreferences?>);
    final prefs = await pref;
    return prefs!.getInt(_deviceModusString) ?? _initDeviceModusValue;
  }

//----------------------------------------------------------------------------//

  void setDeviceModus(int deviceModusIndex) async {
    // final prefs = await (pref as FutureOr<SharedPreferences?>);
    final prefs = await pref;
    prefs!.setInt(_deviceModusString, deviceModusIndex);
  }

//----------------------------------------------------------------------------//

  Future<double> getManualDeviceWidth() async {
    // final prefs = await (pref as FutureOr<SharedPreferences?>);
    final prefs = await pref;
    return prefs!.getDouble(_manualDeviceWidthString) ??
        _initManualDeviceWidthString;
  }

//----------------------------------------------------------------------------//

  void setManualDeviceWidth(double manualDeviceWidth) async {
    // final prefs = await (pref as FutureOr<SharedPreferences?>);
    final prefs = await pref;
    prefs!.setDouble(_manualDeviceWidthString, manualDeviceWidth);
  }

//----------------------------------------------------------------------------//

  // Future<bool> getUseGPS() async {
  //   final prefs = await pref;
  //   return prefs.getBool(_useGPSString) ?? _initUseGPSValue;
  // }

  // void setUseGPS(bool useGPSParam) async {
  //   final prefs = await pref;
  //   prefs.setBool(_useGPSString, useGPSParam);
  // }

}

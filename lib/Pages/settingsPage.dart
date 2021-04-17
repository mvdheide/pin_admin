import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:pin_admin/Util/dataProvider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pin_admin/Util/settingsProvider.dart';
import 'package:pin_admin/Widget/scaffoldTemplate.dart';

class SettingsPage extends StatefulWidget {
//----------------------------------------------------------------------------//

  @override
  _SettingsPageState createState() => _SettingsPageState();

//----------------------------------------------------------------------------//

}

class _SettingsPageState extends State<SettingsPage> {
  // bool switchValue;
  final DateFormat dateFormatter = DateFormat('HH:mm  EEEE dd MMMM yyyy');
  final double rowHeigth = 40.0;

  String? _dropdownValue;

  double? _currentSliderValue;

//----------------------------------------------------------------------------//

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      title: 'PinAdmin settings',
      childWidget: Column(
        children: [
          _getUpdateRow(),
          Divider(),
          _getDeviceDisplayRow(),
          Divider(),
          // _getUseGPSRow(),
          // Divider(),
        ],
      ),
    );
  }

//----------------------------------------------------------------------------//

  Widget _settingRowTemplete(String descriptionText, Widget valueWidget) {
    return Container(
      height: rowHeigth,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
              ),
              child: Text(descriptionText),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
              ),
              child: valueWidget,
            ),
          ),
        ],
      ),
    );
  }

//----------------------------------------------------------------------------//

  Widget _getUpdateRow() {
    Widget valueWidget = Row(
      children: [
        Expanded(
          flex: 1,
          child: FutureBuilder<String>(
            future: SettingsProvider.settings.getUpdateDate(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!);
              }
              return Text("");
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              startFilePicking(context);
            },
            child: Text("update de database (mabTD.db)"),
          ),
        ),
      ],
    );
    return _settingRowTemplete("Database voor het laast geupdate", valueWidget);
  }

//----------------------------------------------------------------------------//

  Widget _getDeviceDisplayRow() {
    int? savedSelectedOption;
    Widget valueWidget = FutureBuilder<int>(
      future: SettingsProvider.settings.getDeviceModusOptions(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          savedSelectedOption = snapshot.data;
          _dropdownValue =
              SettingsProvider.deviceModusOptions[savedSelectedOption!];
          DropdownButton deviceModusDropDownButton = DropdownButton<String>(
            value: _dropdownValue,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
            ),
            onChanged: (String? newValue) {
              SettingsProvider.settings.setDeviceModus(
                  SettingsProvider.deviceModusOptions.indexOf(newValue));
              print(SettingsProvider.deviceModusOptions.indexOf(newValue));
              setState(
                () {
                  _dropdownValue = newValue;
                },
              );
            },
            items: SettingsProvider.deviceModusOptions
                .map<DropdownMenuItem<String>>(
              (String? value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value!),
                );
              },
            ).toList(),
          );

          return Column(
            children: [
              _settingRowTemplete(
                  "Selecteer de display modus: een tablet modus (2 schermen naast elkaar), telefoon modus (1 scherm per keer), of selecteer een breedte:",
                  deviceModusDropDownButton),
              savedSelectedOption == 2
                  ? Column(
                      children: [
                        Divider(),
                        _getManualWidthRow(),
                      ],
                    )
                  : SizedBox(
                      height: 0,
                      width: 0,
                    )
            ],
          );
        } else {
          return Text("");
        }
      },
    );
    return valueWidget;
  }

//----------------------------------------------------------------------------//

  Widget _getManualWidthRow() {
    Widget valueWidget;
    if (_currentSliderValue == null) {
      valueWidget = FutureBuilder<double>(
        future: SettingsProvider.settings.getManualDeviceWidth(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _currentSliderValue = snapshot.data;
            return getManualSlider();
          } else {
            return Text("");
          }
        },
      );
    } else {
      valueWidget = getManualSlider();
    }
    return _settingRowTemplete(
        "Selecteer de breedte van het scherm waarbij geschakeld wordt tussen tablet en telfoon modus:",
        valueWidget);
  }

//----------------------------------------------------------------------------//

  Slider getManualSlider() {
    return Slider(
      min: 0,
      max: 1000,
      divisions: 50,
      value: _currentSliderValue!,
      label: _currentSliderValue!.round().toString(),
      onChangeEnd: (double value) {
        SettingsProvider.settings.setManualDeviceWidth(value);
        print("end slider: $value");
      },
      onChanged: (double value) {
        setState(
          () {
            _currentSliderValue = value;
          },
        );
      },
    );
  }

//----------------------------------------------------------------------------//

  Future<void> startFilePicking(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      print("bytes: ${result.files.single.size}");
      print("file.lastModifiedSync(): ${file.lastModifiedSync()}");
      var path = await DataProvider.db.getDBPath();
      file.copy(path);
      _showDialog(context);
      String formattedDate = dateFormatter.format(file.lastModifiedSync());
      // print(formatted);
      SettingsProvider.settings.setUpdateDate(formattedDate);
      setState(() {});
    } else {
      // User canceled the picker
      print("cancel");
    }
  }

//----------------------------------------------------------------------------//

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("PinAdmin"),
          content: new Text("Wow, de database is automagisch bijgewerkt..."),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//----------------------------------------------------------------------------//

  // Widget _getUseGPSRow() {
  //   return Container(
  //     height: rowHeigth,
  //     color: Theme.of(context).cardColor,
  //     child: Row(
  //       children: [
  //         Expanded(
  //           flex: 1,
  //           child: Container(
  //             alignment: Alignment.centerLeft,
  //             // color: Colors.amber,
  //             child: Text(
  //               "Vul bij de start van de app de plaats in (GPS)",
  //               overflow: TextOverflow.fade,
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 1,
  //           child: FutureBuilder<bool>(
  //             future: SettingsProvider.settings.getUseGPS(),
  //             builder: (context, snapshot) {
  //               if (snapshot.hasData) {
  //                 print("settings - has data : ${snapshot.data}");
  //                 switchValue = snapshot.data;
  //                 print(switchValue);

  //                 return Container(
  //                   alignment: Alignment.centerLeft,
  //                   // color: Colors.blueAccent,
  //                   child: Switch(
  //                     // activeColor: Colors.blue,
  //                     value: switchValue,
  //                     onChanged: (bool newValue) {
  //                       // SettingsProvider.settings.setUseGPS(newValue);
  //                       setState(() {
  //                         switchValue = newValue;
  //                       });
  //                     },
  //                   ),
  //                 );
  //               }
  //               return Text("gps");
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:pin_admin/Util/dataProvider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var switchValue = true;
  final double rowHeigth = 40.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PinAdmin gegevens'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        color: Theme.of(context).primaryColor, // background color for the app
        child: Column(
          children: [
            _getUpdateRow(),
            Divider(),
            _getUseGPSRow(),
            Divider(),
            _getUseGPSRow()
          ],
        ),
      ),
    );
  }

  Widget _getUpdateRow() {
    return Container(
      height: rowHeigth,
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text("Database voor het laast geupdate"),
          ),
          Expanded(
            flex: 1,
            child: Text("vrijdag 12-12-12"),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                startFilePicking();
              },
              child: Text("update de database (mabTD.db)"),
            ),
          ),
        ],
      ),
    );
  }
  // Container(color:Colors.amber, child:

  Widget _getUseGPSRow() {
    return Container(
      height: rowHeigth,
      color: Theme.of(context).cardColor,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              // color: Colors.amber,
              child: Text(
                "Vul bij de start van de app de plaats in (GPS)",
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              // color: Colors.blueAccent,
              child: Switch(
                // activeColor: Colors.blue,
                value: switchValue,
                onChanged: (bool newValue) {
                  setState(() {
                    switchValue = newValue;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> startFilePicking() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path);

      print("bytes: ${result.files.single.size}");
      print("file path: ${file.path}");

      var path = await DataProvider.db.getDBPath();
      file.copy(path);
      // TODO alert message
      // TODO set date to today
    } else {
      // User canceled the picker
      print("cancel");
    }
  }
}

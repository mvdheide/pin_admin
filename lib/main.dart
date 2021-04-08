import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_admin/Pages/phoneMainPage.dart';
import 'package:pin_admin/Pages/tabletMainPage.dart';
import 'package:pin_admin/Util/settingsProvider.dart';
import 'package:pin_admin/Widget/backgroundWidget.dart'; //rename to ScaffoldTemplate
import 'package:provider/provider.dart';

import 'package:pin_admin/Pages/settingsPage.dart';
import 'package:pin_admin/models/headerButtonModel.dart';
import 'package:pin_admin/models/overViewModel.dart';
import 'package:pin_admin/models/textFieldModel.dart';

void main() => runApp(PinAdminApp());

class PinAdminApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PinAdmin gegevens',
      home: PinAdminForm(),
      theme: ThemeData(
        primaryColor: Color(0xff7ab51d),
        appBarTheme: AppBarTheme(color: Color(0xff007734)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

// Define a custom Form widget.
class PinAdminForm extends StatefulWidget {
  @override
  _PinAdminState createState() => _PinAdminState();
}

class _PinAdminState extends State<PinAdminForm> {
  // final padje = const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    Provider.of<TextFieldModel>(context, listen: false).disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OverViewModel overViewModel = OverViewModel();

    return BackgroundWidget(
      title: 'PinAdmin gegevens',
      actions: getActionIcon(context),
      childWidget: MultiProvider(
        providers: [
          ChangeNotifierProvider<OverViewModel>(create: (_) => overViewModel),
          ChangeNotifierProvider<TextFieldModel>(
            create: (_) => TextFieldModel(),
          ),
          ChangeNotifierProvider<HeaderButtonModel>(
              create: (_) => HeaderButtonModel()),
          // ProxyProvider<TextFieldModel,OverViewModel>(
          //   update: (context,tfModel,ovModel) => ovModel.setText(tfModel.getAllTextFieldValues()),
          //   )
        ],
        child: FutureBuilder<int>(
          future: SettingsProvider.settings
              .getDeviceModus(MediaQuery.of(context).size.width),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              var startPage;
              if (snapShot.data == OverViewModel.TABLET_MODE) {
                startPage = TabletMainPage();
              } else {
                startPage = PhoneMainPage();
              }
              return startPage;
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  List<Widget> getActionIcon(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.settings),
        tooltip: 'Setting Icon',
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()))
              .then((onComeback));
        },
      ), //IconButton
    ];
  }

  FutureOr onComeback(dynamic value) {
    setState(() {});
  }
}

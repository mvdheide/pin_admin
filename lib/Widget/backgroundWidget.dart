import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final String title;
  final Widget childWidget;
  final List<Widget> actions;

  BackgroundWidget(
      {@required this.title, @required this.childWidget, this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PinAdmin settings'),
        actions: actions,
      ),
      body: Container(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
          color: Theme.of(context).primaryColor, // background color for the app
          child: childWidget),
    );
  }
}

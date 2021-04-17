import 'package:flutter/material.dart';

/// This class is a template for the background. It Creates a visual scaffold
/// for material design widgets.
///
/// @MvdH - 03-2021
class ScaffoldTemplate extends StatelessWidget {
  /// The title in the app bar.
  final String title;

  /// the widget(tree) to be placed inside the scaffold widget.
  final Widget childWidget;

  /// The actions field which is passed to the Scaffold actions (the trailing
  /// icon).
  final List<Widget>? actions;

//----------------------------------------------------------------------------//

  /// Constructor for BackgroundWidget. it only sets the fields title,
  /// childWidget en actions.
  ScaffoldTemplate(
      {required this.title, required this.childWidget, this.actions});

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: Container(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
          color: Theme.of(context).primaryColor, // background color for the app
          child: childWidget),
    );
  }

//----------------------------------------------------------------------------//

}

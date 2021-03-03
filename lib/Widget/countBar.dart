import 'package:flutter/material.dart';

class CounterBarPage extends StatefulWidget {
  final Function function;

  CounterBarPage({Key key, this.function}) : super(key: key);

  @override
  CounterBarState createState() => CounterBarState();
}

class CounterBarState extends State<CounterBarPage> {
  int overviewItemCount;
  // var _key;

  // CounterBarState(Key key) {
  //   _key = key;
  // }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("totaal aantal items: $overviewItemCount"),
      // key: _key,
    );
  }

  updateCounterBar(int overviewListViewItemCount) {
    // setState(() {
    overviewItemCount = overviewListViewItemCount;
    // });
  }
}

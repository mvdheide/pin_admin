// import 'package:flutter/material.dart';

// class FilterTextArea extends StatefulWidget {
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
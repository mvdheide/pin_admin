// import 'package:flutter/material.dart';

// import 'package:pin_admin/Util/dataProvider.dart';
// import 'package:pin_admin/main.dart';

// class OverViewListArea extends StatefulWidget {
//   final Function function;

//   OverViewListArea({Key key, this.function}) : super(key: key);

//   @override
//   OverViewListAreaState createState() => OverViewListAreaState();
// }

// class OverViewListAreaState extends State<OverViewListArea> {
//   int overviewItemCount = 0;
//   List<Map> overviewList;
//     int lastClickedButton = 0;
//   bool ascending = true;
//    List<String> buttonTitles = ["Winkel", "Plaats", "TMS#", "s#", "k#"];
//    var overviewColumnflex = [8, 5, 4, 2, 2];

//   @override
//   Widget build(BuildContext context) {
//     final textvalue = ParentProvider.of(context).textFieldText;
//     final textFieldNR = ParentProvider.of(context).textFieldNR;
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//         // color: Theme.of(context).primaryColor,
//         child: Container(
//           decoration: BoxDecoration(
//               color: Theme.of(context).cardColor,
//               borderRadius: BorderRadius.all(Radius.circular(8))),
//           // color: Theme.of(context).cardColor,
//           child: FutureBuilder<List<Map>>(
//             future: DataProvider.db.getOverviewList(
//                 shopController.text,
//                 placeController.text,
//                 tmsController.text,
//                 lastClickedButton,
//                 ascending),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 print("futurebuilder: has data and build listview");
//                 overviewItemCount = snapshot.data.length;

//                 return Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: snapshot.data.length,
//                         itemBuilder: (_, int position) {
//                           final item = snapshot.data[position];
//                           // print(item);
//                           return InkWell(
//                             onTap: () {
//                               // setState(() {
//                               _detailsAreakey.currentState
//                                   .updateDetailsArea(item['_id']);
//                               // _selectedID = item['_id'];
//                               // });

//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //         builder: (context) => Details(item['_id'])));
//                             },
//                             child: Container(
//                               // padding: const EdgeInsets.only(
//                               //     left: 8.0, right: 8.0, bottom: 4.0),

//                               padding: const EdgeInsets.only(bottom: 4.0),
//                               color: Theme.of(context).cardColor,
//                               child:
//                                   // ListTile(
//                                   //   title:
//                                   Column(
//                                 children: <Widget>[
//                                   Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                           flex: overviewColumnflex[0],
//                                           child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 16.0),
//                                               child: Text(item['displayName']
//                                                   .toString()))),
//                                       Expanded(
//                                           flex: overviewColumnflex[1],
//                                           child:
//                                               Text(item['plaats'].toString())),
//                                       Expanded(
//                                           flex: overviewColumnflex[2],
//                                           child:
//                                               Text(item['tmsNR'].toString())),
//                                       Expanded(
//                                           flex: overviewColumnflex[3],
//                                           child:
//                                               Text(item['shopNR'].toString())),
//                                       Expanded(
//                                           flex: overviewColumnflex[4],
//                                           child: Text(
//                                               item['kassanum'].toString())),
//                                     ],
//                                   ),
//                                   Divider(
//                                     color: Colors.grey,
//                                   ),
//                                 ],
//                               ),
//                               // ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     ListTile(
//                       title: Text("totaal aantal items: $overviewItemCount"),
//                     ),
//                   ],
//                 );
//               }
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget getHeaderButtonRow() {
//     return Padding(
//         // color: Theme.of(context).primaryColor,
//         padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//         child: Row(
//           children: <Widget>[
//             getButton(0),
//             getButton(1),
//             getButton(2),
//             getButton(3),
//             getButton(4),
//           ],
//         ));
//   }

//   Widget getButton(int buttonNR) {
//     return Expanded(
//         flex: overviewColumnflex[buttonNR],
//         child: ElevatedButton(
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.resolveWith<Color>(
//               (Set<MaterialState> states) {
//                 return Theme.of(context)
//                     .primaryColor; // Use the component's default.
//               },
//             ),
//           ),
//           child: Align(
//               alignment: Alignment.bottomLeft,
//               child: RichText(
//                 text: TextSpan(
//                   // style: Theme.of(context).textTheme.body1,
//                   children: [
//                     TextSpan(text: buttonTitles[buttonNR]),
//                     WidgetSpan(
//                       child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                           child: buttonNR == lastClickedButton
//                               ? (Icon(ascending
//                                   ? Icons.arrow_drop_up
//                                   : Icons.arrow_drop_down))
//                               : null),
//                     ),
//                   ],
//                 ),
//               )),
//           onPressed: () {
//             buttonClicked(buttonNR);
//           },
//         ));
//   }

//   void buttonClicked(int buttonNowClicked) {
//     if (buttonNowClicked == lastClickedButton) {
//       ascending = !ascending;
//     } else {
//       ascending = true;
//       lastClickedButton = buttonNowClicked;
//     }
//     setState(() {});
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:pin_admin/Util/GPSProvider.dart';
// import 'package:pin_admin/Widget/overviewListArea.dart';
import 'package:pin_admin/Pages/settingsPage.dart';
import 'package:pin_admin/Widget/pinpadArea.dart';

import 'Util/dataProvider.dart';

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

// Define a corresponding State class.
// This class holds the data related to the Form.
class _PinAdminState extends State<PinAdminForm> {
  _PinAdminState() {
    print("start gps");

    GPSProvider.getLocation().then((placeMark) {
      setState(() {
        placeController.text = placeMark[0].locality;
      });

      print("end gps");
    });
    print("gps en door");
  }
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final shopController = TextEditingController();
  final placeController = TextEditingController();
  final tmsController = TextEditingController();
  // var textFieldValue = ["", "", ""];
  // var textFieldLabel = ["Winkel", "Plaats", "TMS nummer"];
  var overviewColumnflex = [8, 5, 4, 2, 2];
  // SettingsPage settingsPage;

  List<String> buttonTitles = ["Winkel", "Plaats", "TMS#", "s#", "k#"];
  List<Icon> buttonIcons = [Icon(Icons.arrow_drop_up), null, null, null, null];

  // final _displayList = <Details>[];
  // final _fullList = <Details>[];

  final padje = const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0);
  // List<Map> overviewList;
  // int overviewItemCount;

  int lastClickedButton = 0;
  bool ascending = true;

  // final GlobalKey<CounterBarState> _counterBarKey = GlobalKey();
  final GlobalKey<DetailsAreaState> _detailsAreakey = GlobalKey();
  // String shopGPSString = "";
  // String placeGPSString = "";

  // @override
  // void initState() {

  //   super.initState();
  // }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    shopController.dispose();
    placeController.dispose();
    tmsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // placeController.text = placeGPSString;
    return Scaffold(
        appBar: AppBar(
          title: Text('PinAdmin gegevens'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Setting Icon',
              onPressed: () {
                // Navigator.push(context, SettingsPage());
                // settingsIconPressed();
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SettingsPage()))
                    .then((onComeback));
              },
            ), //IconButton
          ], //<Widget>[]
        ),
        body: Container(
            color:
                Theme.of(context).primaryColor, // background color for the app
            child: Row(children: [
              Expanded(
                child: Container(
                  width: 3 * MediaQuery.of(context).size.width / 5,
                  // height: MediaQuery.of(context).size.height,
                  //alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      getSearchTextField("", shopController),
                      getSearchTextField("", placeController),
                      getSearchTextField("", tmsController),
                      Divider(),
                      // OverViewListArea(),
                      getHeaderButtonRow(),
                      getOverviewListView(),
                      // OverViewListArea(),
                      // CounterBarPage(
                      //   key: _counterBarKey,
                      //   // function: updateCounterBar,
                      // ),
                      // ),
                      // getTotalBar(),
                    ],
                  ),
                ),
              ),
              // Divider(),
              VerticalDivider(),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  width: 2 * MediaQuery.of(context).size.width / 5,
                  // color: Theme.of(context).primaryColor,
                  child: DetailsArea(
                    key: _detailsAreakey,
                  ),
                ),
              ),
              // Column(children: [Expanded(child: getDetailTree())])),
            ])));
  }

  // void settingsIconPressed() {
  //   Navigator.push(context, SettingsPage()).then((onComeback));
  // }

  FutureOr onComeback(dynamic value) {
    setState(() {});
  }

  Widget getSearchTextField(
      String hintParam, TextEditingController controllerParam) {
    return Padding(
      padding: padje, //const EdgeInsets.all(8.0),
      child: Container(
        // color: Theme.of(context).cardColor,
        height: 60,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          leading: Icon(Icons.search),
          title: TextField(
            controller: controllerParam,
            decoration: new InputDecoration(
              // hintText: hintParam,
              border: InputBorder.none,
              labelText: hintParam,
            ),
            onChanged: (value) {
              setState(() {});
              // _counterBarKey.currentState.updateCounterBar(overviewItemCount);
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              controllerParam.clear();
              setState(() {});
              // _counterBarKey.currentState.updateCounterBar(overviewItemCount);
            },
          ),
        ),
      ),
    );
    // Padding(
    //   padding: padje,
    //   child: TextField(
    //     controller: shopController,
    //     onChanged: (value) {
    //       setState(() {});

    //       // _filterList(value);
    //     },
    //     decoration: InputDecoration(hintText: "Winkel"),
    //   ),
    // ),
  }

  Widget getHeaderButtonRow() {
    return Padding(
        // color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          children: <Widget>[
            getButton(0),
            getButton(1),
            getButton(2),
            getButton(3),
            getButton(4),
          ],
        ));
  }

  Widget getButton(int buttonNR) {
    return Expanded(
        flex: overviewColumnflex[buttonNR],
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Theme.of(context)
                    .primaryColor; // Use the component's default.
              },
            ),
          ),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: RichText(
                text: TextSpan(
                  // style: Theme.of(context).textTheme.body1,
                  children: [
                    TextSpan(text: buttonTitles[buttonNR]),
                    WidgetSpan(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: buttonNR == lastClickedButton
                              ? (Icon(ascending
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down))
                              : null),
                    ),
                  ],
                ),
              )),
          onPressed: () {
            buttonClicked(buttonNR);
          },
        ));
  }

  void buttonClicked(int buttonNowClicked) {
    if (buttonNowClicked == lastClickedButton) {
      ascending = !ascending;
    } else {
      ascending = true;
      lastClickedButton = buttonNowClicked;
    }
    setState(() {});
  }

  Widget getOverviewListView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        // color: Theme.of(context).primaryColor,
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          // color: Theme.of(context).cardColor,
          child: FutureBuilder<List<Map>>(
            future: DataProvider.db.getOverviewList(
                shopController.text,
                placeController.text,
                tmsController.text,
                lastClickedButton,
                ascending),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("futurebuilder: has data and build listview");
                int overviewItemCount = snapshot.data.length;

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, int position) {
                          final item = snapshot.data[position];
                          // print(item);
                          return InkWell(
                            onTap: () {
                              // setState(() {
                              _detailsAreakey.currentState
                                  .updateDetailsArea(item['_id']);
                              // _selectedID = item['_id'];
                              // });

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Details(item['_id'])));
                            },
                            child: Container(
                              // padding: const EdgeInsets.only(
                              //     left: 8.0, right: 8.0, bottom: 4.0),

                              padding: const EdgeInsets.only(bottom: 4.0),
                              color: Theme.of(context).cardColor,
                              child:
                                  // ListTile(
                                  //   title:
                                  Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: overviewColumnflex[0],
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: Text(item['displayName']
                                                  .toString()))),
                                      Expanded(
                                          flex: overviewColumnflex[1],
                                          child:
                                              Text(item['plaats'].toString())),
                                      Expanded(
                                          flex: overviewColumnflex[2],
                                          child:
                                              Text(item['tmsNR'].toString())),
                                      Expanded(
                                          flex: overviewColumnflex[3],
                                          child:
                                              Text(item['shopNR'].toString())),
                                      Expanded(
                                          flex: overviewColumnflex[4],
                                          child: Text(
                                              item['kassanum'].toString())),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              // ),
                            ),
                          );
                        },
                      ),
                    ),
                    ListTile(
                      title: Text("totaal aantal items: $overviewItemCount"),
                    ),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
  // Widget getTotalBar() {
  //   return ListTile(
  //     title: Text("totaal aantal items: $overviewItemCount"),
  //   );
  // }

  // Widget getDetailTree() {

  //   return _selectedID == -1
  //       ? Center(child: Text("selecteer aan de linker kant een item"))
  //       : SingleChildScrollView(
  //           child: Container(
  //               padding: const EdgeInsets.only(left: 8.0, right: 8.0),
  //               color: Theme.of(context).primaryColor,
  //               child: FutureBuilder<List<Map<String, dynamic>>>(
  //                   future: DataProvider.db.getDetails(_selectedID),
  //                   builder: (context, snapshot) {
  //                     if (snapshot.hasData) {
  //                       final item = snapshot.data[0];

  //                       _detailCards[0].setDataList(
  //                         [
  //                           item['HoofdkantoorNaam'].toString(),
  //                           item['displayName'].toString(),
  //                           item['plaats'].toString(),
  //                           item['telefoon'].toString(),
  //                           item['kassanum'].toString(),
  //                           item['typebetaal1'].toString(),
  //                           item['tmsNR'].toString(),
  //                         ],
  //                       );

  //                       _detailCards[1].setDataList(
  //                         [
  //                           item['adres'].toString(),
  //                           item['postcode'].toString(),
  //                           item['plaats'].toString(),
  //                           item['telefoon'].toString(),
  //                         ],
  //                       );

  //                       _detailCards[2].setDataList(
  //                         [
  //                           item['nuaadres'].toString(),
  //                           item['MASK'].toString(),
  //                           item['GW'].toString(),
  //                           item['datacommadre'].toString(),
  //                           item['MAC'].toString(),
  //                         ],
  //                       );
  //                       _detailCards[3].setDataList(
  //                         [
  //                           item['betaalauto'].toString(),
  //                           item['TID'].toString(),
  //                           item['TIDAWL'].toString(),
  //                           item['MerchantID'].toString(),
  //                         ],
  //                       );
  //                       _detailCards[4].setDataList(
  //                         [
  //                           item['PUKGSM'].toString(),
  //                           item['CertCode'].toString(),
  //                           item['datuminstall'].toString(),
  //                           item['Installatie'].toString(),
  //                           item['InstallatieDatum'].toString(),
  //                           item['Euro_Install_Num'].toString(),
  //                           item['Euro_Opmerkingen'].toString(),
  //                           item['pinpadserie'].toString(),
  //                           item['Portnumber'].toString(),
  //                           item['verkooppuntc'].toString(),
  //                         ],
  //                       );

  //                       return ExpansionPanelList(
  //                           expansionCallback: (int index, bool isExpanded) {
  //                             setState(() {
  //                               _detailCards[index].isExpanded = !isExpanded;
  //                             });
  //                           },
  //                           children: _detailCards
  //                               .map<ExpansionPanel>((DetailCard detailCard) {
  //                             return ExpansionPanel(
  //                               canTapOnHeader: true,
  //                               headerBuilder:
  //                                   (BuildContext context, bool isExpanded) {
  //                                 return ListTile(
  //                                     title: Text(
  //                                   detailCard.groupValue,
  //                                   style: TextStyle(
  //                                     fontSize: 20.0,
  //                                     // color: Colors.green,
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                                 ));
  //                               },
  //                               body: Padding(
  //                                   padding: const EdgeInsets.only(bottom: 8.0),
  //                                   child: ListTile(
  //                                     // title: Align(
  //                                     // child:
  //                                     title: detailCard.getDetailItemData(),
  //                                     // alignment: Alignment.topLeft,
  //                                     // )
  //                                   )),
  //                               isExpanded: detailCard.isExpanded,
  //                             );
  //                           }).toList());
  //                     }
  //                     return Center(
  //                       child: CircularProgressIndicator(),
  //                     );
  //                   })));
  //   // ]));
  // }

}

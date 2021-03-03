import 'package:flutter/material.dart';

import 'package:pin_admin/Util/dataProvider.dart';

class DetailsArea extends StatefulWidget {
  final Function function;

  DetailsArea({Key key, this.function}) : super(key: key);

  @override
  DetailsAreaState createState() => DetailsAreaState();
}

class DetailsAreaState extends State<DetailsArea> {
  int _selectedID = -1;

  List<_DetailCard> _detailCards = [
    _DetailCard(
        "Algemene Gegevens",
        [
          "Hoofdkantoor:",
          "naam:",
          "plaats:",
          "shop nr:",
          "kassa nr:",
          "pinpad soort:",
          "TMS nr:"
        ],
        true),
    _DetailCard(
        "Contact Gegevens",
        [
          "adres:",
          "postcode:",
          "plaats:",
          "telefoon:",
        ],
        false),
    _DetailCard(
        "Verbinding Gegevens",
        [
          "ip:",
          "subnetmask:",
          "gateway:",
          "netwerk profiel:",
          "MAC address:",
        ],
        false),
    _DetailCard(
      "Contract Gegevens",
      [
        "TID Equens:",
        "TID CCV:",
        "TIDAWL:",
        "MerchantID:",
      ],
      false,
    ),
    _DetailCard(
      "Overige Gegevens",
      [
        "PUK GSM:",
        "CertCode:",
        "datum install:",
        "Installatie:",
        "InstallatieDatum:",
        "Euro_Install_Num:",
        "Euro_Opmerkingen:",
        "pinpadserie:",
        "Portnumber:",
        "verkooppuntc:",
      ],
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _selectedID == -1
        ? Center(child: Text("selecteer aan de linker kant een item"))
        : Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            // color: Theme.of(context).primaryColor,
            child: FutureBuilder<List<Map<String, dynamic>>>(
                future: DataProvider.db.getDetails(_selectedID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final item = snapshot.data[0];

                    _detailCards[0].setDataList(
                      [
                        item['HoofdkantoorNaam'].toString(),
                        item['displayName'].toString(),
                        item['plaats'].toString(),
                        item['telefoon'].toString(),
                        item['kassanum'].toString(),
                        item['typebetaal1'].toString(),
                        item['tmsNR'].toString(),
                      ],
                    );

                    _detailCards[1].setDataList(
                      [
                        item['adres'].toString(),
                        item['postcode'].toString(),
                        item['plaats'].toString(),
                        item['telefoon'].toString(),
                      ],
                    );

                    _detailCards[2].setDataList(
                      [
                        item['nuaadres'].toString(),
                        item['MASK'].toString(),
                        item['GW'].toString(),
                        item['datacommadre'].toString(),
                        item['MAC'].toString(),
                      ],
                    );
                    _detailCards[3].setDataList(
                      [
                        item['betaalauto'].toString(),
                        item['TID'].toString(),
                        item['TIDAWL'].toString(),
                        item['MerchantID'].toString(),
                      ],
                    );
                    _detailCards[4].setDataList(
                      [
                        item['PUKGSM'].toString(),
                        item['CertCode'].toString(),
                        item['datuminstall'].toString(),
                        item['Installatie'].toString(),
                        item['InstallatieDatum'].toString(),
                        item['Euro_Install_Num'].toString(),
                        item['Euro_Opmerkingen'].toString(),
                        item['pinpadserie'].toString(),
                        item['Portnumber'].toString(),
                        item['verkooppuntc'].toString(),
                      ],
                    );

                    return Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        // ),
                        child: Column(children: [
                          Expanded(
                              child: ListView(children: [
                            getDetailTile(0),
                            getDetailTile(1),
                            getDetailTile(2),
                            getDetailTile(3),
                            getDetailTile(4),
                          ]))
                        ]));
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }));
    // ]));
  }

  Widget getDetailTile(int tileNRParam) {
    return ExpansionTile(
        title: Container(
          // width: double.infinity,
          child: Text(
            _detailCards[tileNRParam].groupValue,
            style: TextStyle(
              fontSize: 20.0,
              color: Theme.of(context).textTheme.bodyText2.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        initiallyExpanded: _detailCards[tileNRParam].isExpanded,
        trailing: (_detailCards[tileNRParam].isExpanded == true)
            ? Icon(Icons.arrow_drop_down,
                size: 32, color: Theme.of(context).textTheme.bodyText2.color)
            : Icon(Icons.arrow_drop_up,
                size: 32, color: Theme.of(context).textTheme.bodyText2.color),
        onExpansionChanged: (value) {
          setState(() {
            _detailCards[tileNRParam].isExpanded = value;
          });
        },
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                // title: Align(
                // child:
                title: _detailCards[tileNRParam].getDetailItemData(),
                // alignment: Alignment.topLeft,
                // )
              )),
        ]);
  }

  void updateDetailsArea(int _selectedIDParam) {
    setState(() {
      _selectedID = _selectedIDParam;
    });
  }
}

class _DetailCard {
  _DetailCard(
    this.groupValue,
    this.descriptionsList,
    this.isExpanded,
  );

  String groupValue;
  String descriptionValue;
  List<String> descriptionsList;
  List<String> dataList;
  bool isExpanded;

  void setDataList(List<String> dataParam) {
    dataList = dataParam;
  }

  Column getDetailItemData() {
    var listlength = dataList.length;
    List<_DoubleString> temp = [];
    for (int i = 0; i < listlength; i++) {
      temp.add(_DoubleString(descriptionsList[i], dataList[i]));
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: temp.map<Row>((_DoubleString doubleString) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(doubleString.desc), flex: 12),
              Expanded(child: Text(doubleString.data), flex: 15),
            ],
            // children:

            // Text(
            // detail,
            // textAlign: TextAlign.left,
          );
        }).toList());
  }
}

class _DoubleString {
  _DoubleString(
    this.desc,
    this.data,
  );

  String desc;
  String data;
}

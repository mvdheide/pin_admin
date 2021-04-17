import 'package:flutter/material.dart';
import 'package:pin_admin/Pages/phoneDetailPage.dart';
import 'package:pin_admin/Widget/headerButtonArea.dart';
import 'package:pin_admin/models/headerButtonModel.dart';
import 'package:pin_admin/models/overViewModel.dart';
import 'package:pin_admin/models/textFieldModel.dart';
import 'package:provider/provider.dart';

class OverViewListArea extends StatelessWidget {
  final int deviceModel;

//----------------------------------------------------------------------------//

  OverViewListArea.phone() : deviceModel = OverViewModel.PHONE_MODE;

//----------------------------------------------------------------------------//

  OverViewListArea.tablet() : deviceModel = OverViewModel.TABLET_MODE;

//----------------------------------------------------------------------------//

  @override
  Widget build(BuildContext context) {
    print("overviewArea - Build start");
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: FutureBuilder<List<List<String>>>(
          future: Provider.of<OverViewModel>(context, listen: false)
              .updateOverviewList(
            Provider.of<TextFieldModel>(context).getAllTextFieldValues(),
            Provider.of<HeaderButtonModel>(context).getLastClickedButton,
            Provider.of<HeaderButtonModel>(context).getAscending,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("overviewArea: future start");
              int overviewItemCount = snapshot.data!.length;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: overviewItemCount,
                      itemBuilder: (_, int position) {
                        OverViewModel model =
                            Provider.of<OverViewModel>(context, listen: false);
                        final item = model.overviewItems[position];
                        // print(item);
                        return InkWell(
                          onTap: () {
                            model.showDetails(int.parse(item[5]));
                            if (deviceModel == OverViewModel.PHONE_MODE) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhoneDetailPage(model),
                                ),
                              );
                            }
                          },
                          child: Container(
                            color: Theme.of(context).cardColor,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: HeaderButtonRow
                                            .overviewColumnflex[0],
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Text(item[0].toString()))),
                                    Expanded(
                                        flex: HeaderButtonRow
                                            .overviewColumnflex[1],
                                        child: Text(item[1].toString())),
                                    Expanded(
                                        flex: HeaderButtonRow
                                            .overviewColumnflex[2],
                                        child: Text(item[2].toString())),
                                    Expanded(
                                        flex: HeaderButtonRow
                                            .overviewColumnflex[3],
                                        child: Text(item[3].toString())),
                                    Expanded(
                                        flex: HeaderButtonRow
                                            .overviewColumnflex[4],
                                        child: Text(item[4].toString())),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                              ],
                            ),
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
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

//----------------------------------------------------------------------------//

}

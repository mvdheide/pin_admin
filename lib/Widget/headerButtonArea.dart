import 'package:flutter/material.dart';
import 'package:pin_admin/models/headerButtonModel.dart';
// import 'package:pin_admin/models/overViewModel.dart';
import 'package:provider/provider.dart';

class HeaderButtonRow extends StatelessWidget {
  final Color backGroundColor;
  static final List<int> overviewColumnflex = [8, 5, 4, 2, 2];

  HeaderButtonRow({Key key, @required this.backGroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("HeaderButtonRow - build start");

    return
        // Padding(
        // color: Theme.of(context).primaryColor,
        // padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        // child:
        Consumer<HeaderButtonModel>(
      builder: (context, model, chld) {
        return Row(
          children: <Widget>[
            getButton(0, model),
            getButton(1, model),
            getButton(2, model),
            getButton(3, model),
            getButton(4, model),
          ],
        );
      },
      // ),
    );
  }

  Widget getButton(int buttonNR, HeaderButtonModel model) {
    return Expanded(
        flex: overviewColumnflex[buttonNR],
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return backGroundColor;
              },
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: RichText(
              text: TextSpan(
                // style: Theme.of(context).textTheme.body1,
                children: [
                  TextSpan(text: model.getHeaderButtonTitle(buttonNR)),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: model.getIconHeaderButton(buttonNR),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onPressed: () {
            model.setHeaderClicked(buttonNR);
            // buttonClicked(buttonNR);
          },
        ));
  }
}

import 'package:E_Soor/helpers/logic/constants.dart';
import 'package:E_Soor/models/selection.dart';
import 'package:E_Soor/ui/screens/tabs/social.dart';
import 'package:E_Soor/ui/screens/tabs/store.dart';
import 'package:E_Soor/ui/widgets/AppSearch.dart';
import 'package:E_Soor/ui/widgets/ThemeSwitch.dart';
import 'package:E_Soor/ui/widgets/selectionAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody>
    with SingleTickerProviderStateMixin {
  String transcription = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var selectionProvider = Provider.of<SelectionNotifier>(context);
    bool isSelected = selectionProvider.getValue();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: FlatButton(
            onPressed: () {
              showSearchPage(context, AppSearch(), transcription);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.search,
                  size: 25,
                ),
                Text(
                  " Search",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          titleSpacing: 0,
          actions: <Widget>[
            Constants(
              child: ThemeSwitch(),
            ),
          ],
          bottom: isSelected ? selectionAppBar(context) : null,
        ),
        body: Store(),
      ),
    );
  }
}

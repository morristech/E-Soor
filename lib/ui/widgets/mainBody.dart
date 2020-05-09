import 'package:E_Soor/helpers/logic/constants.dart';
import 'package:E_Soor/ui/screens/tabs/social.dart';
import 'package:E_Soor/ui/screens/tabs/store.dart';
import 'package:E_Soor/ui/widgets/AppSearch.dart';
import 'package:E_Soor/ui/widgets/ThemeSwitch.dart';
import 'package:flutter/material.dart';

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody>
    with SingleTickerProviderStateMixin {
  String transcription = "";
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                titleSpacing: 0,
                actions: <Widget>[Constants(child: ThemeSwitch())],
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
                centerTitle: true,
                floating: true,
                pinned: true,
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: <Widget>[
                    Tab(
                      text: "Store",
                      icon: Icon(Icons.store),
                    ),
                    Tab(
                      text: "Social",
                      icon: Icon(Icons.people),
                    )
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              Store(),
              Social(),
            ],
          ),
        ),
      ),
    );
  }
}

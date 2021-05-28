import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/material.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/state/AppState.dart';
import 'package:Golo/src/views/all_city/Cities.dart';
import 'package:Golo/src/views/comingsoon/ComingSoon.dart';
import 'package:Golo/src/views/home/Home.dart';

class DashboardTabs extends StatefulWidget {
  @override 
  _DashboardTabsState createState() => _DashboardTabsState();
}

class _DashboardTabsState extends State<DashboardTabs> {

  int _currentTab;
  List<StatefulWidget> _screens;

  @override
  void initState() {
    super.initState();
    _currentTab = 0;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTab,
        children: _buildScreens(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          openTab(index);
        },
        currentIndex: _currentTab,
        items: <BottomNavigationBarItem>[
          _buildTabIcon(0),
          _buildTabIcon(1),
          _buildTabIcon(2),
          _buildTabIcon(3)
        ],
      ),
    );
    // return CupertinoTabScaffold(
    //   tabBar: _buildTabbars(),
    //   tabBuilder: (BuildContext context, int index) {
    //       return CupertinoTabView(
    //         builder: (BuildContext context) {
    //           return _buildPageForTabIndex(context, index);
    //         },
    //       );
    //     },
    // );
  }

  // COMPONENTS

  BottomNavigationBarItem _buildTabIcon(index) {
    var icon;
    switch (index) {
      case 0: icon = DenLineIcons.home; break;
      case 1: icon = DenLineIcons.city; break;
      case 2: icon = DenLineIcons.bookmark; break;
      case 3: icon = DenLineIcons.user; break;
      default: icon = DenLineIcons.home; break;
    }
    var _normalIcon = Container(
      child: Icon(icon, size: 24, color: GoloColors.secondary2)
    );
    var _activeIcon = Container(
      child: Icon(icon, size: 24, color: GoloColors.primary)
    );
    return BottomNavigationBarItem(
      title: Text(""),
      icon: _normalIcon,
      activeIcon: _activeIcon
    );
  }

  List<StatefulWidget> _buildScreens() {
    _screens = <StatefulWidget>[
                Home(
                  cities: AppState().cities,
                  homeOpenAllCities: () {
                    openTab(1);
                  }),
                Cities(cities: AppState().cities,),
                ComingSoonPage(),
                ComingSoonPage()
    ];
    return _screens;
  }

  // ### ACTIONS
  void openTab(int index) {
    setState(() {
      _currentTab = index;
    });
  }
}

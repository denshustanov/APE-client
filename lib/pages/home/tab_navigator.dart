import 'package:flutter/material.dart';
import '../../modules/application_tab.dart';
import '../../pages/guiding_page.dart';
import '../capturing/photo_page.dart';
import '../equipment/equipment_page.dart';

import 'home_page.dart';

class TabNavigator extends StatelessWidget {

  TabNavigator({required this.navigatorKey, required this.tabItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;


  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings){
      Widget currentPage;
      if(tabItem == TabItem.HOME){
        currentPage = EquipmentPage();
      } else if ( tabItem == TabItem.CAPTURING){
        currentPage = PhotoPage();
      } else{
        currentPage = GuidingPage();
      }

      return MaterialPageRoute(builder: (context) => currentPage);
    },
    );
  }}
import 'package:flutter/material.dart';
import '../../modules/application_tab.dart';

Map<TabItem, ApplicationTab> tabs = {
  TabItem.HOME : ApplicationTab("Equipment", Colors.grey, Icons.settings),
  TabItem.CAPTURING: ApplicationTab("Capturing", Colors.grey, Icons.camera_alt),
  TabItem.GUIDING: ApplicationTab("Guiding", Colors.grey, Icons.location_searching)
};

class MyBottomNavigation extends StatelessWidget {

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  MyBottomNavigation(this.currentTab, this.onSelectTab);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: _colorTabMatching(currentTab),
        selectedFontSize: 13,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab.index,
        // пункты меню
        items: [
          _buildItem(TabItem.HOME),
          _buildItem(TabItem.CAPTURING),
          _buildItem(TabItem.GUIDING),
        ],
        onTap: (index) => onSelectTab(
            TabItem.values[index]
        )
    );
  }

  BottomNavigationBarItem _buildItem(TabItem item) {
    return BottomNavigationBarItem(
      // указываем иконку
      icon: Icon(
        _iconTabMatching(item),
        color: _colorTabMatching(item),
      ),
      // указываем метку или название
      label: tabs[item]?.name,
    );
  }

  // получаем иконку элемента
  IconData _iconTabMatching(TabItem item) => tabs[item]!.icon;

  // получаем цвет элемента
  MaterialColor _colorTabMatching(TabItem item) {
    return currentTab == item ? tabs[item]!.color : Colors.grey;
  }
}
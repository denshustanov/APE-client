import 'package:astro_photo_environment/pages/home/bottom_navigation.dart';
import 'package:astro_photo_environment/services/http_service_impl.dart';
import 'package:flutter/material.dart';
import '../../modules/application_tab.dart';
import 'tab_navigator.dart';
import '../equipment/equipment_page.dart';
import '../guiding_page.dart';
import '../capturing/photo_page.dart';


class HomePage extends StatefulWidget{


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  static final List<Widget> _widgetOptions = <Widget> [
    EquipmentPage(),
    PhotoPage(),
    GuidingPage()
  ];

  static final List<String> _widgetOptionCaptions = <String> [
    'Setup',
    'Capturing',
    'Guiding'
  ];

  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_widgetOptionCaptions.elementAt(_selectedIndex)),
        actions: [
          TextButton(onPressed: (){}, child: const Icon(Icons.settings, color: Colors.white,))
        ],
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/telescope.png')),
              label: 'Setup'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: 'Capturing'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_searching),
              label: 'Guiding'
          )
        ],
        selectedItemColor: Colors.redAccent,
        currentIndex: _selectedIndex,
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
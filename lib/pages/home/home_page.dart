import 'package:astro_photo_environment/pages/capturing/sessions_page.dart';
import 'package:astro_photo_environment/services/http_service.dart';
import 'package:flutter/material.dart';
import '../../service_locator.dart';
import '../equipment/equipment_page.dart';
import '../guiding_page.dart';
import '../capturing/capturing_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static final List<String> _widgetOptionCaptions = <String>[
    'Setup',
    'Capturing',
    'Guiding',
    'Gallery'
  ];

  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    Widget _equipmentPage = EquipmentPage();
    Widget _photoPage = CapturingPage();
    Widget _guidingPage = const GuidingPage();
    Widget _sessionsPage = SessionsPage();


    return Scaffold(
      appBar: AppBar(
        title: Text(_widgetOptionCaptions.elementAt(_selectedIndex)),
        actions: [
          TextButton(onPressed: () {
            Navigator.pushNamed(context, '/settings');
          }, child: const Icon(Icons.settings, color: Colors.white,))
        ],
      ),
      body: Center(child: IndexedStack(
        children: [
          _equipmentPage,
          _photoPage,
          _guidingPage,
          _sessionsPage
        ],
        index: _selectedIndex,
      )),
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
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.image_outlined),
              label: 'Gallery'
          )
        ],
        selectedItemColor: Colors.redAccent,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
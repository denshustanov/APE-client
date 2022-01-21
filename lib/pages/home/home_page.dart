import 'package:astro_photo_environment/services/http_service.dart';
import 'package:flutter/material.dart';
import '../../service_locator.dart';
import '../equipment/equipment_page.dart';
import '../guiding_page.dart';
import '../capturing/photo_page.dart';


class HomePage extends StatefulWidget{


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  HttpService _httpService = getIt<HttpService>();

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
          TextButton(onPressed: _showSettingsDialog, child: const Icon(Icons.settings, color: Colors.white,))
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
  _showSettingsDialog(){
    TextEditingController _hostController = TextEditingController();
    TextEditingController _portController = TextEditingController();
    TextEditingController _loginController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    _hostController.text = _httpService.getModuleUrl();
    _portController.text = _httpService.getModulePort().toString();
    _loginController.text = _httpService.getLogin();

    showGeneralDialog(context: context,
        pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 50),
                  const Text('APE Server settings'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('host'),
                      Container(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.url,
                          controller: _hostController,
                          onSubmitted: (value){
                            setState(() {
                              _httpService.setModuleUrl(value);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('port'),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _portController,
                          onSubmitted: (value){
                            setState(() {
                              _httpService.setModulePort(int.parse(value));
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('username'),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: _loginController,
                          onSubmitted: (value){
                            setState(() {
                              _httpService.setLogin(value);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('password'),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          obscureText: true,
                          autocorrect: false,
                          enableSuggestions: false,
                          controller: _passwordController,
                          onSubmitted: (value){
                            setState(() {
                              _httpService.setPassword(value);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                      onPressed: (){},
                      child: const Text('Test connection'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey
                  ),
                  )
                ],
              ),
            ),
          ),
    ));
  }
}
import 'package:astro_photo_environment/service_locator.dart';
import 'package:astro_photo_environment/services/http_service.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Connection'),
              subtitle: const Text('APE Server connection settings'),
              onTap: (){
                  Navigator.pushNamed(context, '/settings/connection');
                },
            ),
          ),
          Card(
            child: ListTile(
              leading: const ImageIcon(AssetImage('assets/images/tools.png')),
              title: const Text('Equipment'),
              subtitle: const Text('Equipment management'),
              onTap: (){
                Navigator.pushNamed(context, '/settings/equipment');
              },
            ),
          )
        ],
      ),
    );
  }
}
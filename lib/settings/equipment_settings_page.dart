import 'package:flutter/material.dart';

class EquipmentSettingsPage extends StatefulWidget{
  const EquipmentSettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EquipmentSettingsPageState();

}

class _EquipmentSettingsPageState extends State<EquipmentSettingsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipmet')
      ),
      body: const Center(
        child: Text('Equipment settings'),
      ),
    );
  }


}
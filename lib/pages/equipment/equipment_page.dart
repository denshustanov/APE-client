import 'package:astro_photo_environment/pages/equipment/mount_control.dart';
import 'package:astro_photo_environment/services/http_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EquipmentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
  final HttpServiceImpl _httpService = HttpServiceImpl();
  bool _mountConnected = false;
  String _mountModelName = '';

  int _slewRate = 9;
  double _slewRateSliderValue = 9;
  bool _topArrowPressed = false;
  bool _leftArrowPressed = false;
  bool _rightArrowPressed = false;
  bool _bottomArrowPressed = false;

  double _rightAscension = 54.132313;
  double _declination = 31.1123;

  TextEditingController _raDegreesController = TextEditingController(text: '0');
  TextEditingController _raMinutesController = TextEditingController(text: '0');
  TextEditingController _raSecondsController = TextEditingController(text: '0');

  TextEditingController _decDegreesController =
      TextEditingController(text: '0');
  TextEditingController _decMinutesController =
      TextEditingController(text: '0');
  TextEditingController _decSecondsController =
      TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const TabBar(
            tabs: [
              Tab(
                icon: ImageIcon(AssetImage('assets/images/tripod.png')),
                text: 'Mount',
              ),
              Tab(
                icon: ImageIcon(AssetImage('assets/images/focuser.png')),
                text: 'Focuser',
              ),
              Tab(
                icon: ImageIcon(AssetImage('assets/images/rec.png')),
                text: 'Filter wheel',
              ),
            ],
          indicatorColor: Colors.redAccent,
          ),
        body: TabBarView(children: [
          MountControl(),
          Center(
            child: Text(
              "Focuser",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Center(
            child: Text(
              "Filter wheel",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
          )
        ]),
      ),
    );
  }
}

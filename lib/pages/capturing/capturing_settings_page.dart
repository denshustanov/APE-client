import 'package:astro_photo_environment/capturing/camera_config.dart';
import 'package:astro_photo_environment/services/http_service.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';

class CapturingSettingsPage extends StatefulWidget{
  const CapturingSettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CapturingSettingsPageState();
  
}

class _CapturingSettingsPageState extends State<CapturingSettingsPage>{
  final HttpService _httpService = getIt<HttpService>();

  String _cameraModel = '';
  String _cameraManufacturer = '';
  int _cameraShutterCounter = 0;

  bool _cameraConnected = false;

  //camera settings
  String _iso = '';
  List<DropdownMenuItem<String>> _isoChoices = [];

  String _shutterSpeed = '';
  List<DropdownMenuItem<String>> _shutterSpeedChoices = [];

  String _imageFormat = '';
  List<DropdownMenuItem<String>> _imageFormatChoices = [];

  //sequence settins
  int _sequenceLength = 10;
  TextEditingController _sequenceLengthController = TextEditingController(
      text: '10'
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturing Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text((_cameraConnected)
                    ? _cameraModel
                    : 'No camera conected!'),
                IconButton(onPressed: () async{
                  if(!_cameraConnected) {
                    CameraConfig cameraConfig = await _httpService
                        .connectCamera();
                    setState(() {
                      _cameraModel = cameraConfig.cameraName;

                      _iso = cameraConfig.currentIso;
                      _shutterSpeed = cameraConfig.currentShutterSpeed;
                      _imageFormat = cameraConfig.currentImageFormat;

                      _isoChoices = [];
                      for (String choice in cameraConfig.isoChoices) {
                        _isoChoices.add(DropdownMenuItem(
                          child: Text(choice), value: choice,));
                      }

                      _shutterSpeedChoices = [];
                      for (String choice in cameraConfig
                          .shutterSpeedChoices) {
                        _shutterSpeedChoices.add(DropdownMenuItem(
                          child: Text(choice), value: choice,));
                      }

                      _imageFormatChoices = [];
                      for (String choice in cameraConfig
                          .imageFormatChoices) {
                        _imageFormatChoices.add(DropdownMenuItem(
                          child: Text(choice), value: choice,));
                      }

                      _cameraConnected = true;
                    });
                  } else{
                    _httpService.disconnectCamera();
                    _cameraConnected = false;
                  }
                },
                    icon: Icon(Icons.cable, color: (_cameraConnected)
                        ? Colors.greenAccent
                        : Colors.redAccent,))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Shutter Speed'),
                DropdownButton(
                    items: _shutterSpeedChoices, value: _shutterSpeed, onChanged: (value) {
                  setState(() {
                    _httpService.setShutterSpeedConfig(value.toString());
                    _shutterSpeed = value.toString();
                  });
                })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('ISO'),
                DropdownButton(
                    items: _isoChoices, value: _iso, onChanged: (value) {
                  setState(() {
                    _httpService.setIsoConfig(value.toString());
                    _iso = value.toString();
                  });
                })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Image Format'),
                DropdownButton(items: _imageFormatChoices,
                    value: _imageFormat,
                    onChanged: (value) {
                      setState(() {
                        _httpService.setImageFormatConfig(value.toString());
                        _imageFormat = value.toString();
                      });
                    })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Sequence Size'),
                Row(
                  children: [
                    IconButton(onPressed: () {
                      setState(() {
                        if (_sequenceLength > 1) {
                          _sequenceLength -= 1;
                          _sequenceLengthController.text =
                              _sequenceLength.toString();
                        }
                      });
                    }, icon: const Icon(Icons.remove)),
                    Container(
                      width: 50,
                      child: TextField(
                          controller: _sequenceLengthController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              int length = int.parse(value);
                              if (length < 1000 && length > 0) {
                                _sequenceLength = int.parse(value);
                              } else {
                                _sequenceLengthController.text =
                                    _sequenceLength.toString();
                              }
                            });
                          }),
                    ),
                    IconButton(onPressed: () {
                      setState(() {
                        _sequenceLength += 1;
                        _sequenceLengthController.text =
                            _sequenceLength.toString();
                      });
                    }, icon: const Icon(Icons.add)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  
}
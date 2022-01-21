import 'dart:async';

import 'package:astro_photo_environment/services/http_service.dart';
import 'package:astro_photo_environment/services/http_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../service_locator.dart';

class MountControl extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MountControlState();

}

class _MountControlState extends State<MountControl>{
  final HttpService _httpService = getIt<HttpService>();

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

  Future<void> handleTimeout() async{
    if(_mountConnected) {
      try {
        List<double> coordinates = await _httpService.getTelescopeCoordinates();
        setState(() {
          _rightAscension = coordinates[0];
          _declination = coordinates[1];
        });
      } catch (e){}
    }
  }
  Timer ? timer;
  bool waitingForResponse = false;


  @override
  void initState() {
    super.initState();
    _rightAscension = 1.1;
    setTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text((_mountConnected) ? _mountModelName : 'No mount connected!'),
              IconButton(
                  onPressed: () async {
                    List<String> serialDevices =
                    await _httpService.getSerialDevices();
                    String device = serialDevices[0];
                    List<DropdownMenuItem<String>> deviceItems = [];
                    for (String device in serialDevices) {
                      deviceItems.add(DropdownMenuItem(
                        child: Text(device),
                        value: device,
                      ));
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Mount Settings'),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButton<String>(
                                    items: deviceItems,
                                    value: device,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        device = newValue!;
                                      });
                                    }),
                                IconButton(
                                    onPressed: () async {
                                      try {
                                        String model = await _httpService
                                            .connectTelescope(device);
                                        setState(() {
                                          _mountModelName = model;
                                          _mountConnected = true;
                                        });
                                      } catch (e) {}
                                    },
                                    icon: const Icon(Icons.cable))
                              ],
                            ),
                          );
                        });
                  },
                  tooltip: 'Settings',
                  icon: const Icon(Icons.settings))
            ],
          ),
          Row(
            children: [
              const Text('Slew Rate'),
              SizedBox(
                width: 200,
                child: Slider(
                    max: 9,
                    min: 1,
                    divisions: 8,
                    value: _slewRateSliderValue,
                    label: _slewRateSliderValue.round().toString(),
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey,
                    thumbColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        _slewRateSliderValue = value;
                        _slewRate = value.round();
                      });
                    }),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Listener(
                    child: Tooltip(
                        message: 'Slew DEC Forward',
                        child: Icon(Icons.arrow_drop_up,
                            size: 50,
                            color: (!_topArrowPressed)
                                ? Colors.white
                                : Colors.grey)),
                    onPointerDown: (details) {
                      setState(() {
                        _topArrowPressed = true;
                      });
                      _httpService.slewTelescope(0, _slewRate);
                    },
                    onPointerUp: (details) {
                      _httpService.slewTelescope(0, 0);
                      setState(() {
                        _topArrowPressed = false;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Listener(
                        child: Tooltip(
                          message: "Slew RA Forward",
                          child: Icon(Icons.arrow_left,
                              size: 50,
                              color: (!_leftArrowPressed)
                                  ? Colors.white
                                  : Colors.grey),
                        ),
                        onPointerDown: (details) {
                          setState(() {
                            _leftArrowPressed = true;
                          });
                          _httpService.slewTelescope(1, _slewRate);
                        },
                        onPointerUp: (details) {
                          _httpService.slewTelescope(1, 0);
                          setState(() {
                            _leftArrowPressed = false;
                          });
                        },
                      ),
                      const SizedBox(width: 50),
                      Listener(
                        child: Tooltip(
                          message: "Slew RA Backward",
                          child: Icon(Icons.arrow_right,
                              size: 50,
                              color: (!_rightArrowPressed)
                                  ? Colors.white
                                  : Colors.grey),
                        ),
                        onPointerDown: (details) {
                          setState(() {
                            _rightArrowPressed = true;
                          });
                          _httpService.slewTelescope(1, -_slewRate);
                        },
                        onPointerUp: (details) {
                          _httpService.slewTelescope(1, 0);
                          setState(() {
                            _rightArrowPressed = false;
                          });
                        },
                      ),
                    ],
                  ),
                  Listener(
                    child: Tooltip(
                      message: "Slew DEC Backward",
                      child: Icon(Icons.arrow_drop_down,
                          size: 50,
                          color: (!_bottomArrowPressed)
                              ? Colors.white
                              : Colors.grey),
                    ),
                    onPointerDown: (details) {
                      setState(() {
                        _bottomArrowPressed = true;
                      });
                      _httpService.slewTelescope(0, -_slewRate);
                    },
                    onPointerUp: (details) {
                      _httpService.slewTelescope(0, 0);
                      setState(() {
                        _bottomArrowPressed = false;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                width: 100,
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ra'),
                        Text(_angleToSting(_rightAscension))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Dec'),
                        Text(_angleToSting(_declination))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('RA     '),
                      Container(
                        width: 20,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _raDegreesController,
                          onSubmitted: (String value) {
                            setState(() {
                              // _sequenceLength = int.parse(value);
                            });
                          },
                        ),
                      ),
                      const Text('°  '),
                      Container(
                        width: 20,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _raMinutesController,
                          onSubmitted: (String value) {
                            setState(() {
                              // _sequenceLength = int.parse(value);
                            });
                          },
                        ),
                      ),
                      const Text('\'  '),
                      Container(
                        width: 20,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _raSecondsController,
                          onSubmitted: (String value) {
                            setState(() {
                              // _sequenceLength = int.parse(value);
                            });
                          },
                        ),
                      ),
                      const Text('"  '),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('DEC    '),
                      Container(
                        width: 20,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _decDegreesController,
                          onSubmitted: (String value) {
                            setState(() {
                              // _sequenceLength = int.parse(value);
                            });
                          },
                        ),
                      ),
                      const Text('°  '),
                      Container(
                        width: 20,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _decMinutesController,
                          onSubmitted: (String value) {
                            setState(() {
                              // _sequenceLength = int.parse(value);
                            });
                          },
                        ),
                      ),
                      const Text('\'  '),
                      Container(
                        width: 20,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _decSecondsController,
                          onSubmitted: (String value) {
                            setState(() {
                              // _sequenceLength = int.parse(value);
                            });
                          },
                        ),
                      ),
                      const Text('"  '),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 30),
              IconButton(
                  onPressed: () {},
                  tooltip: 'Go To',
                  icon: const Icon(Icons.my_location))
            ],
          )
        ],
      ),
    );
  }

  String _angleToSting(double value) {
    int degrees = value.floor();
    int minutes = ((value - degrees) * 60).floor();
    int seconds = ((((value - degrees) * 60) - minutes) * 60).floor();
    String degreesStr = degrees.toString();
    String minutesStr = minutes.toString();
    String secondsStr = seconds.toString();

    if(degrees<100){
      degreesStr = '0'+degreesStr;
      if(degrees<10){
        degreesStr = '0'+degreesStr;
      }
    }

    if(minutes<10){
      minutesStr = '0'+minutesStr;
    }

    if(seconds<10){
      secondsStr = '0'+secondsStr;
    }

    return degreesStr +
        "°  " +
        minutesStr +
        '\' ' +
        secondsStr +
        '"';
  }

  void setTimer() {
    // Cancelling previous timer, if there was one, and creating a new one
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) async {
      // Not sending a request, if waiting for response
      if (!waitingForResponse) {
        waitingForResponse = true;
        await handleTimeout();
        waitingForResponse = false;
      }
    });
  }

}
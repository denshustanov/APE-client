import 'package:flutter/cupertino.dart';

class CameraConfig{
  String _cameraName;

  List<String> _isoChoices;
  List<String> _shutterSpeedChoices;
  List<String> _imageFormatChoices;

  String _currentIso;
  String _currentShutterSpeed;
  String _currentImageFormat;
  int _batteryLevel;


  CameraConfig(
      this._cameraName,
      this._isoChoices,
      this._shutterSpeedChoices,
      this._imageFormatChoices,
      this._currentIso,
      this._currentShutterSpeed,
      this._currentImageFormat,
      this._batteryLevel);

  factory CameraConfig.fromJson(Map<String, dynamic> json){
    return CameraConfig(
        json['model'],
        json['iso']['choices'].cast<String>(),
        json['shutter_speed']['choices'].cast<String>(),
        json['image_format']['choices'].cast<String>(),
        json['iso']['value'],
        json['shutter_speed']['value'],
        json['image_format']['value'],
        json['battery_level']);
  }

  String get currentImageFormat => _currentImageFormat;

  set currentImageFormat(String value) {
    _currentImageFormat = value;
  }

  String get currentShutterSpeed => _currentShutterSpeed;

  set currentShutterSpeed(String value) {
    _currentShutterSpeed = value;
  }

  String get currentIso => _currentIso;

  set currentIso(String value) {
    _currentIso = value;
  }

  List<String> get imageFormatChoices => _imageFormatChoices;

  set imageFormatChoices(List<String> value) {
    _imageFormatChoices = value;
  }

  List<String> get shutterSpeedChoices => _shutterSpeedChoices;

  set shutterSpeedChoices(List<String> value) {
    _shutterSpeedChoices = value;
  }

  List<String> get isoChoices => _isoChoices;

  set isoChoices(List<String> value) {
    _isoChoices = value;
  }

  String get cameraName => _cameraName;

  set cameraName(String value) {
    _cameraName = value;
  }

  int get batteryLevel => _batteryLevel;

  set batteryLevel(int value) {
    _batteryLevel = value;
  }
}
import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_service.dart';
import 'package:astro_photo_environment/capturing/camera_config.dart';

class HttpServiceImpl extends HttpService{
  String _serverURL = '';
  int _serverPort = 0;
  String _username = '';
  String _password = '';

  HttpServiceImpl(){
    _loadPrefs();
  }

  void _loadPrefs() async{
    final prefs = await SharedPreferences.getInstance();
    _serverURL = (prefs.getString('serverURL') ?? 'http://127.0.0.1');
    _serverPort = (prefs.getInt('serverPort') ?? 5000);
    _username = (prefs.getString('serverUsername') ?? '');
    _password = (prefs.getString('serverPassword') ?? '');
  }

  void _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('serverPort', _serverPort);
    prefs.setString('serverURL', _serverURL);
    prefs.setString('serverUsername', _username);
    prefs.setString('serverPassword', _password);
  }



  final String connectCameraRoute = '/camera/connect';
  final String disconnectCameraRoute = '/camera/disconnect';
  final String captureCameraRoute = '/camera/capture';
  final String setConfigCameraRoute = '/camera/set-config';

  final String getSerialDevicesRoute = '/telescope/scan';
  final String connectTelescopeRoute = '/telescope/connect';
  final String disconnectTelescopeRoute = '/telescope/disconnect';
  final String getTelescopePositionRoute = '/telescope/get-posiotion';
  final String telescopeGotoRoute = '/telescope/goto';
  final String telescopeSlewRoute = '/telescope/slew';
  final String telescopeGetCoordinatesRoute = '/telescope/get-position';
  final String telescopeGoToRoute = '/telescope/goto';
  final String cameraGetImageRoute = '/camera/get-image';


  @override
  Future<CameraConfig> connectCamera() async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
    Response res = await get(_serverURL+':'+_serverPort.toString()+connectCameraRoute,
        headers: <String, String>{'authorization': basicAuth});
    if (res.statusCode == 200){
      return CameraConfig.fromJson(jsonDecode(res.body.toString()));
    } else {
      throw Exception('Error: can not connect to camera!');
    }
  }

  @override
  void disconnectCamera() async{
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
    Response res = await get(_serverURL+':'+_serverPort.toString()+disconnectCameraRoute,
        headers: <String, String>{'authorization': basicAuth});
  }

  @override
  Future<String> capture() async{
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
    Response res = await get(_serverURL+':'+_serverPort.toString()+captureCameraRoute,
        headers: <String, String>{'authorization': basicAuth});
    if (res.statusCode == 200){
      return res.body.toString();
    } else {
      throw Exception('Error: can not connect to camera!');
    }
  }

  @override
  void setIsoConfig(String value) async{
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
    Response res = await get(_serverURL+':'+_serverPort.toString()+setConfigCameraRoute+
    '?setting=iso&value='+value.replaceAll(' ', '%20'),
        headers: <String, String>{'authorization': basicAuth});
    if (res.statusCode == 200){
      return;
    } else{
      throw Exception('Error: can not set value');
    }
  }

  @override
  void setShutterSpeedConfig(String value) async{
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
    Response res = await get(_serverURL+':'+_serverPort.toString()+setConfigCameraRoute+
        '?setting=shutterspeed&value='+value.replaceAll(' ', '%20'),
        headers: <String, String>{'authorization': basicAuth});
    if (res.statusCode == 200){
      return;
    } else{
      throw Exception('Error: can not set value');
    }
  }

  @override
  void setImageFormatConfig(String value) async{
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
    Response res = await get(_serverURL+':'+_serverPort.toString()+setConfigCameraRoute+
        '?setting=imageformat&value='
        +value.replaceAll(' ', '%20').replaceAll('+', '%2b'),
        headers: <String, String>{'authorization': basicAuth});
    if (res.statusCode == 200){
      return;
    } else{
      throw Exception('Error: can not set value');
    }
  }

  @override
  Future<List<String>> getSerialDevices() async{
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
    Response res = await get(_serverURL+':'+_serverPort.toString()+getSerialDevicesRoute,
        headers: <String, String>{'authorization': basicAuth});
    return (json.decode(res.body) as List<dynamic>).cast<String>();
  }

  @override
  Future<String> connectTelescope(String device) async{
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
    Response res = await get(_serverURL+':'+_serverPort.toString()+connectTelescopeRoute+
    '?port='+device,
        headers: <String, String>{'authorization': basicAuth});
    if (res.statusCode == 200){
      return res.body;
    } else{
      throw Exception('Error: can not connect to '+device);
    }
  }

  @override
  void slewTelescope(int motor, int rate) async{
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
    Response res = await get(_serverURL+':'+_serverPort.toString()+telescopeSlewRoute+
        '?rate='+rate.toString()+'&motor='+motor.toString(),
        headers: <String, String>{'authorization': basicAuth});
    if (res.statusCode == 200){
      return;
    } else{
      throw Exception('Error: can not set value');
    }
  }

  @override
  Future<List<double>> getTelescopeCoordinates() async{
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
    Response res = await get(_serverURL+':'+_serverPort.toString()+telescopeGetCoordinatesRoute+
        '?mode=ra_dec',
        headers: <String, String>{'authorization': basicAuth});
    if (res.statusCode == 200){
      return (json.decode(res.body) as List<dynamic>).cast<double>();
    } else{
      throw Exception('Error: can not set value');
    }
  }

  @override
  void goToTelescope(int c1, int c2) async{
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_username:$_password'));
    Response res = await get(_serverURL+':'+_serverPort.toString()+telescopeSlewRoute+
        '?c1='+c1.toString()+'&c2='+c2.toString(),
        headers: <String, String>{'authorization': basicAuth});
    if (res.statusCode == 200){
      return;
    } else{
      throw Exception('Error: can not set value');
    }
  }

  @override
  String getModuleUrl() {
    return _serverURL;
  }

  @override
  void setModuleUrl(String moduleUrl) {
    _serverURL = moduleUrl;
    _savePrefs();
  }

  @override
  int getModulePort() {
    return _serverPort;
  }

  @override
  void setModulePort(int modulePort) {
    _serverPort = modulePort;
    _savePrefs();
  }

  @override
  String getLogin() {
    return _username;
  }

  @override
  void setLogin(String login) {
    _username = login;
    _savePrefs();
  }

  @override
  void setPassword(String password) {
    _password = password;
    _savePrefs();
  }

  @override
  String getPassword(){
    return _password;
  }

  @override
  String getImageURL(String imagePath) {
    return _serverURL+':'+_serverPort.toString()+cameraGetImageRoute+ '?path='+imagePath;
  }



}

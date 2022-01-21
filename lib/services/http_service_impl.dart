import 'dart:convert';

import 'package:http/http.dart';
import 'http_service.dart';
import 'package:astro_photo_environment/capturing/camera_config.dart';

class HttpServiceImpl extends HttpService{
  String moduleURL = 'http://127.0.0.1';
  int modulePort = 5000;
  String username = 'admin';
  String password = 'admin';



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


  @override
  Future<CameraConfig> connectCamera() async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Response res = await get(moduleURL+':'+modulePort.toString()+connectCameraRoute,
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
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Response res = await get(moduleURL+':'+modulePort.toString()+disconnectCameraRoute,
        headers: <String, String>{'authorization': basicAuth});
  }

  @override
  Future<String> capture() async{
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Response res = await get(moduleURL+':'+modulePort.toString()+captureCameraRoute,
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
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Response res = await get(moduleURL+':'+modulePort.toString()+setConfigCameraRoute+
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
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Response res = await get(moduleURL+':'+modulePort.toString()+setConfigCameraRoute+
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
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Response res = await get(moduleURL+':'+modulePort.toString()+setConfigCameraRoute+
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
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Response res = await get(moduleURL+':'+modulePort.toString()+getSerialDevicesRoute,
        headers: <String, String>{'authorization': basicAuth});
    return (json.decode(res.body) as List<dynamic>).cast<String>();
  }

  @override
  Future<String> connectTelescope(String device) async{
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Response res = await get(moduleURL+':'+modulePort.toString()+connectTelescopeRoute+
    '?port='+device,
        headers: <String, String>{'authorization': basicAuth});
    if (res.statusCode == 200){
      return res.body;
    } else{
      throw Exception('Error: can not set value');
    }
  }

  @override
  void slewTelescope(int motor, int rate) async{
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Response res = await get(moduleURL+':'+modulePort.toString()+telescopeSlewRoute+
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
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Response res = await get(moduleURL+':'+modulePort.toString()+telescopeGetCoordinatesRoute+
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
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Response res = await get(moduleURL+':'+modulePort.toString()+telescopeSlewRoute+
        '?c1='+c1.toString()+'&c2='+c2.toString(),
        headers: <String, String>{'authorization': basicAuth});
    if (res.statusCode == 200){
      return;
    } else{
      throw Exception('Error: can not set value');
    }
  }


}

import 'package:astro_photo_environment/capturing/camera_config.dart';

abstract class HttpService {
  Future<CameraConfig> connectCamera();

  void disconnectCamera();

  Future<String> capture();

  void setIsoConfig(String value);

  void setShutterSpeedConfig(String value);

  void setImageFormatConfig(String value);

  Future<List<String>> getSerialDevices();

  Future<String> connectTelescope(String device);

  void slewTelescope(int motor, int rate);

  void goToTelescope(int c1, int c2);

  Future<List<double>> getTelescopeCoordinates();
}

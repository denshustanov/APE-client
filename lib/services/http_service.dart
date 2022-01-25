import 'package:astro_photo_environment/capturing/camera_config.dart';
import 'package:astro_photo_environment/capturing/session.dart';

abstract class HttpService {
  Future<CameraConfig> connectCamera();

  void disconnectCamera();

  Future<String> capture(String type);

  void setIsoConfig(String value);

  void setShutterSpeedConfig(String value);

  void setImageFormatConfig(String value);

  Future<List<String>> getSerialDevices();

  Future<String> connectTelescope(String device);

  void slewTelescope(int motor, int rate);

  void goToTelescope(int c1, int c2);

  Future<List<double>> getTelescopeCoordinates();

  String getModuleUrl();
  void setModuleUrl(String moduleUrl);

  int getModulePort();
  void setModulePort(int modulePort);

  String getLogin();
  void setLogin(String login);

  String getPassword();
  void setPassword(String password);

  String getImageURL(String imagePath);

  Future<List<Session>> getSessions();

  void createSession(String sessionName);


}

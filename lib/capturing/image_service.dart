import 'package:astro_photo_environment/capturing/session.dart';
import 'package:astro_photo_environment/services/http_service.dart';
import '../service_locator.dart';

class ImageService{
  final HttpService _httpService = getIt<HttpService>();
  final List<Session> _sessions = [];
  Session? currentSession;

  void createSession(String sessionName){
    currentSession = Session(sessionName);
    _sessions.add(currentSession!);
    _httpService.createSession(sessionName);
  }

  Future<List<Session>> update() async {
    return _httpService.getSessions();
  }

  List<Session> get sessions => _sessions;
}
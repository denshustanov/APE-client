import 'package:astro_photo_environment/services/http_service.dart';
import 'package:astro_photo_environment/services/http_service_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupServiceLocator(){
  getIt.registerLazySingleton<HttpService>(() => HttpServiceImpl());
}
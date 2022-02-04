import 'package:get_it/get_it.dart';
import 'package:task/global/preferences.dart';
import '../api/core/api_exporter.dart';
import '../api/core/api_links.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Preferences());
  locator.registerLazySingleton(() => ApiLinks());
  locator.registerLazySingleton(() => ApiExporter());
}

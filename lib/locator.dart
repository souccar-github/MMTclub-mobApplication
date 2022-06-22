import 'package:get_it/get_it.dart';
import 'NavigationService.dart';
import 'PushNotification.dart';

GetIt locator = GetIt.instance;
void setupLocator(){
  locator.registerLazySingleton(()=>PushNotification());
  locator.registerLazySingleton(() => NavigationService());

}
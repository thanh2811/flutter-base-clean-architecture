import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@module
@singleton
abstract class ServiceModule {
  @preResolve
  Future<SharedPreferences> get sharedPref => SharedPreferences.getInstance();

  @preResolve
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      );
  // getIt.registerSingleton<SharedPreferences>(sharedPref);

  // getIt.registerLazySingleton<LocalDataAccess>(
  //     () => SharePrefHelper(sharedPref: sharedPref));
}

@injectableInit
void configureInjection() => getIt.init();

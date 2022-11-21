import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/app_repository.dart';
import '../data/repository/local/shared_pref_helper.dart';
import '../data/repository/order_repository.dart';
import '../data/repository/product_repository.dart';
import '../data/repository/report_repository.dart';
import '../data/repository/storage_repository.dart';
import '../data/repository/user_repository.dart';
import '../data/repository/utility_repository.dart';
import '../services/app_service.dart';
import '../services/order_service.dart';
import '../services/product_service.dart';
import '../services/report_service.dart';
import '../services/storage_service.dart';
import '../services/user_service.dart';
import '../services/utility_service.dart';

final getIt = GetIt.instance;

configureInjection() async {
  getIt.registerFactory<Dio>(() => Dio());
  getIt.registerLazySingleton<UserApi>(() => UserApi(getIt<Dio>()));
  getIt.registerLazySingleton<AppApi>(() => AppApi(getIt<Dio>()));
  getIt.registerLazySingleton<ProductApi>(() => ProductApi(getIt<Dio>()));
  getIt.registerLazySingleton<ReportApi>(() => ReportApi(getIt<Dio>()));
  getIt.registerLazySingleton<OrderApi>(() => OrderApi(getIt<Dio>()));
  getIt.registerLazySingleton<UtilitiesApi>(() => UtilitiesApi(getIt<Dio>()));
  getIt.registerLazySingleton(() => StorageApi(getIt<Dio>()));
  getIt.registerLazySingleton(
      () => StorageRepository(storageApi: getIt<StorageApi>()));
  getIt.registerLazySingleton(() => UserRepository(api: getIt<UserApi>()));
  getIt.registerLazySingleton(() => AppRepository(api: getIt<AppApi>()));
  getIt.registerLazySingleton(
      () => UtilityRepository(api: getIt<UtilitiesApi>()));
  getIt
      .registerLazySingleton(() => ProductRepository(api: getIt<ProductApi>()));
  getIt
      .registerLazySingleton(() => ReportRepository(api: getIt<ReportApi>()));
  getIt.registerLazySingleton(() => OrderRepository(api: getIt<OrderApi>()));
  final sharedPref = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPref);

  getIt.registerLazySingleton<SharePrefHelper>(() => SharePrefHelper());
}

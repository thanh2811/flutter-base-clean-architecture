import 'package:get_it/get_it.dart';

import '../helper/app_info.dart';
import 'config.dart';
import '../di/di.dart' as di;

class SharedConfig extends Config {
  SharedConfig._();

  static final SharedConfig _instance = SharedConfig._();

  factory SharedConfig.getInstance() => _instance;

  @override
  Future<void> config() async {
    di.configureInjection();
    await GetIt.instance.get<AppInfo>().init();
  }
}

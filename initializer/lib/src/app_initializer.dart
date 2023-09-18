import 'package:flutter/foundation.dart';
import 'package:shared/shared.dart';

class AppInitializer {
  @protected
  Future<void> init() async {
    await SharedConfig.getInstance().init();
  }
}

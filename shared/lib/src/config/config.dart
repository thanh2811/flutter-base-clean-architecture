import 'package:async/async.dart';

abstract class Config {
  final AsyncMemoizer<void> _asyncMemoizer = AsyncMemoizer();

  Future<void> config();

  Future<void> init() => _asyncMemoizer
      .runOnce(config); // use with get it di => to not register instance again
}

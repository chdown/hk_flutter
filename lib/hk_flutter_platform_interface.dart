import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hk_flutter_method_channel.dart';

abstract class HkFlutterPlatform extends PlatformInterface {
  /// Constructs a HkFlutterPlatform.
  HkFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static HkFlutterPlatform _instance = MethodChannelHkFlutter();

  /// The default instance of [HkFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelHkFlutter].
  static HkFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HkFlutterPlatform] when
  /// they register themselves.
  static set instance(HkFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

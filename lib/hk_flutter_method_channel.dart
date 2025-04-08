import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hk_flutter_platform_interface.dart';

/// An implementation of [HkFlutterPlatform] that uses method channels.
class MethodChannelHkFlutter extends HkFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hk_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

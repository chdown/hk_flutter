import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'hk_flutter_platform_interface.dart';

/// An implementation of [HkFlutterPlatform] that uses method channels.
class MethodChannelHkFlutter extends HkFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel _channel = const MethodChannel('hk_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await _channel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> initCamera({
    required String ip,
    required String port,
    required String userName,
    required String password,
    int flag = 0,
  }) async {
    final result = await _channel.invokeMethod<bool>('initCamera', {
      'ip': ip,
      'port': port,
      'userName': userName,
      'password': password,
      'flag': flag,
    });
    return result ?? false;
  }

  @override
  Future<bool> setVideoInfo() async {
    final result = await _channel.invokeMethod<bool>('setVideoInfo');
    return result ?? false;
  }

  @override
  Future<bool> setOSDInfo() async {
    final result = await _channel.invokeMethod<bool>('setOSDInfo');
    return result ?? false;
  }

  @override
  Future<bool> setNtp() async {
    final result = await _channel.invokeMethod<bool>('setNtp');
    return result ?? false;
  }

  @override
  Future<bool> setTime() async {
    final result = await _channel.invokeMethod<bool>('setTime');
    return result ?? false;
  }

  @override
  Future<bool> setPwd({
    required String userName,
    required String pwd,
  }) async {
    final result = await _channel.invokeMethod<bool>('setPwd', {
      'userName': userName,
      'pwd': pwd,
    });
    return result ?? false;
  }
}

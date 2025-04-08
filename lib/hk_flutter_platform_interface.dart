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

  /// 初始化摄像头
  Future<bool> initCamera({
    required String ip,
    required String port,
    required String userName,
    required String password,
    int flag = 0,
  }) {
    throw UnimplementedError('initCamera() has not been implemented.');
  }

  /// 设置视频信息
  Future<bool> setVideoInfo() {
    throw UnimplementedError('setVideoInfo() has not been implemented.');
  }

  /// 设置OSD信息
  Future<bool> setOSDInfo() {
    throw UnimplementedError('setOSDInfo() has not been implemented.');
  }

  /// 设置NTP
  Future<bool> setNtp() {
    throw UnimplementedError('setNtp() has not been implemented.');
  }

  /// 设置时间
  Future<bool> setTime() {
    throw UnimplementedError('setTime() has not been implemented.');
  }

  /// 设置密码
  Future<bool> setPwd({
    required String userName,
    required String pwd,
  }) {
    throw UnimplementedError('setPwd() has not been implemented.');
  }
}

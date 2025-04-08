import 'package:flutter/services.dart';
import 'hk_flutter_platform_interface.dart';

class HkFlutter {
  Future<String?> getPlatformVersion() {
    return HkFlutterPlatform.instance.getPlatformVersion();
  }

  /// 初始化摄像头
  Future<bool> initCamera({
    required String ip,
    required String port,
    required String userName,
    required String password,
    int flag = 0,
  }) async {
    return HkFlutterPlatform.instance.initCamera(
      ip: ip,
      port: port,
      userName: userName,
      password: password,
      flag: flag,
    );
  }

  /// 设置视频信息
  Future<bool> setVideoInfo() async {
    return HkFlutterPlatform.instance.setVideoInfo();
  }

  /// 设置OSD信息
  Future<bool> setOSDInfo() async {
    return HkFlutterPlatform.instance.setOSDInfo();
  }

  /// 设置NTP
  Future<bool> setNtp() async {
    return HkFlutterPlatform.instance.setNtp();
  }

  /// 设置时间
  Future<bool> setTime() async {
    return HkFlutterPlatform.instance.setTime();
  }

  /// 设置密码
  Future<bool> setPwd({
    required String userName,
    required String pwd,
  }) async {
    return HkFlutterPlatform.instance.setPwd(
      userName: userName,
      pwd: pwd,
    );
  }
}

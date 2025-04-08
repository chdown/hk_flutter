import 'package:flutter_test/flutter_test.dart';
import 'package:hk_flutter/hk_flutter.dart';
import 'package:hk_flutter/hk_flutter_platform_interface.dart';
import 'package:hk_flutter/hk_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHkFlutterPlatform
    with MockPlatformInterfaceMixin
    implements HkFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HkFlutterPlatform initialPlatform = HkFlutterPlatform.instance;

  test('$MethodChannelHkFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHkFlutter>());
  });

  test('getPlatformVersion', () async {
    HkFlutter hkFlutterPlugin = HkFlutter();
    MockHkFlutterPlatform fakePlatform = MockHkFlutterPlatform();
    HkFlutterPlatform.instance = fakePlatform;

    expect(await hkFlutterPlugin.getPlatformVersion(), '42');
  });
}

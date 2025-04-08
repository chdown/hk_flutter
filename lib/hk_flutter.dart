
import 'hk_flutter_platform_interface.dart';

class HkFlutter {
  Future<String?> getPlatformVersion() {
    return HkFlutterPlatform.instance.getPlatformVersion();
  }
}

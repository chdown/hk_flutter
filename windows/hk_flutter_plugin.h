#ifndef FLUTTER_PLUGIN_HK_FLUTTER_PLUGIN_H_
#define FLUTTER_PLUGIN_HK_FLUTTER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <HCNetSDK.h>  // Add Hikvision SDK header

#include <memory>
#include <string>

namespace hk_flutter {

class HkFlutterPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  HkFlutterPlugin();

  virtual ~HkFlutterPlugin();

  // Disallow copy and assign.
  HkFlutterPlugin(const HkFlutterPlugin&) = delete;
  HkFlutterPlugin& operator=(const HkFlutterPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace hk_flutter

#endif  // FLUTTER_PLUGIN_HK_FLUTTER_PLUGIN_H_

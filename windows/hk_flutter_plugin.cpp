#include "hk_flutter_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

namespace hk_flutter {

// static
void HkFlutterPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "hk_flutter",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<HkFlutterPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

HkFlutterPlugin::HkFlutterPlugin() {}

HkFlutterPlugin::~HkFlutterPlugin() {}

void HkFlutterPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("getPlatformVersion") == 0) {
    std::ostringstream version_stream;
    version_stream << "Windows ";
    if (IsWindows10OrGreater()) {
      version_stream << "10+";
    } else if (IsWindows8OrGreater()) {
      version_stream << "8";
    } else if (IsWindows7OrGreater()) {
      version_stream << "7";
    }
    result->Success(flutter::EncodableValue(version_stream.str()));
  } else if (method_call.method_name().compare("initCamera") == 0) {
    const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
    if (arguments) {
      auto ip = std::get<std::string>(arguments->at(flutter::EncodableValue("ip")));
      auto port = std::get<std::string>(arguments->at(flutter::EncodableValue("port")));
      auto userName = std::get<std::string>(arguments->at(flutter::EncodableValue("userName")));
      auto password = std::get<std::string>(arguments->at(flutter::EncodableValue("password")));
      // auto flag = std::get<int>(arguments->at(flutter::EncodableValue("flag")));
      
      // TODO: Implement Hikvision SDK initialization
      result->Success(flutter::EncodableValue(true));
    } else {
      result->Error("Invalid arguments", "Expected map");
    }
  } else if (method_call.method_name().compare("setVideoInfo") == 0) {
    // TODO: Implement video info setting
    result->Success(flutter::EncodableValue(true));
  } else if (method_call.method_name().compare("setOSDInfo") == 0) {
    // TODO: Implement OSD info setting
    result->Success(flutter::EncodableValue(true));
  } else if (method_call.method_name().compare("setNtp") == 0) {
    // TODO: Implement NTP setting
    result->Success(flutter::EncodableValue(true));
  } else if (method_call.method_name().compare("setTime") == 0) {
    // TODO: Implement time setting
    result->Success(flutter::EncodableValue(true));
  } else if (method_call.method_name().compare("setPwd") == 0) {
    const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
    if (arguments) {
      auto userName = std::get<std::string>(arguments->at(flutter::EncodableValue("userName")));
      auto pwd = std::get<std::string>(arguments->at(flutter::EncodableValue("pwd")));
      
      // TODO: Implement password setting
      result->Success(flutter::EncodableValue(true));
    } else {
      result->Error("Invalid arguments", "Expected map");
    }
  } else {
    result->NotImplemented();
  }
}

}  // namespace hk_flutter

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
#include <string>
#include <HCNetSDK.h>

namespace hk_flutter {

// 全局变量
LONG m_lUserID = -1;  // 用户ID

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
      // 获取参数
      auto ip = std::get<std::string>(arguments->at(flutter::EncodableValue("ip")));
      auto port = std::get<std::string>(arguments->at(flutter::EncodableValue("port")));
      auto userName = std::get<std::string>(arguments->at(flutter::EncodableValue("userName")));
      auto password = std::get<std::string>(arguments->at(flutter::EncodableValue("password")));

      int portNum = atoi(port.c_str());

      // 初始化SDK
      if (!NET_DVR_Init()) {
        DWORD error = NET_DVR_GetLastError();
        std::string errorMsg = R"(SDK初始化失败，错误码：)" + std::to_string(error);
        result->Error("SDK_INIT_FAILED", errorMsg.c_str());
        return;
      }

      // 设置连接超时时间和重连时间
      NET_DVR_SetConnectTime(2000, 1);
      NET_DVR_SetReconnect(5000, true);

      // 设置登录参数
      NET_DVR_USER_LOGIN_INFO loginInfo = { 0 };
      loginInfo.bUseAsynLogin = 0;  // 同步登录

      // 安全地复制字符串
      strncpy_s(loginInfo.sDeviceAddress, sizeof(loginInfo.sDeviceAddress), ip.c_str(), _TRUNCATE);
      loginInfo.wPort = static_cast<WORD>(portNum);
      strncpy_s(loginInfo.sUserName, sizeof(loginInfo.sUserName), userName.c_str(), _TRUNCATE);
      strncpy_s(loginInfo.sPassword, sizeof(loginInfo.sPassword), password.c_str(), _TRUNCATE);

      // 设备信息
      NET_DVR_DEVICEINFO_V40 struDeviceInfoV40 = { 0 };

      // 登录设备
      m_lUserID = NET_DVR_Login_V40(&loginInfo, &struDeviceInfoV40);
      if (m_lUserID < 0) {
        DWORD error = NET_DVR_GetLastError();
        std::string errorMsg = R"(设备登录失败，错误码：)" + std::to_string(error);
        NET_DVR_Cleanup();
        result->Error("LOGIN_FAILED", errorMsg.c_str());
        return;
      }

      result->Success(flutter::EncodableValue(true));
    } else {
      result->Error("INVALID_ARGUMENTS", "参数无效");
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
      result->Error("INVALID_ARGUMENTS", "参数无效");
    }
  } else {
    result->NotImplemented();
  }
}

}  // namespace hk_flutter

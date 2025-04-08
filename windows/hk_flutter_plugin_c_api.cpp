#include "include/hk_flutter/hk_flutter_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "hk_flutter_plugin.h"

void HkFlutterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  hk_flutter::HkFlutterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

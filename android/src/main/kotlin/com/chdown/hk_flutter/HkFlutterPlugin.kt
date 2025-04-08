package com.chdown.hk_flutter

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** HkFlutterPlugin */
class HkFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "hk_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "initCamera" -> {
        val ip = call.argument<String>("ip") ?: ""
        val port = call.argument<String>("port") ?: ""
        val userName = call.argument<String>("userName") ?: ""
        val password = call.argument<String>("password") ?: ""
        val flag = call.argument<Int>("flag") ?: 0
        
        // TODO: 实现海康SDK初始化
        result.success(true)
      }
      "setVideoInfo" -> {
        // TODO: 实现设置视频信息
        result.success(true)
      }
      "setOSDInfo" -> {
        // TODO: 实现设置OSD信息
        result.success(true)
      }
      "setNtp" -> {
        // TODO: 实现设置NTP
        result.success(true)
      }
      "setTime" -> {
        // TODO: 实现设置时间
        result.success(true)
      }
      "setPwd" -> {
        val userName = call.argument<String>("userName") ?: ""
        val pwd = call.argument<String>("pwd") ?: ""
        
        // TODO: 实现设置密码
        result.success(true)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

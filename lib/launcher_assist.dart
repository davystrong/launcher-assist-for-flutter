import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';

class LauncherAssist {
  static const MethodChannel _channel = const MethodChannel('launcher_assist');

  /// Returns a list of apps installed on the user's device
  static Future<List<Map<String, dynamic>>> getAllApps() async {
    List<dynamic> data = await _channel.invokeMethod<List<dynamic>>('getAllApps');
    return data.cast<Map<dynamic, dynamic>>().map((data) => data.cast<String, dynamic>())
         .toList();
  }

  /// Launches an app using its package name
  static void launchApp(String packageName) {
    _channel.invokeMethod("launchApp", {"packageName": packageName});
  }

  /// Gets you the current wallpaper on the user's device. This method
  /// needs the READ_EXTERNAL_STORAGE permission on Android Oreo.
  static Future<Uint8List> getWallpaper() async {
    Uint8List data = await _channel.invokeMethod<Uint8List>('getWallpaper');
    return data;
  }
}
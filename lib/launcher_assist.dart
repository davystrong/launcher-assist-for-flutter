import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';

class LauncherAssist {
  static const MethodChannel _channel = const MethodChannel('launcher_assist');

  /// Returns a list of apps installed on the user's device
  static Future<List<AppInfo>> getAllApps() async {
    List<dynamic> data =
        await _channel.invokeMethod<List<dynamic>>('getAllApps');
    List<Map<String, dynamic>> allApps = data
        .cast<Map<String, dynamic>>()
        .map((data) => data.cast<String, dynamic>())
        .toList();

    return allApps
        .map<AppInfo>((Map<String, dynamic> data) => AppInfo.fromMap(data));
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

/// A representation of the app info for better autocomplete
class AppInfo {
  /// Complete package name
  final String package;

  /// User readable app name
  final String label;

  /// App icon
  final Uint8List icon;

  AppInfo.fromMap(Map<String, dynamic> data)
      : package = data['package'],
        label = data['label'],
        icon = data['icon'];
}

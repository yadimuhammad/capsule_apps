import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final _getStorage = GetStorage();
  final _storageKey = 'ThemeMode';
  static ThemeServices instance = ThemeServices._();

  ThemeServices._();
  set themeMode(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system) {
      _getStorage.remove(_storageKey);
    } else {
      _getStorage.write(_storageKey, themeMode == ThemeMode.light);
    }
    Get.changeThemeMode(themeMode);
  }

  ThemeMode get themeMode {
    switch (_getStorage.read(_storageKey)) {
      case true:
        return ThemeMode.light;
      case false:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

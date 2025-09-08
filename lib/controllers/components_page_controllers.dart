import 'package:capsule_apps/base/base_controllers.dart';
import 'package:capsule_apps/utils/themes/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ComponentsPageControllers extends BaseControllers {
  RxBool isSwitched = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize switch based on current theme from storage
    final currentTheme = ThemeServices.instance.themeMode;
    isSwitched.value = currentTheme == ThemeMode.dark;
  }

  void toggleTheme() {
    isSwitched.value = !isSwitched.value;
    ThemeServices.instance.themeMode = isSwitched.value
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}

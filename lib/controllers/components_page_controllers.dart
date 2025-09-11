import '../base/base_controllers.dart';
import '../utils/languages/languages.dart';
import '../utils/themes/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ComponentsPageControllers extends BaseControllers {
  RxBool isSwitched = false.obs;
  RxBool isSwitchedLanguage = false.obs;

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

  void toggleLanguage() {
    isSwitchedLanguage.value = !isSwitchedLanguage.value;
    Languages().changeLocale(
      isSwitchedLanguage.value ? 'Indonesia' : 'English',
    );
  }
}

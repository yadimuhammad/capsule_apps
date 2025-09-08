import 'dart:ui';

import 'package:capsule_apps/utils/languages/language_controller.dart';
import 'package:get/get.dart';

class Languages extends Translations {
  static final locale = Locale('en', 'US');
  static final fallBackLocale = Locale('en', 'US');

  static final langs = ['Indonesia', 'English'];

  static final locales = [Locale('id', 'ID'), Locale('en', 'US')];
  final LanguageController l = (() {
    try {
      return Get.find<LanguageController>();
    } catch (_) {
      return Get.put(LanguageController());
    }
  })();

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': l.langEN,
    'id_ID': l.langID,
  };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}

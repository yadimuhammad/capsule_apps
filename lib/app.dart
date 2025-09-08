import 'package:capsule_apps/pages/root.dart';
import 'package:capsule_apps/utils/constants.dart';
import 'package:capsule_apps/utils/languages/languages.dart';
import 'package:capsule_apps/utils/themes/app_theme.dart';
import 'package:capsule_apps/utils/themes/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MainApp(home: Root()),
        if (F.appFlavor != Flavor.production)
          Positioned(right: 0, top: 120, child: _flavorBanner(context)),
      ],
    );
  }

  Widget _flavorBanner(context) {
    return IgnorePointer(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: kPaddingSmall,
            horizontal: kPaddingMedium,
          ),
          color: Theme.of(context).colorScheme.error.withAlpha(150),
          child: Text(
            F.name,
            textDirection: TextDirection.ltr,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  final Widget home;
  const MainApp({required this.home, super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: F.title,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeServices.instance.themeMode,
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: Languages.locale,
      fallbackLocale: Languages.fallBackLocale,
      home: home,
    );
  }
}

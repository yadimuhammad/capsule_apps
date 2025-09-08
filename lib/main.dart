import 'package:capsule_apps/firebase_options.dart';
import 'package:capsule_apps/utils/env_loader.dart';
import 'package:capsule_apps/utils/languages/language_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'flavors.dart';

void main() async {
  await setupInitializers();
  runApp(const App());
}

Future<void> setupInitializers() async {
  WidgetsFlutterBinding.ensureInitialized();
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );
  await GetStorage.init();

  const environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'dev',
  );

  switch (environment) {
    case 'dev':
      await EnvLoader.load(fileName: ".dev.env");
      break;
    case 'prod':
      await EnvLoader.load(fileName: ".prod.env");
      break;
  }

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // print('here Failed to initialize Firebase: $e');
  }

  // Initialize language controller with error handling
  try {
    LanguageController languageController = Get.put(
      LanguageController(),
      permanent: true,
    );
    await languageController.getLanguages();
  } catch (e) {
    // Set default language or continue with cached language
  }
}

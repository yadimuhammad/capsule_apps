import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
}

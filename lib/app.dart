import 'package:capsule_apps/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'flavors.dart';
import 'pages/my_home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: F.title,
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: Stack(
        alignment: Alignment.center,
        children: [
          MyHomePage(),

          if (F.appFlavor != Flavor.production)
            Positioned(right: 0, top: 120, child: _flavorBanner(context)),
        ],
      ),
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
          color: kColorError.withAlpha(150),
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

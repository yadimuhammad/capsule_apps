import 'package:capsule_apps/controllers/root_controllers.dart';
import 'package:capsule_apps/pages/components_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends StatelessWidget {
  Root({super.key});
  final RootControllers controllers = Get.put(
    RootControllers(),
    permanent: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true, body: ComponentsPage());
  }
}

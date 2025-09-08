import 'package:capsule_apps/components/custom_switch.dart';
import 'package:capsule_apps/controllers/components_page_controllers.dart';
import 'package:capsule_apps/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComponentsPage extends StatelessWidget {
  ComponentsPage({super.key});

  final ComponentsPageControllers controllers = Get.put(
    ComponentsPageControllers(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Capsule Apps')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: kPaddingSmall),
                child: Row(
                  children: [
                    Expanded(child: Text('dark_mode_str'.tr)),
                    Obx(
                      () => CustomSwitch(
                        value: controllers.isSwitched.value,
                        onChanged: (value) => controllers.toggleTheme(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: kPaddingSmall),
                child: Row(
                  children: [
                    Expanded(child: Text('language_str'.tr)),
                    Obx(
                      () => CustomSwitch(
                        value: controllers.isSwitchedLanguage.value,
                        onChanged: (value) => controllers.toggleLanguage(),
                      ),
                    ),
                  ],
                ),
              ),
              Text('hi_str'.tr),
            ],
          ),
        ),
      ),
    );
  }
}

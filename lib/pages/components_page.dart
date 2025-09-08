import 'package:capsule_apps/components/custom_accordion.dart';
import 'package:capsule_apps/components/custom_appbar.dart';
import 'package:capsule_apps/components/custom_base_dialog.dart';
import 'package:capsule_apps/components/custom_bottom_sheet.dart';
import 'package:capsule_apps/components/custom_button.dart';
import 'package:capsule_apps/components/custom_dialog_content.dart';
import 'package:capsule_apps/components/custom_dropdown.dart';
import 'package:capsule_apps/components/custom_radio_button.dart';
import 'package:capsule_apps/components/custom_switch.dart';
import 'package:capsule_apps/components/custom_text_field.dart';
import 'package:capsule_apps/controllers/components_page_controllers.dart';
import 'package:capsule_apps/pages/on_boarding/on_boarding_page.dart';
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
      resizeToAvoidBottomInset: true,
      appBar: CustomAppbar(titles: 'Components', context: context),
      // AppBar(title: Text('Capsule Apps')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kPaddingMedium),
              cardWrapper(
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: 'On Boarding',
                        onPressed: () => Get.to(() => OnboardingScreen()),
                      ),
                    ),
                    SizedBox(width: kPaddingSmall),
                    Expanded(
                      child: CustomButton(title: 'Login', onPressed: () {}),
                    ),
                  ],
                ),
              ),
              cardWrapper(
                Row(
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
              cardWrapper(
                Row(
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
              cardWrapper(
                CustomTextField(
                  label: 'full_name_str'.tr,
                  hint: 'full_name_hint_str'.tr,
                ),
              ),
              cardWrapper(
                Row(
                  children: [
                    Expanded(
                      child: CustomRadioButton(
                        index: 0,
                        selectedIndex: 0,
                        title: 'gender_male_str'.tr,
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: CustomRadioButton(
                        index: 1,
                        selectedIndex: 0,
                        title: 'gender_female_str'.tr,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              cardWrapper(
                CustomAccordion(
                  title: Text('Accordion'),
                  widgets: Text('Content'),
                ),
              ),
              cardWrapper(
                CustomButton(
                  title: 'Dialog',
                  onPressed: () =>
                      CustomBaseDialog(context: context, child: Text('dialog')),
                ),
              ),
              cardWrapper(
                CustomButton(
                  title: 'Confirm Dialog',
                  onPressed: () => CustomBaseDialog(
                    context: context,
                    child: CustomDialogContent(
                      message: 'Dialog Content',
                      onTap: () => Get.back(),
                    ),
                  ),
                ),
              ),
              cardWrapper(
                CustomButton(
                  title: 'Bottom Sheet',
                  onPressed: () => CustomBottomSheet(
                    title: 'Bottom Sheet',
                    content: Text('Bottom Sheet Content'),
                  ),
                ),
              ),
              cardWrapper(
                CapsuleDropdown(
                  context: context,
                  enabled: true,
                  disableSearch: true,
                  title: 'Dropdown',
                  item: ['Item 1', 'Item 2', 'Item 3'],
                  onChanged: (value) {},
                ),
              ),
              cardWrapper(
                CustomTextField(
                  label: 'full_name_str'.tr,
                  hint: 'full_name_hint_str'.tr,
                  isPhoneNumber: true,
                ),
              ),
              cardWrapper(
                CustomTextField(
                  label: 'full_name_str'.tr,
                  hint: 'full_name_hint_str'.tr,
                  isPassword: true,
                ),
              ),
              cardWrapper(
                CustomTextField(
                  label: 'full_name_str'.tr,
                  hint: 'full_name_hint_str'.tr,
                  isTextArea: true,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  cardWrapper(child) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: kPaddingSmall),
      child: child,
    );
  }
}

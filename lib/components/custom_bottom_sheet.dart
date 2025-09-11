import '../components/custom_base_dialog.dart';
import '../utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet {
  final String title;
  final Widget content;
  final bool? noPadding;
  final bool? dismissable;
  final double? radius;
  final TextStyle? titleStyle;
  CustomBottomSheet({
    required this.content,
    required this.title,
    this.noPadding,
    this.dismissable,
    this.radius,
    this.titleStyle,
  }) {
    if (kIsWeb) {
      CustomBaseDialog(context: Get.context!, title: title, child: content);
    } else {
      Get.bottomSheet(
        SafeArea(
          bottom: true,
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(
              horizontal: noPadding != true ? kPaddingMedium : 0,
              vertical: noPadding != true ? kPaddingLarge : 0,
            ),
            constraints: BoxConstraints(
              maxHeight: Get.height / 1.2,
              minHeight: 200,
            ),
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius ?? 20),
                topRight: Radius.circular(radius ?? 20),
              ),
            ),
            child: SingleChildScrollView(
              // make scrollable to avoid overflow
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style:
                              titleStyle ??
                              Theme.of(Get.context!).textTheme.titleMedium,
                        ),
                      ),
                      dismissable == false
                          ? Container()
                          : GestureDetector(
                              onTap: () => Get.back(),
                              child: Icon(Icons.close),
                            ),
                    ],
                  ),
                  content,
                ],
              ),
            ),
          ),
        ),
        isScrollControlled: true,
        enableDrag: dismissable ?? true,
        isDismissible: dismissable ?? true,
      );
    }
  }
}

import 'dart:ui';

import 'package:capsule_apps/components/keyboard_aware_wrapper.dart';
import 'package:capsule_apps/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBaseDialog {
  BuildContext context;
  Widget child;
  bool? bgIsBlurred;
  String? title;
  bool? barrierDismissable;
  CustomBaseDialog({
    Color? bgColor,
    required this.context,
    required this.child,
    this.bgIsBlurred,
    this.title,
    this.barrierDismissable,
  }) {
    final bool isWideScreen = kIsWeb;
    Get.dialog(
      _blurBackground(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: kPaddingMedium),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: EdgeInsets.all(kPaddingMedium),
                  decoration: BoxDecoration(
                    color: Colors.white, // semi-transparent white
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.5),
                        Colors.white.withValues(alpha: 0.5), // putih tengah
                        Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.5),
                      ],
                      stops: [0.0, 0.5, 1.0],
                    ),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: isWideScreen
                        ? (Get.width >= 800 ? Get.width / 3 : Get.width)
                        : Get.width,
                  ),
                  child: Center(
                    child: Container(
                      width: isWideScreen
                          ? (Get.width >= 800 ? Get.width / 3 : Get.width)
                          : Get.width,
                      padding: EdgeInsets.all(kPaddingLarge),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (title != null)
                            Container(
                              width: Get.width,
                              padding: EdgeInsets.only(bottom: kPaddingMedium),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      title!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Get.back(),
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Icon(Icons.close),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          child,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissable ?? true,
    );
  }

  _blurBackground({required Widget child}) {
    return Center(
      child: KeyboardAwareWrapper(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kPaddingMedium),
          child: bgIsBlurred != true
              ? child
              : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: EdgeInsets.all(kPaddingMedium),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: 0.4),
                        border: Border.all(color: Color(0x404B6980)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: child,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

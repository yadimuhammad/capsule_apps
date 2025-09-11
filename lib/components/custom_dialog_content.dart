import '../utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogContent extends StatelessWidget {
  final String message;
  final Function() onTap;
  final String? textButtonPos;
  final Widget? icon;
  final bool? isCancelable;

  const CustomDialogContent({
    super.key,
    required this.message,
    required this.onTap,
    this.textButtonPos,
    this.icon,
    this.isCancelable,
  });

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = kIsWeb && Get.width > 600;
    return SizedBox(
      width: isWideScreen ? Get.width / 3 : Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: kPaddingSmall),
          SizedBox(
            width: 60,
            height: 50,
            // child:
            //     icon ?? Utils.cachedSvgWrapper('icon/ic-dialog-question.svg'),
          ),
          SizedBox(height: kPaddingMedium),
          SizedBox(
            width: Get.width,
            child: Text(message, textAlign: TextAlign.center),
          ),
          SizedBox(height: kPaddingMedium),
          SizedBox(
            width: Get.width,
            child: Row(
              children: [
                if (isCancelable != false)
                  Expanded(
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        side: WidgetStateProperty.all(
                          BorderSide(color: Color(0xFFD1D1D1)),
                        ),
                        foregroundColor: WidgetStateProperty.all(
                          Color(0xFF0C9DEB),
                        ),
                        padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(horizontal: kPaddingSmall),
                        ),
                      ),
                      child: Text(
                        'label_cancel'.tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ),
                if (isCancelable != false) SizedBox(width: kPaddingMedium),
                Expanded(
                  child: FilledButton(
                    onPressed: onTap,
                    child: Text(textButtonPos ?? 'label_sure'.tr),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

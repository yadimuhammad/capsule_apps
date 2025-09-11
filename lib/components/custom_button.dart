import '../base/base_controllers.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final double? width;
  final BaseControllers? controller;
  final Function()? onPressed;
  final double? radius;
  final Color? backgroundColor;
  final Color? foregorundColor;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  // Analytics parameters
  final String? analyticsName;
  final String? analyticsSection;
  final Map<String, dynamic>? analyticsData;
  final bool enableAnalytics;

  const CustomButton({
    super.key,
    this.title,
    this.onPressed,
    this.width,
    this.radius,
    this.backgroundColor,
    this.foregorundColor,
    this.borderColor,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.analyticsName,
    this.analyticsSection,
    this.analyticsData,
    this.enableAnalytics = true,
  });

  /// Handle button press with analytics tracking
  void _handlePress() {
    // Execute original callback
    onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: controller == null
          ? FilledButton(
              onPressed: controller?.state.value == ControllerState.loading
                  ? null
                  : (onPressed != null ? _handlePress : null),
              style: FilledButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: foregorundColor,
                disabledBackgroundColor: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.5),
                disabledForegroundColor: Color(0xFF6D6D6D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 8),
                  side: BorderSide(color: borderColor ?? Colors.transparent),
                ),
              ),
              child: controller?.state.value == ControllerState.loading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    )
                  : Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (prefixIcon != null)
                          Container(
                            padding: EdgeInsets.only(right: kPaddingExtraSmall),
                            child: prefixIcon,
                          ),
                        Text(title ?? ''),
                        if (suffixIcon != null)
                          Container(
                            padding: EdgeInsets.only(left: kPaddingExtraSmall),
                            child: suffixIcon,
                          ),
                      ],
                    ),
            )
          : Obx(
              () => FilledButton(
                onPressed: controller?.state.value == ControllerState.loading
                    ? null
                    : (onPressed != null ? _handlePress : null),
                style: FilledButton.styleFrom(
                  backgroundColor: backgroundColor,
                  foregroundColor: foregorundColor,
                  disabledBackgroundColor: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                  disabledForegroundColor: Color(0xFF6D6D6D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius ?? 8),
                    side: BorderSide(color: borderColor ?? Colors.transparent),
                  ),
                ),
                child: controller?.state.value == ControllerState.loading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      )
                    : Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          if (prefixIcon != null)
                            Container(
                              padding: EdgeInsets.only(
                                right: kPaddingExtraSmall,
                              ),
                              child: prefixIcon,
                            ),
                          Text(title ?? ''),
                          if (suffixIcon != null)
                            Container(
                              padding: EdgeInsets.only(
                                left: kPaddingExtraSmall,
                              ),
                              child: suffixIcon,
                            ),
                        ],
                      ),
              ),
            ),
    );
  }
}

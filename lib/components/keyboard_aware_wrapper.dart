import 'package:flutter/material.dart';

class KeyboardAwareWrapper extends StatelessWidget {
  final Widget child;
  final bool enableScroll;
  final EdgeInsets? padding;

  const KeyboardAwareWrapper({
    super.key,
    required this.child,
    this.enableScroll = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    if (!enableScroll) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.only(bottom: keyboardHeight),
        child: child,
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.only(
            bottom: keyboardHeight,
            left: padding?.left ?? 0,
            right: padding?.right ?? 0,
            top: padding?.top ?? 0,
          ),
          child: child,
        ),
      ),
    );
  }
}

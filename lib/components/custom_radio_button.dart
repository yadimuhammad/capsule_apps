import '../utils/constants.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String? title;
  final Widget? widget;
  final Function() onTap;
  const CustomRadioButton({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
    this.title,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: kPaddingSmall,
        children: [
          index == selectedIndex
              ? Icon(
                  Icons.radio_button_checked,
                  color: Theme.of(context).colorScheme.primary,
                )
              : Icon(
                  Icons.radio_button_unchecked,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
          widget ??
              Text(
                title ?? 'title',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: index == selectedIndex
                      ? FontWeight.w700
                      : FontWeight.w400,
                ),
              ),
        ],
      ),
    );
  }
}

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CapsuleDropdown extends StatelessWidget {
  final String title;
  final List<String> item;
  final String? selectedItem;
  final bool enabled;
  final Function(String?)? onChanged;
  final Color? borderColor;
  final bool? disableSearch;
  final String? errorText;
  final bool hasError;
  final BuildContext context;

  const CapsuleDropdown({
    super.key,
    required this.item,
    this.selectedItem,
    required this.title,
    required this.enabled,
    required this.onChanged,
    this.borderColor,
    this.disableSearch,
    this.errorText,
    this.hasError = false,
    required this.context,
  });

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: kPaddingSmall),
        Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: const InputDecorationTheme(
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              isDense: true,
            ),
          ),
          child: disableSearch == true
              ? CustomDropdown<String>(
                  hintText: "select_value_str".tr,
                  enabled: enabled,
                  closedHeaderPadding: EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 12,
                  ),
                  overlayHeight: 180,
                  disabledDecoration: CustomDropdownDisabledDecoration(
                    borderRadius: BorderRadius.circular(8),
                    fillColor: Theme.of(context).colorScheme.secondary,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    headerStyle: Theme.of(context).textTheme.bodyMedium,
                    suffixIcon: Container(),
                    border: Border.all(
                      color: borderColor ?? Theme.of(context).dividerColor,
                    ),
                  ),
                  decoration: CustomDropdownDecoration(
                    closedBorderRadius: BorderRadius.circular(8),
                    expandedBorderRadius: BorderRadius.circular(8),
                    searchFieldDecoration: SearchFieldDecoration(
                      fillColor: Theme.of(context).colorScheme.secondary,
                    ),
                    closedFillColor: Theme.of(context).colorScheme.surface,
                    expandedFillColor: Theme.of(context).colorScheme.surface,
                    closedBorder: Border.all(
                      color: hasError
                          ? Colors.red
                          : Theme.of(context).dividerColor,
                    ),
                    expandedBorder: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                    listItemStyle: Theme.of(context).textTheme.bodyMedium,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    headerStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  items: item,
                  onChanged: onChanged,
                  initialItem: selectedItem,
                )
              : CustomDropdown<String>.search(
                  enabled: enabled,
                  hintText: "select_value_str".tr,
                  searchHintText: "select_value_str".tr,
                  closedHeaderPadding: EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 12,
                  ),
                  disabledDecoration: CustomDropdownDisabledDecoration(
                    borderRadius: BorderRadius.circular(8),
                    fillColor: Theme.of(context).colorScheme.secondary,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    headerStyle: Theme.of(context).textTheme.bodyMedium,
                    suffixIcon: Container(),
                    border: Border.all(
                      color:
                          borderColor ??
                          Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  decoration: CustomDropdownDecoration(
                    closedBorderRadius: BorderRadius.circular(8),
                    expandedBorderRadius: BorderRadius.circular(8),
                    searchFieldDecoration: SearchFieldDecoration(
                      fillColor: Theme.of(context).colorScheme.secondary,
                    ),
                    closedFillColor: Theme.of(context).colorScheme.surface,
                    expandedFillColor: Theme.of(context).colorScheme.surface,
                    closedBorder: Border.all(
                      color: hasError
                          ? Colors.red
                          : Theme.of(context).dividerColor,
                    ),
                    expandedBorder: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                    listItemStyle: Theme.of(context).textTheme.bodyMedium,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    headerStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  items: item,
                  onChanged: onChanged,
                  initialItem: selectedItem,
                ),
        ),
        if (errorText != null && errorText!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: kPaddingSmall),
            child: Text(
              errorText!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.red),
            ),
          ),
      ],
    );
  }
}

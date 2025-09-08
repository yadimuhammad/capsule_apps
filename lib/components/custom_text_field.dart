import 'package:capsule_apps/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final bool? isPassword;
  final Color? fillColor;
  final bool? enabled;
  final bool? isTextArea;
  final String? initialValue;
  final TextEditingController? textController;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffix;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final double height;
  final Function()? onEditingComplete;
  final bool? isPhoneNumber;
  final List<Widget>? items;
  final String? errorText;
  final bool hasError;
  final String? prefixHelperText;
  final String? suffixHelperText;
  final Widget? suffixIcon;
  final bool? isCapslockOn;
  final bool? isCurrency;
  final bool? isDigitOnly;

  const CustomTextField({
    super.key,
    this.hint,
    this.label,
    this.isPassword,
    this.enabled,
    this.fillColor,
    this.isTextArea,
    this.initialValue,
    this.textController,
    this.onChanged,
    this.onSubmitted,
    this.borderColor,
    this.prefixIcon,
    this.onEditingComplete,
    this.suffix,
    this.maxLength,
    this.textInputAction,
    this.keyboardType,
    this.height = 48,
    this.isPhoneNumber,
    this.items,
    this.errorText,
    this.hasError = false,
    this.prefixHelperText,
    this.suffixHelperText,
    this.suffixIcon,
    this.isCapslockOn,
    this.isCurrency,
    this.isDigitOnly,
  });

  @override
  Widget build(BuildContext context) {
    RxBool isObsecured = (isPassword ?? false).obs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(label!, style: Theme.of(context).textTheme.bodyMedium),
        if (label != null) SizedBox(height: kPaddingSmall),
        Obx(
          () => SizedBox(
            height: height,
            child: Row(
              children: [
                if (prefixHelperText != null && isPhoneNumber != true)
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,

                      border: Border(
                        bottom: getPhoneBorder(context),
                        left: getPhoneBorder(context),
                        top: getPhoneBorder(context),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kRadiusSmall),
                        bottomLeft: Radius.circular(kRadiusSmall),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: kPaddingMedium),
                    child: Center(
                      child: Text(
                        prefixHelperText!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                if (isPhoneNumber == true)
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,

                      border: Border(
                        bottom: getPhoneBorder(context),
                        left: getPhoneBorder(context),
                        top: getPhoneBorder(context),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kRadiusSmall),
                        bottomLeft: Radius.circular(kRadiusSmall),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: kPaddingMedium),
                    child: Center(
                      child: Text(
                        '08',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                Expanded(
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    obscureText: isObsecured.value,
                    enabled: enabled,
                    onChanged: onChanged,
                    onFieldSubmitted: onSubmitted,
                    onEditingComplete: onEditingComplete,
                    maxLines: isTextArea == true ? 3 : 1,
                    inputFormatters: _getInputFormatters(),
                    textInputAction: textInputAction,
                    keyboardType: _getKeyboardType(),
                    controller: textController,
                    initialValue: initialValue,
                    maxLength: maxLength,
                    decoration: InputDecoration(
                      counterText: '',
                      // label: Text('hehe'), //for floating label
                      hintText: hint,
                      hintStyle: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                      prefixIcon: prefixIcon != null
                          ? ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 0,
                                minHeight: 0,
                                maxWidth: 40,
                                maxHeight: 40,
                              ),
                              child: prefixIcon,
                            )
                          : null,
                      suffix: suffix,
                      suffixIcon: isPassword != true
                          ? null
                          : GestureDetector(
                              onTap: () =>
                                  isObsecured.value = !isObsecured.value,
                              child: Icon(
                                isObsecured.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),

                      fillColor:
                          fillColor ??
                          (enabled == false
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.transparent),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: getBorderRadius(),
                        borderSide: BorderSide(
                          color: hasError
                              ? Colors.red
                              : (borderColor ??
                                    Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: getBorderRadius(),
                        borderSide: BorderSide(
                          color: hasError
                              ? Colors.red
                              : (borderColor ??
                                    (Theme.of(context).dividerColor)),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: getBorderRadius(),
                        borderSide: BorderSide(
                          color: hasError
                              ? Colors.red
                              : (borderColor ??
                                    (Theme.of(context).dividerColor)),
                        ),
                      ),
                    ),
                  ),
                ),
                if (suffixHelperText != null && isPhoneNumber != true)
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,

                      border: Border(
                        bottom: getPhoneBorder(context),
                        right: getPhoneBorder(context),
                        top: getPhoneBorder(context),
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(kRadiusSmall),
                        bottomRight: Radius.circular(kRadiusSmall),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: kPaddingMedium),
                    child: Center(
                      child: Text(
                        suffixHelperText!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
              ],
            ),
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
        if (items != null)
          if (items!.isNotEmpty)
            Container(
              width: Get.width,
              constraints: BoxConstraints(maxHeight: 100),
              padding: EdgeInsets.all(kPaddingSmall),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(kRadiusSmall),
              ),
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = -0; i < items!.length; i++) items![i],
                    ],
                  ),
                ),
              ),
            ),
      ],
    );
  }

  BorderRadius getBorderRadius() => BorderRadius.only(
    topLeft: Radius.circular(
      isPhoneNumber == true
          ? 0
          : (prefixHelperText != null && isPhoneNumber != true)
          ? 0
          : kRadiusSmall,
    ),
    topRight: Radius.circular(suffixHelperText != null ? 0 : kRadiusSmall),
    bottomLeft: Radius.circular(
      isPhoneNumber == true
          ? 0
          : (prefixHelperText != null && isPhoneNumber != true)
          ? 0
          : kRadiusSmall,
    ),
    bottomRight: Radius.circular(suffixHelperText != null ? 0 : kRadiusSmall),
  );

  BorderSide getPhoneBorder(context) =>
      BorderSide(color: Theme.of(context).dividerColor);

  List<TextInputFormatter>? _getInputFormatters() {
    List<TextInputFormatter> formatters = [];

    if (isCapslockOn == true) {
      formatters.add(UpperCaseTextFormatter());
    }

    if (isCurrency == true) {
      formatters.add(CurrencyInputFormatter());
    }

    if (isDigitOnly == true) {
      formatters.add(FilteringTextInputFormatter.digitsOnly);
    }

    return formatters.isEmpty ? null : formatters;
  }

  TextInputType? _getKeyboardType() {
    if (isPhoneNumber == true) {
      return TextInputType.phone;
    } else if (isCurrency == true) {
      return TextInputType.number;
    } else {
      return keyboardType;
    }
  }
}

// Custom formatter untuk memaksa huruf kapital
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

// Custom formatter untuk format currency
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Hapus semua karakter non-digit
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Jika kosong, return kosong
    if (digitsOnly.isEmpty) {
      return newValue.copyWith(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Format dengan titik sebagai pemisah ribuan
    String formatted = _formatCurrency(digitsOnly);

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatCurrency(String value) {
    // Reverse string untuk memudahkan penambahan titik
    String reversed = value.split('').reversed.join('');
    String formatted = '';

    for (int i = 0; i < reversed.length; i++) {
      if (i > 0 && i % 3 == 0) {
        formatted += '.';
      }
      formatted += reversed[i];
    }

    // Reverse kembali untuk mendapatkan format yang benar
    return formatted.split('').reversed.join('');
  }
}

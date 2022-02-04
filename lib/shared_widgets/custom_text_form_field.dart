import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/res/res.dart';

class CustomTextFormField extends StatelessWidget {
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final bool? hideInput;
  final TextEditingController? controller;
  final List<TextInputFormatter>? textInputFormatter;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final ValueChanged<String>? onChanged;
  final Widget? prefix;
  final Widget? suffix;
  final bool? isAutofocus;
  final double? borderRadius;
  final String? initialValue;
  final bool? filled;
  final bool? fillcolor;
  final bool? isReadOnly;
  final Function()? onTab;
  final int? maxCount;
  final int? minCount;
  final bool? isUpperCase;
  final bool? isEnable;
  final TextInputType? inputType;
  final Widget? prefixText;
  final TextStyle? style;

  const CustomTextFormField(
      {Key? key,
      this.onChanged,
      this.fillcolor,
      this.filled,
      this.maxCount,
      this.prefixText,
      this.hideInput,
      this.isUpperCase,
      this.errorText,
      this.isAutofocus,
      this.labelText,
      this.hintText,
      this.controller,
      this.textInputFormatter,
      this.hintStyle,
      this.labelStyle,
      this.prefix,
      this.inputType,
      this.style,
      this.minCount,
      this.onTab,
      this.isReadOnly,
      this.borderRadius,
      this.initialValue,
      this.isEnable,
      this.suffix})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
          enabled: isEnable,
          style: style ??
              textStyles.kTextSubtitle1.copyWith(color: colors.kColorWhite),
          autofocus: isAutofocus ?? false,
          minLines: 1,
          maxLines: hideInput ?? false ? 1 : 5,
          controller: controller,
          readOnly: isReadOnly ?? false,
          onTap: onTab,
          obscureText: hideInput ?? false,
          keyboardType: inputType,
          textCapitalization: isUpperCase ?? false
              ? TextCapitalization.characters
              : TextCapitalization.none,
          inputFormatters: textInputFormatter,
          initialValue: initialValue,
          maxLength: maxCount,
          onChanged: onChanged,
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            labelText: labelText,
            prefixIcon: prefix,
            suffixIcon: suffix,
            prefix: prefixText,
            counterText: '',
            hintText: hintText,
            errorText: errorText,
            labelStyle: labelStyle ??
                const TextStyle(
                  fontWeight: FontWeight.w400,
                  // fontSize: sizes.smallFontSize,
                  fontSize: 16,
                  color: Colors.white12,
                ),
            hintStyle: hintStyle ??
                const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white12,
                ),
          )),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

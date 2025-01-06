import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension CustomCheckBoxStyleHelper on CustomCheckboxButton {
  static BoxDecoration get outlineErrorContainer => BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(6.h),
        border: Border.all(
          color: theme.colorScheme.errorContainer.withOpacity(0.92),
          width: 1.h,
        ),
      );
}

// ignore_for_file: must_be_immutable
class CustomCheckboxButton extends StatelessWidget {
  CustomCheckboxButton({
    Key? key,
    required this.onChange,
    this.decoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    this.value,
    this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.overflow,
    this.textAlignment,
    this.isExpandedText = false,
    this.isEnabled = true, // Tambahkan ini
  }) : super(key: key);

  final BoxDecoration? decoration;
  final Alignment? alignment;
  final bool? isRightCheck;
  final double? iconSize;
  bool? value;
  final Function(bool) onChange;
  final String? text;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextOverflow? overflow;
  final TextAlign? textAlignment;
  final bool isExpandedText;
  final bool isEnabled; // Tambahkan ini

  @override
  Widget build(BuildContext context) {
    value ??= false; // Pastikan value tidak null
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildCheckBoxWidget,
          )
        : buildCheckBoxWidget;
  }

  Widget get buildCheckBoxWidget => GestureDetector(
        onTap: isEnabled
            ? () {
                value = !(value!);
                onChange(value!);
              }
            : null,
        child: Container(
          decoration: decoration,
          width: width,
          padding: padding,
          child: (isRightCheck ?? false) ? rightSideCheckbox : leftSideCheckbox,
        ),
      );

  Widget get leftSideCheckbox => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          checkboxWidget,
          Padding(
            padding: EdgeInsets.only(
                left: text != null && text!.isNotEmpty ? 8.0 : 0.0),
          ),
          isExpandedText ? Expanded(child: textWidget) : textWidget,
        ],
      );

  Widget get rightSideCheckbox => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isExpandedText ? Expanded(child: textWidget) : textWidget,
          Padding(
            padding: EdgeInsets.only(
                left: text != null && text!.isNotEmpty ? 8.0 : 0.0),
          ),
          checkboxWidget,
        ],
      );

 Widget get textWidget => Text(
        text ?? "",
        textAlign: textAlignment ?? TextAlign.start,
        overflow: overflow,
        style: (value ?? false)
            ? (textStyle ??
                theme.textTheme.bodyMedium) // Warna default jika true
            : (textStyle?.copyWith(color: Colors.black) ??
                theme.textTheme.bodyMedium?.copyWith(color: Colors.black)),
      );

  Widget get checkboxWidget => SizedBox(
        height: iconSize ?? 20.h,
        width: iconSize ?? 20.h,
        child: Checkbox(
          visualDensity: VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          value: value ?? false,
          checkColor: Colors.white,
          activeColor:
              isEnabled ? theme.colorScheme.errorContainer : Colors.grey,
          side: BorderSide(
            color: isEnabled ? theme.colorScheme.errorContainer : Colors.grey,
          ),
          onChanged: isEnabled
              ? (value) {
                  onChange(value!);
                }
              : null,
        ),
      );
}

import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  CustomRadioButton({
    Key? key,
    required this.onChange,
    this.decoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    required this.value,
    required this.groupValue,
    required this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.overflow,
    this.textAlignment,
    this.gradient,
    this.backgroundColor,
    this.disabledColor = Colors.grey, // Add default grey color
    this.activeColor = Colors.blue, // Add active color
    this.isExpandedText = false,
  }) : super(key: key);

  final BoxDecoration? decoration;
  final Alignment? alignment;
  final bool? isRightCheck;
  final double? iconSize;
  final String value;
  final String groupValue;
  final Function(String) onChange;
  final String text;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextOverflow? overflow;
  final TextAlign? textAlignment;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Color disabledColor; // New parameter for disabled state
  final Color activeColor; // New parameter for active state
  final bool isExpandedText;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return Align(
      alignment: alignment ?? Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          onChange(value);
        },
        child: Container(
          decoration: decoration,
          width: width,
          padding: padding ?? EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              Radio<String>(
                value: value,
                groupValue: groupValue,
                activeColor: activeColor,
                fillColor: MaterialStateProperty.resolveWith((states) {
                  return isSelected ? activeColor : disabledColor;
                }),
                onChanged: (val) {
                  onChange(val!);
                },
              ),
              SizedBox(width: 8), // Add space between radio and text
              if (isExpandedText)
                Expanded(child: textWidget(isSelected))
              else
                textWidget(isSelected),
            ],
          ),
        ),
      ),
    );
  }

  Widget textWidget(bool isSelected) => Text(
        text,
        textAlign: textAlignment ?? TextAlign.start,
        overflow: overflow,
        style: textStyle?.copyWith(
              color: isSelected ? Colors.black : disabledColor,
            ) ??
            TextStyle(
              color: isSelected ? Colors.black : disabledColor,
            ),
      );
}

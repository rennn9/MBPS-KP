import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class AppbarSubtitleOne extends StatelessWidget {
  AppbarSubtitleOne({Key? key, required this.text, this.onTap, this.margin})
      : super(
          key: key,
        );
  final String text;
  final Function? onTap;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Text(
          text,
          style: CustomTextStyles.labelMediumRoboto.copyWith(
            decoration: TextDecoration.underline,
            color: theme.colorScheme.errorContainer.withOpacity(1),
          ),
        ),
      ),
    );
  }
}

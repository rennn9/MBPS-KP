import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillErrorContainer => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.errorContainer.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillGreenA => ElevatedButton.styleFrom(
        backgroundColor: appTheme.greenA400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillLightBlue => ElevatedButton.styleFrom(
        backgroundColor: appTheme.lightBlue600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillLightGreenA => ElevatedButton.styleFrom(
        backgroundColor: appTheme.lightGreenA400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillPrimaryTL5 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillRed => ElevatedButton.styleFrom(
        backgroundColor: appTheme.red500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillTeal => ElevatedButton.styleFrom(
        backgroundColor: appTheme.teal400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get fillWhiteA => ElevatedButton.styleFrom(
        backgroundColor: appTheme.whiteA700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
      static ButtonStyle get fillPrimaryTL6 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  // Outline button style
  static ButtonStyle get outlineGray => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: appTheme.gray700,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get outlineGray1 => OutlinedButton.styleFrom(
        backgroundColor: appTheme.whiteA700.withOpacity(0.05),
        side: BorderSide(
          color: appTheme.gray700,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get outlineIndigo => OutlinedButton.styleFrom(
        backgroundColor: appTheme.indigo50,
        side: BorderSide(
          color: appTheme.indigo50,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
        padding: EdgeInsets.zero,
      );

  static ButtonStyle get outlinePrimaryTL6 => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: theme.colorScheme.primary,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
        padding: EdgeInsets.zero,
      );

  // Text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        elevation: WidgetStateProperty.all<double>(0),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(color: Colors.transparent),
        ),
      );
}

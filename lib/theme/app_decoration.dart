import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  // Blue decorations
  static BoxDecoration get blue300 => BoxDecoration(
        color: appTheme.blue300,
      );

  // Fill decorations
  static BoxDecoration get fillCyan => BoxDecoration(
        color: appTheme.cyan100,
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );
  static BoxDecoration get fillYellowA => BoxDecoration(
        color: appTheme.yellowA700,
      );

  // Gray decorations
  static BoxDecoration get gray100 => BoxDecoration(
        color: appTheme.blueGray50,
      );
  static BoxDecoration get gray200 => BoxDecoration(
        color: appTheme.indigo50,
        border: Border.all(
          color: appTheme.indigo50,
          width: 1.h,
        ),
      );
  static BoxDecoration get gray50 => BoxDecoration(
        color: appTheme.gray5001,
        border: Border.all(
          color: appTheme.gray30001,
          width: 1.h,
        ),
      );

  // Outline decorations
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineErrorContainer => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: theme.colorScheme.errorContainer,
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.errorContainer.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(0, 4),
          ),
        ],
      );
  static BoxDecoration get outlineErrorContainer1 => BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.errorContainer,
          width: 2.h,
        ),
      );
  static BoxDecoration get outlineGray => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: appTheme.gray30001,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGray30001 => BoxDecoration(
        border: Border.all(
          color: appTheme.gray30001,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGray700 => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: appTheme.gray700,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineGray7001 => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.05),
        border: Border(
          top: BorderSide(
            color: appTheme.gray700,
            width: 1.h,
          ),
          left: BorderSide(
            color: appTheme.gray700,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray7002 => BoxDecoration(
        border: Border(
          top: BorderSide(
            color: appTheme.gray700,
            width: 1.h,
          ),
          left: BorderSide(
            color: appTheme.gray700,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineGray7003 => BoxDecoration(
        border: Border.all(
          color: appTheme.gray700,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineWhiteA => BoxDecoration(
        border: Border.all(
          color: appTheme.whiteA700,
          width: 2.h,
        ),
      );

  // Shadow decorations
  static BoxDecoration get shadow => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.blue4003f,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(0, 0),
          ),
        ],
      );

  // White decorations
  static BoxDecoration get white => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.errorContainer.withOpacity(0.05),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(0, 0),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder52 => BorderRadius.circular(52.h);

  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(10.h);
  static BorderRadius get roundedBorder14 => BorderRadius.circular(14.h);
  static BorderRadius get roundedBorder186 => BorderRadius.circular(186.h);
  static BorderRadius get roundedBorder4 => BorderRadius.circular(4.h);
  static BorderRadius get roundedBorder48 => BorderRadius.circular(48.h);
  static BorderRadius get roundedBorder90 => BorderRadius.circular(90.h);
}

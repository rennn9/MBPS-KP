import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get firaSans {
    return copyWith(
      fontFamily: 'Fira Sans',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Body text style
  static TextStyle get bodyMediumErrorContainer =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.errorContainer.withOpacity(1),
      );

  static TextStyle get bodyMediumErrorContainer_1 =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.errorContainer.withOpacity(0.5),
      );

  static TextStyle get bodyMediumOnPrimary =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
      );

  static TextStyle get bodySmallBluegray700 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.blueGray700,
      );

  static TextStyle get bodySmallGray500 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray500,
      );

  static TextStyle get bodySmallGray600 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray600,
      );

  static TextStyle get bodySmallPoppins =>
      theme.textTheme.bodySmall!.poppins.copyWith(
        fontSize: 9.fSize,
      );

  static TextStyle get bodySmallPoppinsTeal200 =>
      theme.textTheme.bodySmall!.poppins.copyWith(
        color: appTheme.teal200,
        fontSize: 10.fSize,
      );

  static TextStyle get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
      );

  // Headline text style
  static TextStyle get headlineLargeErrorContainer =>
      theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.errorContainer.withOpacity(1),
      );

  static TextStyle get headlineSmallExtraBold =>
      theme.textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w800,
      );

  static TextStyle get headlineSmallRoboto =>
      theme.textTheme.headlineSmall!.roboto.copyWith(
        fontWeight: FontWeight.w900,
      );

  static get headlineSmall_1 => theme.textTheme.headlineSmall!;

  // Inter text style
  static TextStyle get interErrorContainer => TextStyle(
        color: theme.colorScheme.errorContainer.withOpacity(1),
        fontSize: 7.fSize,
        fontWeight: FontWeight.w600,
      ).inter;

  // Label text style
  static TextStyle get labelLargeErrorContainer =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.errorContainer.withOpacity(1),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get labelLargeErrorContainer12 =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.errorContainer.withOpacity(1),
        fontSize: 12.fSize,
      );

  static TextStyle get labelLargeErrorContainerBold =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.errorContainer.withOpacity(1),
        fontSize: 12.fSize,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get labelLargeErrorContainerBold_1 =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.errorContainer.withOpacity(1),
        fontWeight: FontWeight.w700,
      );

  static TextStyle get labelLargeFiraSansPrimary =>
      theme.textTheme.labelLarge!.firaSans.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get labelLargeMedium => theme.textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w500,
      );

  static TextStyle get labelLargeRobotoWhiteA700 =>
      theme.textTheme.labelLarge!.roboto.copyWith(
        color: appTheme.whiteA700,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w900,
      );

  static TextStyle get labelMediumBluegray200 =>
      theme.textTheme.labelMedium!.copyWith(
        color: appTheme.blueGray200,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get labelMediumErrorContainer =>
      theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.errorContainer.withOpacity(0.5),
        fontWeight: FontWeight.w600,
      );

  static TextStyle get labelMediumOnError =>
      theme.textTheme.labelMedium!.copyWith(
        color: theme.colorScheme.onError,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get labelMediumRed300 =>
      theme.textTheme.labelMedium!.copyWith(
        color: appTheme.red300,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get labelMediumRoboto =>
      theme.textTheme.labelMedium!.roboto.copyWith(
        fontWeight: FontWeight.w900,
      );

  static TextStyle get labelMediumRobotoWhiteA700 =>
      theme.textTheme.labelMedium!.roboto.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w900,
      );

  // Title text style
  static TextStyle get titleLargeErrorContainer =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.errorContainer.withOpacity(1),
      );

  static TextStyle get titleLargeErrorContainer_1 =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.errorContainer.withOpacity(0.48),
      );

  static TextStyle get titleMediumErrorContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.errorContainer.withOpacity(0.48),
        fontSize: 19.fSize,
      );

  static TextStyle get titleMediumErrorContainer_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.errorContainer.withOpacity(0.5),
      );

  static TextStyle get titleMediumFiraSans =>
      theme.textTheme.titleMedium!.firaSans.copyWith(
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleMediumPrimary =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
      );

  static TextStyle get titleMediumSemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleMediumWhiteA700 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
      );

  static TextStyle get titleSmallErrorContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.errorContainer.withOpacity(0.7),
      );

  static TextStyle get titleSmallExtraBold =>
      theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w800,
      );

  static TextStyle get titleSmallMedium => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleSmallOnPrimary =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleSmallPrimary =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );

  static TextStyle get titleSmallPrimaryContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontWeight: FontWeight.w800,
      );

  static TextStyle get titleSmallWhiteA700 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleSmallWhiteA700_1 =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.whiteA700,
      );
      static TextStyle get titleMediumOnPrimary => TextStyle(
        color: theme.colorScheme.onPrimary,
        fontSize: 16.0, // Sesuaikan ukuran font dengan kebutuhan Anda
        fontWeight: FontWeight.w500,
      );
}

import 'package:flutter/material.dart';
import '../core/app_export.dart';

String _appTheme = "lightCode";

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  // A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.whiteA700,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.redA200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          side: BorderSide(
            color: colorScheme.primary,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        side: BorderSide(
          color: colorScheme.errorContainer.withOpacity(1),
          width: 1,
        ),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: colorScheme.errorContainer,
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyMedium: TextStyle(
          color: appTheme.gray90066,
          fontSize: 14.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 12.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 38.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        headlineLarge: TextStyle(
          color: appTheme.teal200,
          fontSize: 30.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 24.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: colorScheme.errorContainer.withOpacity(0.4),
          fontSize: 13.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 11.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 9.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 20.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 16.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
          color: colorScheme.errorContainer.withOpacity(1),
          fontSize: 14.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFF3E9B97),
    primaryContainer: Color(0XFF202020),
    secondaryContainer: Color(0XFF0093DD),
    errorContainer: Color(0X19000000),
    onError: Color(0XFF48BB78),
    onPrimary: Color(0XFF171923),
    onPrimaryContainer: Color(0XFF68D391),
  );
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Blue
  Color get blue300 => Color(0XFF63B3ED);
  Color get blue4003f => Color(0X3F5493DD);

  // BlueGray
  Color get blueGray100 => Color(0XFFCBD5E0);
  Color get blueGray200 => Color(0XFFA0AEC0);
  Color get blueGray400 => Color(0XFF718096);
  Color get blueGray50 => Color(0XFFEDF2F7);
  Color get blueGray700 => Color(0XFF4A5568);

  // Cyan
  Color get cyan100 => Color(0XFFBBE8E5);
  Color get cyan300 => Color(0XFF47EADF);

  // Gray
  Color get gray300 => Color(0XFFDFE6E2);
  Color get gray30001 => Color(0XFFE0DFDF);
  Color get gray400 => Color(0XFFC9C9C9);
  Color get gray50 => Color(0XFFFFFBFB);
  Color get gray500 => Color(0XFFACA6A6);
  Color get gray50001 => Color(0XFFACA7A7);
  Color get gray50002 => Color(0XFF929292);
  Color get gray5001 => Color(0XFFF7FAFC);
  Color get gray600 => Color(0XFF858585);
  Color get gray700 => Color(0XFF5B5B5B);
  Color get gray800 => Color(0XFF494949);
  Color get gray90066 => Color(0X661A202C);

  // Green
  Color get green500 => Color(0XFF34C759);
  Color get green50001 => Color(0XFF29C16E);
  Color get green50002 => Color(0XFF38A169);
  Color get greenA400 => Color(0XFF01C971);

  // Indigo
  Color get indigo50 => Color(0XFFE2E8F0);

  // LightBlue
  Color get lightBlue600 => Color(0XFF0994DE);

  // LightGreen
  Color get lightGreenA400 => Color(0XFF6AFF00);

  // Red
  Color get red300 => Color(0XFFF56565);
  Color get red500 => Color(0XFFF73C3C);
  Color get red600 => Color(0XFFE53E3E);
  Color get red800 => Color(0XFFC53030);
  Color get redA200 => Color(0XFFFF4948);

  // Teal
  Color get teal200 => Color(0XFF64C3BF);
  Color get teal400 => Color(0XFF319795);
  Color get teal800 => Color(0XFF005B50);
  Color get tealA200 => Color(0XFF5EF9F6);

  // White
  Color get whiteA700 => Color(0XFFFFFFFF);

  // Yellow
  Color get yellow900 => Color(0XFFEB891B);
  Color get yellowA700 => Color(0XFFFFDA00);
}

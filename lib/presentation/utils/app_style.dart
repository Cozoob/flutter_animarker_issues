import 'package:flutter/material.dart';

/// A utility class for defining app styles, colors, fonts, and commonly used styles.
class AppStyle {
  // Note: App Styling needs to be discussed and changed.
  // Therefore class is incomplete.

  // Colors
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFF607D8B);
  static const Color accentColor = Color(0xFFFFC107);

  // Fonts
  static const String primaryFont = 'Roboto';

  // Text Sizes
  static const double smallTextSize = 12.0;
  static const double mediumTextSize = 16.0;
  static const double largeTextSize = 20.0;
  static const double extraLargeTextSize = 35.0;

  // Text Styles
  static const TextStyle smallTextStyle = TextStyle(
    fontSize: smallTextSize,
    fontFamily: primaryFont,
  );

  static const TextStyle mediumTextStyle = TextStyle(
    fontSize: mediumTextSize,
    fontFamily: primaryFont,
  );

  static const TextStyle largeTextStyle = TextStyle(
    fontSize: largeTextSize,
    fontFamily: primaryFont,
  );

  // Button Styles
  static ButtonStyle primaryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.disabled)) {
        return primaryColor.withOpacity(0.5);
      }
      return primaryColor;
    }),
    textStyle: MaterialStateProperty.all<TextStyle>(mediumTextStyle.copyWith(color: Colors.white)),
  );

  static ButtonStyle secondaryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.disabled)) {
        return secondaryColor.withOpacity(0.5);
      }
      return secondaryColor;
    }),
    textStyle: MaterialStateProperty.all<TextStyle>(mediumTextStyle.copyWith(color: Colors.white)),
  );

  // Input Field Styles
  static const InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
  );
}

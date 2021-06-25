import 'package:flutter/material.dart';

/// Indicates what type of text style color is displayed.
///
enum TextBackground {
  /// Text style for dark background.
  dark,

  /// Text style for white background.
  white,
}

/// A text style for the application.
///
class BuildTextStyle {
  /// Creates a text style.
  ///
  const BuildTextStyle({
    required this.type,
  });

  /// The text style dependent on the background type.
  final TextBackground? type;

  TextStyle get header5 => TextStyle(
        fontFamily: 'LUCA',
        fontSize: 28.0,
        fontWeight: FontWeight.w900,
        color: this.type == TextBackground.dark
            ? Color(0xffffffff)
            : Color(0xff000000),
      );

  TextStyle get header4 => TextStyle(
        fontFamily: 'LUCA',
        fontSize: 24.0,
        fontWeight: FontWeight.w900,
        color: this.type == TextBackground.dark
            ? Color(0xffffffff)
            : Color(0xff000000),
      );

  TextStyle get header3 => TextStyle(
        fontFamily: 'LUCA',
        fontSize: 20.0,
        fontWeight: FontWeight.w900,
        color: this.type == TextBackground.dark
            ? Color(0xffffffff)
            : Color(0xff000000),
      );

  TextStyle get header2 => TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: this.type == TextBackground.dark
            ? Color(0xffffffff)
            : Color(0xff000000),
      );

  TextStyle get header1 => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: this.type == TextBackground.dark
            ? Color(0xffffffff)
            : Color(0xff000000),
      );

  TextStyle get body1 => TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
        color: this.type == TextBackground.dark
            ? Color(0xffffffff)
            : Color(0xff000000),
      );

  TextStyle get body2 => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: this.type == TextBackground.dark
            ? Color(0xffffffff)
            : Color(0xff000000),
      );
}

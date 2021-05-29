import 'package:flutter/material.dart';

enum TextStyleType {
  dark,
  white,
}

class BuildTextStyle {
  BuildTextStyle({
    required this.type,
  });

  final TextStyleType? type;

  TextStyle get header5 => TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: this.type == TextStyleType.dark
            ? Color(0xffffffff)
            : Color(0xff000000),
      );

  TextStyle get header4 => TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: this.type == TextStyleType.dark
            ? Color(0xffffffff)
            : Color(0xff000000),
      );

  TextStyle get header3 => TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: this.type == TextStyleType.dark
            ? Color(0xffffffff)
            : Color(0xff000000),
      );

  TextStyle get subtitle1 => TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
        color: this.type == TextStyleType.dark
            ? Color(0xffffffff)
            : Color(0xff000000),
      );

  TextStyle get subtitle2 => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: this.type == TextStyleType.dark
            ? Color(0xffffffff)
            : Color(0xff000000),
      );
}

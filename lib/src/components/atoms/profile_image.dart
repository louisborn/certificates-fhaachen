import 'package:flutter/material.dart';

import '../../../theme.dart';

class BuildProfileImage extends StatelessWidget {
  BuildProfileImage({
    required this.firstName,
    required this.lastName,
    this.textStyle = const TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: Color(0xff000000),
    ),
    this.dimension = 80.0,
  });

  final String? firstName;

  final String? lastName;

  final TextStyle textStyle;

  final double dimension;

  @override
  Widget build(BuildContext context) {
    final Widget result = Container(
      width: this.dimension,
      height: this.dimension,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(this.dimension / 2),
        color: color_gray50,
      ),
      child: Center(
        child: Text(
          this.firstName![0] + this.lastName![0],
          style: this.textStyle,
        ),
      ),
    );

    return result;
  }
}

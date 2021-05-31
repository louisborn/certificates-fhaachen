import 'package:flutter/material.dart';

import '../../../theme.dart';

/// A static account cirle used in the application.
///
class BuildAccountCircle extends StatelessWidget {
  /// Create a account circle.
  BuildAccountCircle({
    required this.firstName,
    required this.lastName,
    this.textStyle = const TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: Color(0xff000000),
    ),
    this.dimension = 80.0,
  });

  /// The user`s first name used to display the first letter
  /// of the [firstName] in the profile image.
  ///
  final String? firstName;

  /// The user`s last name used to display the first letter
  /// of the [lastName] in the profile image.
  ///
  final String? lastName;

  /// The text style of the displayed letters.
  final TextStyle textStyle;

  /// The dimension of the circle.
  final double dimension;

  @override
  Widget build(BuildContext context) {
    final Widget result = Container(
      width: this.dimension,
      height: this.dimension,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          this.dimension / 2,
        ),
        color: color_gray50,
      ),
      child: Center(
        child: Text(
          this.firstName![0] + this.lastName![0],
          style: this.textStyle,
        ),
      ),
    );

    return Semantics(
      readOnly: true,
      label:
          'The account image displaying the two first letters of the user`s name',
      child: result,
    );
  }
}

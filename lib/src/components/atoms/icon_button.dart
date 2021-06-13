import 'package:flutter/material.dart';

import '../../../components.dart';

/// An icon button used in this application.
///
class BuildIconButton extends StatelessWidget {
  /// Create an icon button.
  ///
  /// The [size] can not be smaller than 24.0 px.
  ///
  BuildIconButton({
    required this.icon,
    required this.onTap,
    this.color = const Color(0xff000000),
    this.size = 24.0,
    required this.hint,
  }) : assert(size >= 24.0);

  /// The displayed icon data.
  final IconData icon;

  /// The executed on tap function.
  final Function()? onTap;

  /// The button`s size.
  ///
  /// Default/ Minimum [size] is 24.0 px.
  ///
  final double size;

  /// The button`s color.
  ///
  /// Default [color] is black.
  ///
  final Color color;

  /// The brief textual description of the result of an action
  /// performed on the button.
  ///
  /// Is used in the [Semantics] widget for accessibility reason.
  ///
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final Widget result = GestureDetector(
      onTap: this.onTap,
      child: BuildIcon(
        icon: this.icon,
        color: this.color,
      ),
    );

    return Semantics(
      button: true,
      hint: this.hint,
      child: result,
    );
  }
}

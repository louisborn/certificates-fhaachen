import 'package:flutter/material.dart';

import '../../../components.dart';

/// An icon button used in this application.
///
/// The [hint] is used in the [Semantics] widget for accessibility reason.
///
class BuildIconButton extends StatelessWidget {
  /// Create an icon button.
  ///
  /// The default [color] is black. The minimum [size] is 24.0 pixels.
  ///
  const BuildIconButton({
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
  final double size;

  /// The button`s color.
  final Color color;

  /// The brief textual description of the result of an action
  /// performed on the button.
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

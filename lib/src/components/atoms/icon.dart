import 'package:flutter/material.dart';

/// A simple icon for this project.
///
class BuildIcon extends StatelessWidget {
  /// Create a icon.
  ///
  /// The minimum [size] is 24.0.
  BuildIcon({
    required this.icon,
    this.color = const Color(0xff000000),
    this.size = 24.0,
    this.label = 'Displays an read only icon',
  }) : assert(size >= 24.0);

  /// The displayed icon data.
  final IconData icon;

  /// The icon`s color.
  final Color color;

  /// The icon`s size.
  final double size;

  /// The brief textual description of the widget.
  ///
  /// Is used in the [Semantics] widget for accessibility reason.
  ///
  final String? label;

  @override
  Widget build(BuildContext context) {
    final Widget result = Icon(
      this.icon,
      color: this.color,
      size: this.size,
    );

    return Semantics(
      readOnly: true,
      label: this.label,
      child: result,
    );
  }
}

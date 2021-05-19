import 'package:flutter/material.dart';

/// A icon for this project.
///
class BuildIcon extends StatelessWidget {
  /// Create a callout based on [BuildIcon].
  ///
  /// The minimum [size] is 24.0.
  BuildIcon({
    required this.icon,
    required this.color,
    this.size = 24.0,
  }) : assert(size >= 24.0);

  /// The icon data for the icon.
  final IconData icon;

  /// The icon color.
  final Color color;

  /// The size of the icon.
  final double size;

  @override
  Widget build(BuildContext context) {
    final Widget result = BuildIcon(
      icon: icon,
      color: color,
    );

    return result;
  }
}

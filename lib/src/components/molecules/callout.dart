import 'package:flutter/material.dart';

import '../../../components.dart';

/// A state callout for this project.
///
class Callout extends StatelessWidget {
  /// Create a callout based on [Semantics], [Container] and [Row].
  ///
  /// The [title], [color] and [type] must not be null.
  ///
  Callout({
    required this.title,
    this.exception,
    required this.color,
    required this.type,
    this.constraints = const BoxConstraints(minWidth: 112.0, minHeight: 48.0),
    this.padding = const EdgeInsets.all(8.0),
  })  : assert(title != null),
        assert(color != null),
        assert(type == "success" || type == "attention" || type == "error");

  /// The general information text for the callout.
  final String? title;

  /// The exception text for the callout.
  final String? exception;

  /// The color for the callout´s background.
  final Color? color;

  /// The callout type.
  ///
  /// The allowed [type]´s are: success, attention and error.
  ///
  final String? type;

  /// Defines the callout´s size.
  ///
  /// Used to constrain the callout´s minimum size.
  final BoxConstraints constraints;

  /// The internal padding of the callout.
  final EdgeInsetsGeometry padding;

  IconData icon() {
    if (this.type == "success") return Icons.check_circle_outline;
    if (this.type == "attention") return Icons.info_outline;
    if (this.type == "error") return Icons.error_outline;
    throw Exception("Failed to assign icon");
  }

  @override
  Widget build(BuildContext context) {
    final Widget result = ConstrainedBox(
      constraints: this.constraints,
      child: Container(
        padding: this.padding,
        color: this.color!.withOpacity(0.1),
        child: Column(
          children: [
            Row(
              children: [
                BuildIcon(icon: icon(), color: this.color!),
                const SizedBox(width: 16.0),
                Text(this.title!),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [Text(this.exception!)],
            ),
          ],
        ),
      ),
    );

    return Semantics(
      container: true,
      child: result,
    );
  }
}

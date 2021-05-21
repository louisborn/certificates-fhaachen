import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../theme.dart';

/// Indicates what type of callout is displayed.
///
enum ModaleType {
  /// Callout for denied user`s.
  denied,

  /// Callout for allowed user`s.
  allowed,
}

/// A callout for the access state of a user.
///
class Modale extends StatelessWidget {
  /// Create a access control callout.
  ///
  const Modale({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.actionText,
    this.textStyle =
        const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    required this.function,
    this.constraints = const BoxConstraints(minWidth: 112.0, minHeight: 48.0),
    this.padding = const EdgeInsets.all(8.0),
  })  : assert(type == ModaleType.denied || type == ModaleType.allowed),
        assert(title != null),
        assert(subtitle != null),
        assert(actionText != null),
        assert(function != null);

  /// The callout type.
  ///
  /// The allowed [type]´s are: denied and allowed.
  ///
  final ModaleType type;

  /// The title text for the callout.
  final String? title;

  /// The subtitle text for the callout.
  final String? subtitle;

  /// The text displayed for the action.
  final String? actionText;

  /// The text theme for the displayed text.
  final TextStyle? textStyle;

  /// The modale`s action.
  final Function()? function;

  /// Defines the callout´s size.
  ///
  /// Used to constrain the callout´s minimum size.
  final BoxConstraints constraints;

  /// The internal padding of the callout.
  final EdgeInsetsGeometry padding;

  IconData icon() {
    if (this.type == ModaleType.denied) return Icons.error;
    if (this.type == ModaleType.allowed) return Icons.check_circle;
    throw Exception("Failed to assign icon");
  }

  Color color() {
    if (this.type == ModaleType.denied) return color_error;
    if (this.type == ModaleType.allowed) return color_success;
    throw Exception("Failed to assign color");
  }

  @override
  Widget build(BuildContext context) {
    final Widget topRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            this.title!,
            style: this.textStyle,
          ),
        ),
        BuildIcon(
          icon: this.icon(),
          color: this.color(),
        ),
      ],
    );

    final Widget result = Padding(
      padding: this.padding,
      child: Container(
        constraints: this.constraints,
        padding: this.padding,
        decoration: BoxDecoration(
          border: Border.all(
            color: this.color(),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topRow,
            const SizedBox(height: 16.0),
            Text(
              this.subtitle!,
              style: this.textStyle,
            ),
            const SizedBox(height: 16.0),
            TertiaryButton(
              text: this.actionText,
              function: this.function,
              withIcon: true,
            ),
          ],
        ),
      ),
    );

    return result;
  }
}

import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../theme.dart';

/// Indicates what type of callout is displayed.
///
//Todo: Change name of enum.
enum Type2 {
  /// Callout for denied user`s.
  denied,

  /// Callout for allowed user`s.
  allowed,
}

/// A callout for the access state of a user.
///
class CalloutAccessControl extends StatelessWidget {
  /// Create a access control callout.
  ///
  const CalloutAccessControl({
    required this.type,
    required this.title,
    required this.subtitle,
    this.textStyle =
        const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    this.constraints = const BoxConstraints(minWidth: 112.0, minHeight: 48.0),
    this.padding = const EdgeInsets.all(8.0),
  })  : assert(type == Type2.denied || type == Type2.allowed),
        assert(title != null),
        assert(subtitle != null);

  /// The callout type.
  ///
  /// The allowed [type]´s are: denied and allowed.
  ///
  final Type2 type;

  /// The title text for the callout.
  final String? title;

  /// The subtitle text for the callout.
  final String? subtitle;

  /// The text theme for the displayed text.
  final TextStyle? textStyle;

  /// Defines the callout´s size.
  ///
  /// Used to constrain the callout´s minimum size.
  final BoxConstraints constraints;

  /// The internal padding of the callout.
  final EdgeInsetsGeometry padding;

  IconData icon() {
    if (this.type == Type2.denied) return Icons.error;
    if (this.type == Type2.allowed) return Icons.check_circle;
    throw Exception("Failed to assign icon");
  }

  Color color() {
    if (this.type == Type2.denied) return color_error;
    if (this.type == Type2.allowed) return color_success;
    throw Exception("Failed to assign color");
  }

  @override
  Widget build(BuildContext context) {
    final Widget header = Row(
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
            header,
            const SizedBox(height: 16.0),
            Text(
              this.subtitle!,
              style: this.textStyle,
            ),
          ],
        ),
      ),
    );

    return result;
  }
}

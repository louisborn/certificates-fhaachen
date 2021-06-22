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
/// The [hint] is used in the [Semantics] widget for accessibility reason.
///
class BuildModale extends StatelessWidget {
  /// Create a access control callout.
  ///
  /// The [type], [title], [subtitle], [actionText], [function] and
  /// [hint] are required. The modale [type] must either be [ModaleType.denied] or
  /// [ModaleType.allowed].
  ///
  /// The [constraints] i sused to constrain the callout´s minimum size.
  ///
  const BuildModale({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.actionText,
    this.icon,
    this.textStyle =
        const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    required this.function,
    this.constraints = const BoxConstraints(minWidth: 112.0, minHeight: 48.0),
    this.padding = const EdgeInsets.all(8.0),
    required this.hint,
  })   : assert(type == ModaleType.denied || type == ModaleType.allowed),
        assert(title != null),
        assert(subtitle != null),
        assert(actionText != null),
        assert(function != null);

  /// The callout type.
  final ModaleType type;

  /// The title text for the callout.
  final String? title;

  /// The subtitle text for the callout.
  final String? subtitle;

  /// The text displayed for the action.
  final String? actionText;

  /// The icon data for the modale.
  final IconData? icon;

  /// The text theme for the displayed text.
  final TextStyle? textStyle;

  /// The modale`s action.
  final Function()? function;

  /// Defines the callout´s size.
  final BoxConstraints constraints;

  /// The internal padding of the callout.
  final EdgeInsetsGeometry padding;

  /// The brief textual description of the result of an action
  /// performed on the button of the callout.
  ///
  final String? hint;

  /// Returns the matching icon for the modale type.
  IconData getIcon() {
    if (this.type == ModaleType.denied) return Icons.error;
    if (this.type == ModaleType.allowed) return Icons.check_circle;
    throw Exception("Failed to assign icon");
  }

  /// returns the matching color for the modale type.
  Color getColor() {
    if (this.type == ModaleType.denied) return color_error;
    if (this.type == ModaleType.allowed) return color_success;
    throw Exception("Failed to assign color");
  }

  @override
  Widget build(BuildContext context) {
    final Widget rowWithTextAndIcon = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            this.title!,
            style: this.textStyle,
          ),
        ),
        const SizedBox(width: 8.0),
        BuildIcon(
          icon: this.getIcon(),
          color: this.getColor(),
        ),
      ],
    );

    final Widget result = Container(
      constraints: this.constraints,
      padding: this.padding,
      decoration: BoxDecoration(
        border: Border.all(
          color: this.getColor(),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rowWithTextAndIcon,
          const SizedBox(
            height: 16.0,
          ),
          Text(
            this.subtitle!,
            style: this.textStyle,
          ),
          const SizedBox(
            height: 16.0,
          ),
          BuildTertiaryButton(
            text: this.actionText,
            function: this.function,
            withIcon: true,
            icon: this.icon!,
            hint: this.hint,
          ),
        ],
      ),
    );

    return Semantics(
      readOnly: true,
      hint: this.hint,
      child: result,
    );
  }
}

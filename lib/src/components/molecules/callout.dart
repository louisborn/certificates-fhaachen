import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../theme.dart';

/// Indicates what type of callout is displayed.
///
enum CalloutType {
  /// Callout with success message.
  success,

  /// Callout with attention message.
  attention,

  /// Callout with error message.
  error,
}

/// A state callout for this project.
///
class Callout extends StatelessWidget {
  /// Create a callout based on [Semantics], [Container] and [Row].
  ///
  /// The [title] and [types] must not be null.
  ///
  const Callout({
    required this.type,
    required this.title,
    this.exception = "",
    this.textStyle =
        const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    this.constraints = const BoxConstraints(minWidth: 112.0, minHeight: 48.0),
    this.padding = const EdgeInsets.all(8.0),
  })  : assert(title != null),
        assert(type == CalloutType.success ||
            type == CalloutType.attention ||
            type == CalloutType.error);

  /// The callout type.
  ///
  /// The allowed [type]´s are: success, attention and error.
  ///
  final CalloutType type;

  /// The general information text for the callout.
  final String? title;

  /// The exception text for the callout.
  final String exception;

  /// The text theme for the displayed text.
  final TextStyle? textStyle;

  /// Defines the callout´s size.
  ///
  /// Used to constrain the callout´s minimum size.
  final BoxConstraints constraints;

  /// The internal padding of the callout.
  final EdgeInsetsGeometry padding;

  IconData selectIcon() {
    if (this.type == CalloutType.success) return Icons.check_circle_outline;
    if (this.type == CalloutType.attention) return Icons.info_outline;
    if (this.type == CalloutType.error) return Icons.error_outline;
    throw Exception("Failed to assign icon");
  }

  Color selectColor() {
    if (this.type == CalloutType.success) return color_success;
    if (this.type == CalloutType.attention) return color_attention;
    if (this.type == CalloutType.error) return color_error;
    throw Exception("Failed to assign color");
  }

  @override
  Widget build(BuildContext context) {
    final Widget main = Row(
      children: [
        BuildIcon(
          icon: selectIcon(),
          color: this.selectColor(),
        ),
        const SizedBox(width: 16.0),
        Flexible(
          child: Text(
            this.title!,
            style: this.textStyle!.copyWith(
                  color: this.selectColor(),
                ),
          ),
        )
      ],
    );

    final Widget excepRow = this.exception == ""
        ? Container()
        : Row(
            children: [
              Flexible(
                child: Text(
                  "Exception: " + this.exception,
                  style: this.textStyle!.copyWith(
                        color: this.selectColor(),
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ],
          );

    final Widget result = Padding(
      padding: this.padding,
      child: Container(
        constraints: this.constraints,
        padding: this.padding,
        color: this.selectColor().withOpacity(0.1),
        child: Column(
          children: [
            main,
            this.exception == ""
                ? const SizedBox(height: 0.0)
                : const SizedBox(height: 16.0),
            excepRow,
          ],
        ),
      ),
    );

    return result;
  }
}

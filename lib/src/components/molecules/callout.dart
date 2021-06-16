import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../theme.dart';

/// Indicates what type of callout is displayed.
///
enum CalloutType {
  /// Callout with information message.
  information,

  /// Callout with success message.
  success,

  /// Callout with attention message.
  attention,

  /// Callout with error message.
  error,
}

/// A state callout used in this application.
///
class BuildCallout extends StatelessWidget {
  /// Create a callout.
  ///
  /// The [title] and [types] must not be null. The [constraints] is
  /// used to constrain the callout´s minimum size.
  ///
  BuildCallout({
    required this.type,
    required this.title,
    this.exception = "",
    this.textStyle =
        const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    this.constraints = const BoxConstraints(minWidth: 112.0, minHeight: 48.0),
    this.padding = const EdgeInsets.all(8.0),
  })  : assert(title != null),
        assert(
          type == CalloutType.success ||
              type == CalloutType.attention ||
              type == CalloutType.error ||
              type == CalloutType.information,
        );

  /// The callout type.
  final CalloutType type;

  /// The general information text for the callout.
  final String? title;

  /// The exception text for the callout.
  final String exception;

  /// The text theme for the displayed text.
  final TextStyle? textStyle;

  /// Defines the callout´s size.
  final BoxConstraints constraints;

  /// The internal padding of the callout.
  final EdgeInsetsGeometry padding;

  /// Returns the matching icon for each callout type.
  IconData getIcon() {
    if (this.type == CalloutType.information) return Icons.info_outline;
    if (this.type == CalloutType.success) return Icons.check_circle_outline;
    if (this.type == CalloutType.attention) return Icons.info_outline;
    if (this.type == CalloutType.error) return Icons.error_outline;
    throw Exception("Failed to assign icon");
  }

  /// Returns the matching color for each callout type.
  Color getColor() {
    if (this.type == CalloutType.information) return color_accent_blue;
    if (this.type == CalloutType.success) return color_success;
    if (this.type == CalloutType.attention) return color_attention;
    if (this.type == CalloutType.error) return color_error;
    throw Exception("Failed to assign color");
  }

  @override
  Widget build(BuildContext context) {
    final Widget textWithExceptionMessage = this.exception == ""
        ? Container()
        : Row(
            children: [
              Flexible(
                child: Text(
                  "Exception: " + this.exception,
                  style: this.textStyle!.copyWith(
                        color: this.getColor(),
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ],
          );

    final Widget main = Row(
      children: [
        BuildIcon(
          icon: getIcon(),
          color: this.getColor(),
        ),
        const SizedBox(width: 16.0),
        Flexible(
          child: Text(
            this.title!,
            style: this.textStyle!.copyWith(
                  color: this.getColor(),
                ),
          ),
        )
      ],
    );

    final Widget result = Container(
      constraints: this.constraints,
      padding: this.padding,
      color: this.getColor().withOpacity(0.1),
      child: Column(
        children: [
          main,
          this.exception == ""
              ? const SizedBox(height: 0.0)
              : const SizedBox(height: 16.0),
          textWithExceptionMessage,
        ],
      ),
    );

    return result;
  }
}

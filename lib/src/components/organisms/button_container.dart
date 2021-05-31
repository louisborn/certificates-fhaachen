import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../components.dart';

/// A container with a leading icon, text and a button
/// used in this application.
///
class BuildButtonContainer extends StatelessWidget {
  /// Create a button container.
  ///
  BuildButtonContainer({
    required this.title,
    required this.subtitle,
    required this.button,
    required this.icon,
    this.width = double.infinity,
    this.padding = 8.0,
    this.titleStyle = const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Color(0xff000000),
    ),
    this.subtitleStyle = const TextStyle(
      fontSize: 16.0,
      color: Color(0xff000000),
    ),
  })  : assert(title != null),
        assert(subtitle != null);

  /// The title of the button container.
  final String? title;

  /// The subtitle of the button container.
  final String? subtitle;

  /// The button of the button container.
  final BuildPrimaryButton button;

  /// The leading icon of the button container.
  final BuildIcon icon;

  /// The width of the container.
  final double width;

  /// The spacing in the container.
  final double padding;

  /// The text theme for the displayed title.
  final TextStyle? titleStyle;

  /// The text theme for the displayed subtitle.
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    final Widget rowWithIconAndText = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        this.icon,
        const SizedBox(width: 16.0),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.title!,
                style: this.titleStyle,
              ),
              const SizedBox(height: 8.0),
              Text(
                this.subtitle!,
                style: this.subtitleStyle,
              ),
            ],
          ),
        ),
      ],
    );

    final Widget result = Container(
      width: this.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff000000),
        ),
      ),
      padding: EdgeInsets.all(this.padding),
      child: Column(
        children: [
          rowWithIconAndText,
          const SizedBox(height: 16.0),
          this.button,
        ],
      ),
    );

    return Semantics(
      label: 'A container with a icon, title, subtitle and button',
      child: result,
    );
  }
}

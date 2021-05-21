import 'package:certificates/components.dart';
import 'package:flutter/material.dart';

import '../../../theme.dart';

/// A tertiary button used in the application.
///
class TertiaryButton extends StatelessWidget {
  /// Create a tertiary button.
  ///
  const TertiaryButton({
    required this.text,
    required this.withIcon,
    this.icon = Icons.check_box_outline_blank,
    this.color = color_accent_blue,
    required this.function,
    this.textStyle = const TextStyle(fontSize: 16.0, color: color_accent_blue),
  })  : assert(text != null),
        assert(function != null);

  /// The button`s displayed text.
  final String? text;

  /// The button`s icon.
  ///
  /// If `true` the button has a leading icon.
  ///
  final bool withIcon;

  /// The leading icon of the button.
  ///
  /// The default value is [Icons.check_box_outline_blank].
  ///
  final IconData icon;

  /// The text color.
  final Color? color;

  /// The button`s action.
  final Function()? function;

  /// The text theme for the displayed text.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final Widget result = GestureDetector(
      onTap: function,
      child: Row(
        children: [
          BuildIcon(icon: this.icon, color: this.color!),
          const SizedBox(width: 8.0),
          Text(
            this.text!,
            style: this.textStyle,
          ),
        ],
      ),
    );

    return result;
  }
}

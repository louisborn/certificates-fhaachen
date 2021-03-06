import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../theme.dart';

/// A tertiary button used in the application.
///
/// A tertiary button should be used in isolation, for less
/// prominent actions, or paired with a Primary or Secondary button.
///
/// The [hint] is used in the [Semantics] widget for accessibility reason.
///
class BuildTertiaryButton extends StatelessWidget {
  /// Create a tertiary button.
  ///
  /// The [text] and [function] must not be null.
  ///
  /// If [withIcon] is `true` then the button has a leading icon with
  /// [Icons.check_box_outline_blank] as default.
  ///
  BuildTertiaryButton({
    required this.text,
    required this.withIcon,
    this.icon = Icons.check_box_outline_blank,
    this.color = color_accent_blue,
    required this.function,
    this.textStyle = const TextStyle(
      fontSize: 16.0,
      color: color_accent_blue,
    ),
    required this.hint,
  })   : assert(text != null),
        assert(function != null);

  /// The button`s displayed text.
  final String? text;

  /// The button`s icon.
  final bool withIcon;

  /// The leading icon of the button.
  final IconData icon;

  /// The text color.
  final Color? color;

  /// The button`s action.
  final Function()? function;

  /// The text theme for the displayed text.
  final TextStyle? textStyle;

  /// The brief textual description of the result of an action
  /// performed on the button.
  ///
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final Widget result = GestureDetector(
      onTap: function,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          this.withIcon
              ? BuildIcon(icon: this.icon, color: this.color!)
              : Container(),
          const SizedBox(width: 8.0),
          Text(
            this.text!,
            style: this.textStyle,
          ),
        ],
      ),
    );

    return Semantics(
      button: true,
      hint: this.hint,
      child: result,
    );
  }
}

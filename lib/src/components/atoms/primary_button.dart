import 'package:flutter/material.dart';

/// A primary button used in the application.
///
class BuildPrimaryButton extends StatelessWidget {
  /// Create a primary button.
  ///
  const BuildPrimaryButton({
    required this.text,
    required this.withIcon,
    this.icon = Icons.check_box_outline_blank,
    this.color = const Color(0xff000000),
    this.width = double.infinity,
    this.height = 48.0,
    required this.function,
    this.textStyle = const TextStyle(fontSize: 16.0, color: Color(0xffffffff)),
  })  : assert(text != null),
        assert(height == 48.0),
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

  /// The width of the button.
  final double width;

  /// The height of the button.
  final double height;

  /// The button`s action.
  final Function()? function;

  /// The text theme for the displayed text.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final Widget result = Container(
      width: this.width,
      height: this.height,
      child: ElevatedButton(
        onPressed: this.function,
        style: ElevatedButton.styleFrom(primary: this.color),
        child: Text(
          this.text!.toUpperCase(),
          style: this.textStyle,
        ),
      ),
    );

    return result;
  }
}

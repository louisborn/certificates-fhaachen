import 'package:flutter/material.dart';

import '../../../components.dart';

/// A app bar used in the application.
///
/// The [BuildAppBar] consists of a [Column] containing an [AppBar]
/// and at the bottom the [BuildBanner] for this application.
///
class BuildAppBar extends StatelessWidget with PreferredSizeWidget {
  /// Create a app bar.
  ///
  /// The default background [color] is black. The [title] is by default
  /// not [centered].
  /// The [title] is required.
  ///
  BuildAppBar({
    required this.title,
    this.centered = false,
    this.leading,
    this.actions,
    this.color = const Color(0xffffffff),
    this.textStyle = const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Color(0xff000000),
    ),
  });

  /// The title of the app bar.
  final String? title;

  /// If `true` the title is centered.
  final bool? centered;

  /// The leading icon of the app bar.
  final Widget? leading;

  /// The optional actions.
  final List<Widget>? actions;

  /// The background color of the app bar.
  final Color? color;

  /// The text style for the title.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final Widget result = PreferredSize(
      preferredSize: preferredSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBar(
            backwardsCompatibility: false,
            iconTheme: IconThemeData(
              color: Color(0xff000000),
            ),
            title: Text(
              this.title!,
              style: this.textStyle,
            ),
            centerTitle: this.centered!,
            actions: this.actions,
            backgroundColor: this.color,
          ),
          BuildBanner()
        ],
      ),
    );

    return Semantics(
      label: 'An app bar',
      child: result,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(64.0);
}

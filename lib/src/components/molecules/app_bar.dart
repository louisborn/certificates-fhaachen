import 'package:flutter/material.dart';

import '../../../components.dart';

class BuildAppBar extends StatelessWidget with PreferredSizeWidget {
  const BuildAppBar({
    this.title = '',
    this.centered = false,
    this.leading,
    this.actions,
    this.color = const Color(0xff000000),
    this.textStyle = const TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
  });

  final String? title;

  final bool? centered;

  final Widget? leading;

  final List<Widget>? actions;

  final Color? color;

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final Widget result = PreferredSize(
      preferredSize: preferredSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBar(
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

    return result;
  }

  @override
  Size get preferredSize => Size.fromHeight(64.0);
}

import 'package:flutter/material.dart';

import '../../../components.dart';

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({
    required this.title,
    required this.centered,
    this.leading,
    this.actions,
    this.color = const Color(0xffffffff),
    this.textStyle = const TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Color(0xff000000)),
  })  : assert(title != null),
        assert(centered == true || centered == false);

  final String? title;

  final bool? centered;

  final Widget? leading;

  final List<Widget>? actions;

  final Color? color;

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final Widget result = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppBar(
          title: Text(
            this.title!,
            style: this.textStyle,
          ),
          centerTitle: this.centered,
          actions: this.actions,
          backgroundColor: this.color,
        ),
        BuildBanner()
      ],
    );

    return result;
  }
}

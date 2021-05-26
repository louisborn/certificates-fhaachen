import 'package:certificates/src/theme/colors.dart';
import 'package:flutter/material.dart';

class BuildIconButton extends StatelessWidget {
  const BuildIconButton({
    required this.icon,
    required this.onTap,
    this.size = 24.0,
  }) : assert(size >= 24.0);

  final IconData? icon;

  final Function? onTap;

  final double size;

  final Color color = color_accent_blue;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

import 'package:flutter/material.dart';

import '../../../components.dart';

class BuildIconButton extends StatelessWidget {
  const BuildIconButton({
    required this.icon,
    required this.onTap,
    this.color = const Color(0xffffffff),
    this.size = 24.0,
  }) : assert(size >= 24.0);

  final IconData icon;

  final Function()? onTap;

  final double size;

  final Color color;

  @override
  Widget build(BuildContext context) {
    final Widget result = GestureDetector(
      onTap: this.onTap,
      child: BuildIcon(icon: this.icon, color: this.color),
    );

    return result;
  }
}

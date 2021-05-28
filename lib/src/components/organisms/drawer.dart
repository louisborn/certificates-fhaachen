import 'package:flutter/material.dart';

class BuildDrawer extends StatelessWidget {
  BuildDrawer({
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final Widget result = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: this.children,
      ),
    );

    return result;
  }
}

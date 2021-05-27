import 'package:flutter/material.dart';

class BuildDrawer extends StatelessWidget {
  BuildDrawer({
    this.name,
    this.lastName,
    required this.children,
  })   : assert(name != null),
        assert(lastName != null);

  final String? name;

  final String? lastName;

  final List children;

  @override
  Widget build(BuildContext context) {
    final Widget drawerHeader = DrawerHeader(
      child: Column(
        children: [
          Text(this.name!),
          Text(this.lastName!),
        ],
      ),
    );

    final Widget result = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          drawerHeader,
        ],
      ),
    );

    return result;
  }
}

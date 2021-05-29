import 'package:flutter/material.dart';

import '../../screens.dart';
import '../../components.dart';

class MoreScreen extends StatelessWidget {
  static const String route = '/more';

  @override
  Widget build(BuildContext context) {
    final Widget listTileAccount = GestureDetector(
      onTap: () => Navigator.pushNamed(context, AccountScreen.route),
      child: ListTile(
        leading: BuildIcon(
          icon: Icons.account_circle_outlined,
        ),
        title: Text(
          'Account',
        ),
        trailing: BuildIcon(
          icon: Icons.arrow_forward_ios_outlined,
        ),
      ),
    );

    final Widget listTileLogout = GestureDetector(
      onTap: () => Navigator.pushNamed(context, LogoutScreen.route),
      child: ListTile(
        leading: BuildIcon(
          icon: Icons.logout,
        ),
        title: Text(
          'Logout',
        ),
        trailing: BuildIcon(
          icon: Icons.arrow_forward_ios_outlined,
        ),
      ),
    );

    return Column(
      children: [
        listTileAccount,
        listTileLogout,
      ],
    );
  }
}

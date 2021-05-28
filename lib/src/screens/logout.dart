import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../components.dart';
import '../../screens.dart';
import '../../services.dart';

class LogoutScreen extends StatelessWidget {
  static const String route = '/logout';

  @override
  Widget build(BuildContext context) {
    AuthenticationService _provider =
        Provider.of<AuthenticationService>(context);

    final PreferredSizeWidget appbar = BuildAppBar(
      title: 'Logout',
      centered: false,
    );

    final Widget callout = BuildCallout(
      type: CalloutType.attention,
      title: 'Are you sure you want to logout?',
    );

    var doLogout = () async {
      if (await _provider.logout()) {
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.route, (route) => false);
      }
    };

    return Scaffold(
      appBar: appbar,
      body: Padding(
        padding: EdgeInsets.only(left: 8.0, top: 24.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            callout,
          ],
        ),
      ),
      bottomSheet: BuildPrimaryButton(
        text: 'Logout',
        withIcon: false,
        function: doLogout,
      ),
    );
  }
}

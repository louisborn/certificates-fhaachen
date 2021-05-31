import 'package:flutter/material.dart';

import '../../components.dart';

class AboutScreen extends StatelessWidget {
  static const String route = '/about';

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = BuildAppBar(
      title: 'About',
    );

    return Scaffold(
      appBar: appBar,
      body: BuildCallout(
        type: CalloutType.attention,
        title: 'Page in construction',
      ),
    );
  }
}

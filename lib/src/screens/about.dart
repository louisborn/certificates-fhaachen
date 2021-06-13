import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../components.dart';
import '../../generated/i18n.dart';
import '../../theme.dart';

/// A screen to provide a information about this application.
///
class AboutScreen extends StatelessWidget {
  /// The route name for this screen.
  static const String route = '/home/about';

  @override
  Widget build(BuildContext context) {
    /// The app bar for this screen.
    final PreferredSizeWidget appBar = BuildAppBar(
      title: I18n.of(context).aboutTitle,
    );

    /// The brand logo for this screen.
    final Widget logo = SvgPicture.asset(
      'assets/images/logo.svg',
    );

    final Widget textForAppInformation = Text(
      I18n.of(context).aboutInformation,
      style: BuildTextStyle(type: TextBackground.white).body2,
      textAlign: TextAlign.left,
    );

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.only(
          left: 24.0,
          top: 24.0,
          right: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            logo,
            const SizedBox(
              height: 32.0,
            ),
            textForAppInformation,
          ],
        ),
      ),
    );
  }
}

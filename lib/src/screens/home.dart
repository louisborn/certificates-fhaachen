import 'package:flutter/material.dart';

import '../../components.dart';
import '../../generated/i18n.dart';
import '../../services.dart';
import '../../screens.dart';
import '../../theme.dart';

/// A screen to provide the main actions of the application.
///
class HomeScreen extends StatelessWidget {
  /// The route name for this screen.
  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    final Widget greet = Column(
      children: [
        Text(
          I18n.of(context).homeGreetTo(
            PreferenceService().getString('firstName')!.toLowerCase(),
          ),
          style: BuildTextStyle(type: TextStyleType.white).header4,
          textAlign: TextAlign.center,
        ),
        Text(
          I18n.of(context).homeInformation,
          style: BuildTextStyle(type: TextStyleType.white).subtitle2,
          textAlign: TextAlign.center,
        ),
      ],
    );

    final Widget buttonForQrCode = BuildButtonContainer(
      title: I18n.of(context).homeOption_1_title,
      subtitle: I18n.of(context).homeOption_1_subtitle,
      button: BuildPrimaryButton(
        text: I18n.of(context).homeOption_1_button,
        withIcon: false,
        function: () => Navigator.pushNamed(
          context,
          QRCodeScreen.route,
        ),
        hint: I18n.of(context).homeOption_1_hint,
      ),
      icon: BuildIcon(
        icon: Icons.qr_code,
        size: 80.0,
      ),
    );

    final Widget buttonForCertificates = BuildButtonContainer(
      title: I18n.of(context).homeOption_2_title,
      subtitle: I18n.of(context).homeOption_2_subtitle,
      button: BuildPrimaryButton(
        text: I18n.of(context).homeOption_2_button,
        withIcon: false,
        function: () => Navigator.pushNamed(
          context,
          CertificatesScreen.route,
        ),
        hint: I18n.of(context).homeOption_2_hint,
      ),
      icon: BuildIcon(
        icon: Icons.file_copy_outlined,
        size: 80.0,
      ),
    );

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          greet,
          const SizedBox(
            height: 16.0,
          ),
          buttonForQrCode,
          const SizedBox(
            height: 16.0,
          ),
          buttonForCertificates,
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../components.dart';
import '../../generated/i18n.dart';
import '../../services.dart';
import '../../screens.dart';
import '../../theme.dart';

/// A screen to provide the main actions of the application.
///
/// The [greet] widget returns a greet information text with the
/// user`s name. The [buttonForQrCode] gives the user an option to
/// scan a qr code to either enter a workspace or use a machine.
/// The [buttonForCertificates]
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
          style: BuildTextStyle(type: TextBackground.white).header5,
          textAlign: TextAlign.center,
        ),
        Text(
          I18n.of(context).homeInformation,
          style: BuildTextStyle(type: TextBackground.white).body2,
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
          QRCodeScannerScreen.route,
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
          greet,
          const SizedBox(
            height: 24.0,
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

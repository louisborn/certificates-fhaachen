import 'package:certificates/src/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../components.dart';
import '../../generated/i18n.dart';
import '../../models.dart';
import '../../screens.dart';
import '../../services.dart';

/// A screen to provide access information for a workspace and
/// actions to use a machine.
///
class AccessWorkpsaceScreen extends StatefulWidget {
  /// The route name for this screen.
  static const String route = '/home/access_workspace';

  const AccessWorkpsaceScreen({Key? key}) : super(key: key);

  @override
  _AccessWorkpsaceScreenState createState() => _AccessWorkpsaceScreenState();
}

class _AccessWorkpsaceScreenState extends State<AccessWorkpsaceScreen> {
  @override
  Widget build(BuildContext context) {
    /// The arguments for this screen.
    final args = ModalRoute.of(context)!.settings.arguments as Workspace;

    /// The consumer of a provider service.
    final AccessControlService _provider =
        Provider.of<AccessControlService>(context);

    /// Logs a user exit of a workspace and navigates to the home screen.
    ///
    var doLeaveWorkspace = () async {
      await _provider.leaveWorkspace(args.path);
      if (_provider.userAccessStatus == UserAccessStatus.NotEntered) {
        Navigator.pushNamedAndRemoveUntil(
            context, BuildBottomNavigationBar.route, (route) => false);
      }
    };

    /// Navigates a user to the home screen.
    ///
    var doTryAgain = () => Navigator.pushNamedAndRemoveUntil(
        context, BuildBottomNavigationBar.route, (route) => false);

    /// The app bar for this screen.
    final PreferredSizeWidget appBar = BuildAppBar(
      title: args.name,
    );

    /// The information modale for when a user has entered a
    /// workspace.
    ///
    final Widget modaleForEnteredStatus = BuildModale(
      type: ModaleType.allowed,
      title: I18n.of(context).workspaceEnteredTitle(args.name!),
      subtitle: I18n.of(context).workspaceEnteredSubtitle(
        PreferenceService().getString('timestamp')!,
      ),
      actionText: I18n.of(context).workspaceEnteredAction,
      icon: Icons.close,
      function: () => doLeaveWorkspace(),
      hint: 'Modale information for entered user in workspace',
    );

    /// The information modale for when a workspace is full and
    /// the user`s access is denied.
    ///
    final Widget modaleForDeniedStatus = BuildModale(
      type: ModaleType.denied,
      title: I18n.of(context).workspaceDeniedTitle(args.name!),
      subtitle: I18n.of(context).workspaceDeniedSubtitle(
        args.currentInWorkspace.toString(),
      ),
      actionText: I18n.of(context).workspaceDeniedAction,
      icon: Icons.close,
      function: () => doTryAgain(),
      hint: 'Modale information for denied user in workspace',
    );

    /// The button to scan a machine`s qr code inorder to use it.
    final Widget buttonForQrCode = BuildButtonContainer(
      title: I18n.of(context).machineUseMachine,
      subtitle: I18n.of(context).machineUseDesc,
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

    /// The loading widget for this screen.
    final Widget loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color_accent_green),
        ),
        const SizedBox(width: 8.0),
        Text(I18n.of(context).loading),
      ],
    );

    final Widget main = Column(
      children: [
        modaleForEnteredStatus,
        const SizedBox(
          height: 16.0,
        ),
        buttonForQrCode,
        const SizedBox(
          height: 16.0,
        ),
        buttonForCertificates
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          top: 24.0,
          right: 8.0,
        ),
        child: Consumer<AccessControlService>(
          builder: (BuildContext context, provider, child) {
            if (_provider.userAccessStatus == UserAccessStatus.Entered)
              return main;

            if (_provider.userAccessStatus == UserAccessStatus.Denied)
              return modaleForDeniedStatus;

            return Center(
              child: loading,
            );
          },
        ),
      ),
    );
  }
}

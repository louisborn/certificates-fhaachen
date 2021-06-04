import 'package:certificates/components.dart';
import 'package:certificates/generated/i18n.dart';
import 'package:certificates/models.dart';
import 'package:certificates/screens.dart';
import 'package:certificates/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkspaceScreen extends StatefulWidget {
  static const String route = '/workspace';

  const WorkspaceScreen({Key? key}) : super(key: key);

  @override
  _WorkspaceScreenState createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Workspace;
    AccessControlService _provider = Provider.of<AccessControlService>(context);

    final PreferredSizeWidget appBar = BuildAppBar(
      title: 'Workspace',
    );

    final Widget enteredStatus = BuildModale(
      type: ModaleType.allowed,
      title: 'Workspace entered - Workspace: ' + args.name!,
      subtitle: 'Entered at: ' + PreferenceService().getString('timestamp')!,
      actionText: 'Leave current workspace',
      function: () async {
        await _provider.leaveWorkspace(args.path);
        if (_provider.userAccessStatus == UserAccessStatus.NotEntered) {
          Navigator.pushNamedAndRemoveUntil(
              context, BuildBottomNavigationBar.route, (route) => false);
        }
      },
      hint: 'Modale information for entered user in workspace',
    );

    final Widget deniedStatus = BuildModale(
      type: ModaleType.denied,
      title: 'Workspace closed - Workspace: ' + args.name!,
      subtitle: 'Current in workspace: ' + args.currentInWorkspace.toString(),
      actionText: 'Try again later',
      function: () => Navigator.pushNamedAndRemoveUntil(
          context, BuildBottomNavigationBar.route, (route) => false),
      hint: 'Modale information for denied user in workspace',
    );

    final Widget buttonQrCode = BuildButtonContainer(
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

    final Widget main = Column(
      children: [
        enteredStatus,
        const SizedBox(height: 16.0),
        buttonQrCode,
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.only(left: 8.0, top: 24.0, right: 8.0),
        child: Column(
          children: [
            _provider.userAccessStatus == UserAccessStatus.Entered
                ? main
                : deniedStatus,
          ],
        ),
      ),
    );
  }
}

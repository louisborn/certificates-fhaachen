import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../components.dart';
import '../../generated/i18n.dart';
import '../../models.dart';
import '../../services.dart';
import '../../theme.dart';

/// A screen to provide access to machine`s in a workspace.
///
class UseMachineScreen extends StatefulWidget {
  /// The route name for this screen.
  static const String route = '/home/access_machine';

  const UseMachineScreen({Key? key}) : super(key: key);

  @override
  _UseMachineScreenState createState() => _UseMachineScreenState();
}

class _UseMachineScreenState extends State<UseMachineScreen> {
  @override
  Widget build(BuildContext context) {
    /// The arguments for this screen.
    final args = ModalRoute.of(context)!.settings.arguments as Certificate;

    /// The consumer of a provider service.
    final UsageControlService _provider =
        Provider.of<UsageControlService>(context);

    /// The app bar for this screen.
    final PreferredSizeWidget appBar = BuildAppBar(
      title: I18n.of(context).machineTitle,
    );

    /// The information modale for when a user is using
    /// a machine.
    ///
    final Widget usingStatus = BuildModale(
      type: ModaleType.allowed,
      title: I18n.of(context).machineDeniedTitle(
        args.machine!,
      ),
      subtitle: I18n.of(context).machineUsingSubtitle(
        args.description!,
      ),
      actionText: I18n.of(context).machineUsingAction,
      icon: Icons.close,
      function: () => Navigator.pop(context),
      hint: 'Modale information for entered user in workspace',
    );

    /// The information modale for when a user is denied to
    /// use a machine.
    ///
    final Widget deniedStatus = BuildModale(
      type: ModaleType.denied,
      title: I18n.of(context).machineDeniedTitle(
        args.machine!,
      ),
      subtitle: I18n.of(context).machineDeniedSubtitle(
        args.name!,
      ),
      actionText: I18n.of(context).machineDeniedAction,
      icon: Icons.close,
      function: () => Navigator.pop(context),
      hint: 'Modale information for entered user in workspace',
    );

    /// The main information that is displayed only when a user
    /// is allowed to use a machine.
    ///
    final Widget main = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        usingStatus,
        const SizedBox(
          height: 32.0,
        ),
        Text(
          I18n.of(context).machineSafetyInstruction,
          style: BuildTextStyle(type: TextBackground.white).header3,
        ),
        const SizedBox(
          height: 16.0,
        ),
        BuildCallout(
          type: CalloutType.attention,
          title: I18n.of(context).machineSafetyInfo,
        ),
        const SizedBox(
          height: 16.0,
        ),
        Image.network(args.safetyInstruction!),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.only(
          left: 8.0,
          top: 24.0,
          right: 8.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _provider.userUsageStatus == UserUsageStatus.Using
                  ? main
                  : deniedStatus
            ],
          ),
        ),
      ),
    );
  }
}

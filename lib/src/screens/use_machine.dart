import 'package:certificates/components.dart';
import 'package:certificates/models.dart';
import 'package:certificates/screens.dart';
import 'package:certificates/services.dart';
import 'package:certificates/src/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UseMachineScreen extends StatefulWidget {
  static const String route = '/usemachine';
  const UseMachineScreen({Key? key}) : super(key: key);

  @override
  _UseMachineScreenState createState() => _UseMachineScreenState();
}

class _UseMachineScreenState extends State<UseMachineScreen> {
  @override
  Widget build(BuildContext context) {
    UsageControlService _provider = Provider.of<UsageControlService>(context);
    final args = ModalRoute.of(context)!.settings.arguments as Certificate;

    final PreferredSizeWidget appBar = BuildAppBar(
      title: 'Machine',
    );

    final Widget usingStatus = BuildModale(
      type: ModaleType.allowed,
      title: 'Machine in use: ' + args.machine!,
      subtitle: 'Description: ' + args.description!,
      actionText: 'Exit current machine',
      icon: Icons.close,
      function: () => Navigator.pop(context),
      hint: 'Modale information for entered user in workspace',
    );

    final Widget deniedStatus = BuildModale(
      type: ModaleType.denied,
      title: 'Workspace not available - Machine: ' + args.machine!,
      subtitle: 'Needed certificate: ' + args.name!,
      actionText: 'Use other machine',
      icon: Icons.close,
      function: () => Navigator.pop(context),
      hint: 'Modale information for entered user in workspace',
    );

    final Widget main = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        usingStatus,
        const SizedBox(
          height: 32.0,
        ),
        Text(
          'Safety instruction',
          style: BuildTextStyle(type: TextBackground.white).header3,
        ),
        const SizedBox(
          height: 16.0,
        ),
        BuildCallout(
          type: CalloutType.attention,
          title: 'Make sure to follow the safety instructions below.',
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

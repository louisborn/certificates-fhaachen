import 'package:certificates/components.dart';
import 'package:certificates/generated/i18n.dart';
import 'package:certificates/models.dart';
import 'package:certificates/services.dart';
import 'package:flutter/material.dart';

class Path {
  Path({this.path});

  final String? path;
}

class WorkspaceScreen extends StatefulWidget {
  static const String route = '/workspace';

  const WorkspaceScreen({Key? key}) : super(key: key);

  @override
  _WorkspaceScreenState createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Path;

    return Scaffold(
      body: FutureBuilder(
        future: Document<Workspace>(path: args.path).getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Workspace workspace = snapshot.data;
          if (snapshot.hasError)
            return BuildCallout(
              type: CalloutType.error,
              title: I18n.of(context).error_default,
            );

          if (snapshot.connectionState == ConnectionState.done) {
            if (workspace.currentInWorkspace == workspace.maxInWorkspace)
              return Center(child: Text('FULL'));
            return Center(
              child: Text('ENTERED'),
            );
          }
          return Text('Loading');
        },
      ),
    );
  }
}

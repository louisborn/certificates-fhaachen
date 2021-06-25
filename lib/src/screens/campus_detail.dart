import 'package:flutter/material.dart';

import '../../components.dart';
import '../../generated/i18n.dart';
import '../../models.dart';
import '../../services.dart';
import '../../theme.dart';

class CampusDetailScreen extends StatefulWidget {
  /// The route name of this screen.
  static const String route = "/campus/detail";

  @override
  _CampusDetailScreenState createState() => _CampusDetailScreenState();
}

class _CampusDetailScreenState extends State<CampusDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Campus;

    /// The app bar for this screen.
    final PreferredSizeWidget appBar = BuildAppBar(
      title: '${args.name}',
    );

    /// The general campus information.
    final Widget buildCampusInformation = Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            args.name!,
            style: BuildTextStyle(type: TextBackground.white).header4,
          ),
          const SizedBox(height: 24.0),
          Text(
            args.phone!,
            style: BuildTextStyle(type: TextBackground.white).body2,
          ),
          const SizedBox(height: 8.0),
          Text(
            args.email!,
            style: BuildTextStyle(type: TextBackground.white).body2,
          ),
          const SizedBox(height: 8.0),
          Text(
            args.street! + ' ' + args.postal! + ' ' + args.city!,
            style: BuildTextStyle(type: TextBackground.white).body2,
          ),
        ],
      ),
    );

    /// The loading animation for this screen.
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color_accent_green),
        ),
        const SizedBox(width: 8.0),
        Text(I18n.of(context).loading),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
        future: Collection<Workspace>(path: 'campus/${args.id}/workspaces')
            .getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError)
            return BuildCallout(
              type: CalloutType.error,
              title: I18n.of(context).error_default,
            );

          if (snapshot.hasData && snapshot.data == false)
            return BuildCallout(
              type: CalloutType.attention,
              title: I18n.of(context).error_noData,
            );

          if (snapshot.connectionState == ConnectionState.done) {
            List<Workspace> workspace = snapshot.data;
            return Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                top: 24.0,
                right: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildCampusInformation,
                  const SizedBox(height: 32.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: workspace.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildCapacityStatus(
                          context,
                          index,
                          workspace,
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }

          return Center(
            child: loading,
          );
        },
      ),
    );
  }

  Widget _buildCapacityStatus(
      BuildContext context, int index, List<Workspace> workspaces) {
    final Widget buildStatusHigh = Container(
      padding: EdgeInsets.all(8.0),
      color: color_error,
      child: Text(
        I18n.of(context).statusLvlFull,
        style: BuildTextStyle(type: TextBackground.dark).body2,
      ),
    );

    final Widget buildStatusMid = Container(
      padding: EdgeInsets.all(8.0),
      color: color_warning,
      child: Text(
        I18n.of(context).statusLvlMid,
        style: BuildTextStyle(type: TextBackground.dark).body2,
      ),
    );

    final Widget buildStatusLow = Container(
      padding: EdgeInsets.all(8.0),
      color: color_success,
      child: Text(
        I18n.of(context).statusLvlLow,
        style: BuildTextStyle(type: TextBackground.dark).body2,
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      child: Column(
        children: [
          Divider(),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            workspaces[index].name!,
            style: BuildTextStyle(type: TextBackground.white).header2,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            I18n.of(context).statusUserIn(
              workspaces[index].currentInWorkspace.toString(),
            ),
            style: BuildTextStyle(type: TextBackground.white).body2,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            I18n.of(context).statusCapacity,
            style: BuildTextStyle(type: TextBackground.white).body2,
          ),
          const SizedBox(
            height: 16.0,
          ),
          if (workspaces[index].currentInWorkspace! >=
              workspaces[index].maxInWorkspace!)
            buildStatusHigh,
          if (workspaces[index].currentInWorkspace! >
              workspaces[index].maxInWorkspace! / 2)
            buildStatusMid,
          if (workspaces[index].currentInWorkspace! <
              workspaces[index].maxInWorkspace! / 2)
            buildStatusLow,
        ],
      ),
    );
  }
}

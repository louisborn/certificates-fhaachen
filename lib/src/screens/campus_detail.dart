import 'package:certificates/screens.dart';
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

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
        future: Collection<Workspace>(path: 'campus/${args.id}/workspaces')
            .getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) return ErrorDefault();

          if (snapshot.hasData && snapshot.data == false) return ErrorNoData();

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

          return Loading();
        },
      ),
    );
  }

  /// The capacity status for each campus, including campus information
  /// like email address, phone number and address.
  ///
  Widget _buildCapacityStatus(
      BuildContext context, int index, List<Workspace> workspaces) {
    /// The widget if the capacity level is high.
    final Widget buildStatusHigh = Container(
      padding: EdgeInsets.all(8.0),
      color: color_error,
      child: Text(
        I18n.of(context).statusLvlFull,
        style: BuildTextStyle(type: TextBackground.dark).body2,
      ),
    );

    /// The widget if the capacity level is medium.
    final Widget buildStatusMid = Container(
      padding: EdgeInsets.all(8.0),
      color: color_warning,
      child: Text(
        I18n.of(context).statusLvlMid,
        style: BuildTextStyle(type: TextBackground.dark).body2,
      ),
    );

    /// The widget if the capacity level is low.
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
            style: BuildTextStyle(type: TextBackground.white).header1,
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
                  workspaces[index].maxInWorkspace! / 2 &&
              workspaces[index].currentInWorkspace! <
                  workspaces[index].maxInWorkspace!)
            buildStatusMid,
          if (workspaces[index].currentInWorkspace! <
              workspaces[index].maxInWorkspace! / 2)
            buildStatusLow,
        ],
      ),
    );
  }
}

import 'package:certificates/components.dart';
import 'package:certificates/generated/i18n.dart';
import 'package:certificates/models.dart';
import 'package:certificates/services.dart';
import 'package:certificates/src/theme/colors.dart';
import 'package:certificates/src/theme/text_style.dart';
import 'package:flutter/material.dart';

class CampusDetailScreen extends StatefulWidget {
  static const String route = "/campus/detail";

  @override
  _CampusDetailScreenState createState() => _CampusDetailScreenState();
}

class _CampusDetailScreenState extends State<CampusDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Campus;

    final PreferredSizeWidget appBar = BuildAppBar(
      title: '${args.name}',
    );

    final Widget container = Container(
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

    final Widget title = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Current capacity status:',
        style: BuildTextStyle(type: TextBackground.white).header4,
      ),
    );

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
                  container,
                  const SizedBox(height: 32.0),
                  title,
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: workspace.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: workspace[index]
                                                  .currentInWorkspace! >
                                              workspace[index].maxInWorkspace! /
                                                  2 &&
                                          workspace[index].currentInWorkspace! <
                                              workspace[index].maxInWorkspace!
                                      ? BuildIcon(
                                          icon: Icons.wifi_tethering_outlined,
                                          color: color_attention,
                                        )
                                      : BuildIcon(
                                          icon: workspace[index]
                                                      .currentInWorkspace ==
                                                  workspace[index]
                                                      .maxInWorkspace
                                              ? Icons.close
                                              : Icons.wifi_tethering_outlined,
                                          color: workspace[index]
                                                      .currentInWorkspace ==
                                                  workspace[index]
                                                      .maxInWorkspace
                                              ? color_error
                                              : color_success,
                                        ),
                                  title: Text(
                                    workspace[index].name!,
                                    style: BuildTextStyle(
                                            type: TextBackground.white)
                                        .body1,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        'Current students in workspace: ' +
                                            workspace[index]
                                                .currentInWorkspace!
                                                .toString(),
                                      ),
                                      Text(
                                        'Maximal allowed: ' +
                                            workspace[index]
                                                .maxInWorkspace!
                                                .toString(),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
}

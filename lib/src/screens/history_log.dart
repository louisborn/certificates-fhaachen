import 'package:certificates/components.dart';
import 'package:certificates/services.dart';
import 'package:certificates/src/theme/colors.dart';
import 'package:certificates/src/theme/text_style.dart';
import 'package:flutter/material.dart';

import '../../models.dart';

class HistoryLogScreen extends StatefulWidget {
  static const String route = '/log';

  @override
  _HistoryLogScreenState createState() => _HistoryLogScreenState();
}

class _HistoryLogScreenState extends State<HistoryLogScreen> {
  late Future future;

  bool sortedByWorkspace = false;
  bool sortedByEnter = false;
  bool sortedByLeave = false;

  @override
  void initState() {
    this.future = Collection<Log>(path: 'log').getDataQueriedById();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = BuildAppBar(
      title: 'History log',
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color_accent_green),
        ),
        const SizedBox(width: 8.0),
        Text('Loading'),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
        future: this.future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError)
            return BuildCallout(
              type: CalloutType.error,
              title: 'Something went wrong. Try again.',
            );

          if (snapshot.hasData && snapshot.data == false)
            return BuildCallout(
              type: CalloutType.attention,
              title: 'No history log to display.',
            );

          if (snapshot.connectionState == ConnectionState.done) {
            List<Log> data = snapshot.data;
            return Padding(
              padding: EdgeInsets.only(left: 8.0, top: 24.0, right: 8.0),
              child: BuildTable(
                data: data,
                tableHeader: ['Workspace', 'Enter', 'Leave'],
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

import 'package:flutter/material.dart';

import '../../components.dart';
import '../../generated/i18n.dart';
import '../../services.dart';
import '../../theme.dart';
import '../../models.dart';

class HistoryLogScreen extends StatefulWidget {
  static const String route = '/home/log';

  @override
  _HistoryLogScreenState createState() => _HistoryLogScreenState();
}

class _HistoryLogScreenState extends State<HistoryLogScreen> {
  late Future future;

  @override
  void initState() {
    this.future = Collection<Log>(path: 'log').getDataQueriedById('studentId');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = BuildAppBar(
      title: I18n.of(context).logTitle,
    );

    final Widget snapshotHasError = BuildCallout(
      type: CalloutType.error,
      title: I18n.of(context).error_default,
    );

    final Widget snapshotDataIsFalse = BuildCallout(
      type: CalloutType.attention,
      title: I18n.of(context).error_noData,
    );

    final Widget snapshotIsEmpty = Center(
      child: Padding(
        padding: EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        child: Text(
          'No history log to display. Enter a workspace first.',
          style: BuildTextStyle(type: TextBackground.white).body2,
          textAlign: TextAlign.center,
        ),
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
        future: this.future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) return snapshotHasError;

          if (snapshot.hasData && snapshot.data == false)
            return snapshotDataIsFalse;

          if (snapshot.connectionState == ConnectionState.done) {
            List<Log> data = snapshot.data;
            return data.isEmpty
                ? snapshotIsEmpty
                : Padding(
                    padding: EdgeInsets.only(
                      left: 24.0,
                      top: 24.0,
                      right: 24.0,
                    ),
                    child: BuildTable(
                      data: data,
                      tableHeader: [
                        I18n.of(context).logTable_header_1,
                        I18n.of(context).logTable_header_2,
                        I18n.of(context).logTable_header_3,
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

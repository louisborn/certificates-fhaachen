import 'package:flutter/material.dart';

import '../../components.dart';
import '../../generated/i18n.dart';
import '../../services.dart';
import '../../theme.dart';
import '../../models.dart';

class HistoryLogScreen extends StatefulWidget {
  static const String route = '/log';

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
            List<Log> data = snapshot.data;
            return Padding(
              padding: EdgeInsets.only(left: 8.0, top: 24.0, right: 8.0),
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

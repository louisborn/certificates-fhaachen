import 'package:flutter/material.dart';

import '../../generated/i18n.dart';
import "../../components.dart";
import '../../models.dart';
import '../../services.dart';
import '../../theme.dart';

class CertificatesScreen extends StatefulWidget {
  /// The route name for this screen.
  static const String route = '/home/certificates';

  @override
  _CertificatesScreenState createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  /// A future for a potential value from the database.
  late Future future;

  /// The list of certificates that is fetched from the
  /// database.
  ///
  late List<Certificate> data;

  @override
  void initState() {
    this.future = Collection<Certificate>(path: 'certificates').getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = BuildAppBar(
      title: I18n.of(context).certificatesTitle,
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
            return Padding(
              padding: EdgeInsets.only(
                left: 8.0,
                top: 24.0,
                right: 8.0,
              ),
              child: BuildCallout(
                type: CalloutType.error,
                title: I18n.of(context).error_default,
              ),
            );

          if (snapshot.hasData && snapshot.data == false)
            return Padding(
              padding: EdgeInsets.only(
                left: 8.0,
                top: 24.0,
                right: 8.0,
              ),
              child: BuildCallout(
                type: CalloutType.attention,
                title: I18n.of(context).error_noData,
              ),
            );

          if (snapshot.connectionState == ConnectionState.done) {
            this.data = snapshot.data;
            return Padding(
              padding: EdgeInsets.only(
                left: 8.0,
                top: 24.0,
                right: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: BuildCertificateContainer(
                            name: data[index].name,
                            usage: data[index].machine,
                            assignedTo: data[index].assignedTo,
                            descripition: data[index].description,
                            safetyInstruction: data[index].safetyInstruction,
                          ),
                        );
                      },
                    ),
                  ),
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

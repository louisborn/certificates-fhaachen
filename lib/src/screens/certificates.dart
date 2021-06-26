import 'package:flutter/material.dart';

import "../../components.dart";
import '../../generated/i18n.dart';
import '../../screens.dart';
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
    /// The app bar for this screen.
    final PreferredSizeWidget appBar = BuildAppBar(
      title: I18n.of(context).certificatesTitle,
    );

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
        future: this.future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) return ErrorDefault();

          if (snapshot.hasData && snapshot.data == false) return ErrorNoData();

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
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            right: 8.0,
                            bottom: 8.0,
                          ),
                          child: _buildCertificateContainer(
                            context,
                            index,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Loading();
        },
      ),
    );
  }

  /// The certificate container widget.
  ///
  /// The [index] is the current index of the list item [data].
  ///
  Widget _buildCertificateContainer(BuildContext context, int index) {
    /// The tertiary button to show the safety instruction.
    final Widget link = GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        ShowSafetyInstructionScreen.route,
        arguments: ImageModel(imageRef: data[index].safetyInstruction),
      ),
      child: Text(
        I18n.of(context).certificatesShow_certificate,
        style: BuildTextStyle(type: TextBackground.white)
            .body2
            .copyWith(color: color_accent_blue),
      ),
    );

    final Widget iconAndLink = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BuildIcon(
          icon: data[index].assignedTo!.contains(
                    PreferenceService().getString('studentId'),
                  )
              ? Icons.check_box_outlined
              : Icons.indeterminate_check_box_outlined,
          color: data[index].assignedTo!.contains(
                    PreferenceService().getString('studentId'),
                  )
              ? color_success
              : color_error,
        ),
        link,
      ],
    );

    final Widget certificateInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          I18n.of(context).certificatesCertificate_usage +
              ': ' +
              data[index].machine!,
          style: BuildTextStyle(type: TextBackground.white).header2,
        ),
        const SizedBox(height: 16.0),
        Text(
          I18n.of(context).certificatesCertificate_name +
              ': ' +
              data[index].name!,
          style: BuildTextStyle(type: TextBackground.white).body2,
        ),
        const SizedBox(height: 8.0),
        Text(
          I18n.of(context).certificatesCertificate_descr +
              ': ' +
              data[index].description!,
          style: BuildTextStyle(type: TextBackground.white).body2,
        ),
      ],
    );

    final Widget result = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff000000),
          width: 2.0,
        ),
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            iconAndLink,
            const SizedBox(height: 24.0),
            certificateInformation,
          ],
        ),
      ),
    );

    return result;
  }
}

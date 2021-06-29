import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../components.dart';
import '../../generated/i18n.dart';
import '../../models.dart';
import '../../screens.dart';
import '../../services.dart';
import '../../theme.dart';

/// A screen to provide a qr code scanner.
///
class QRCodeScannerScreen extends StatefulWidget {
  /// The route name for this screen.
  static const String route = '/home/qr_scan';

  @override
  State<StatefulWidget> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  /// The result of the qr code scan.
  Barcode? result;

  /// The controller for the [QRView].
  late QRViewController? controller;

  /// The key for the [QRView].
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool hasData = false;

  /// In order to get hot reload to work we need to pause the camera if the platform
  /// is android, or resume the camera if the platform is iOS.
  ///
  @override
  void reassemble() {
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();

    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    /// The consumer of a provider service.
    final AccessControlService _providerAccess =
        Provider.of<AccessControlService>(context);

    /// The consumer of a provider service.
    final UsageControlService _providerUsage =
        Provider.of<UsageControlService>(context);

    /// The app bar for this screen.
    final PreferredSizeWidget appBar = BuildAppBar(
      title: I18n.of(context).qrTitle,
    );

    /// Fetches data from the backend based on the qr code data and
    /// navigates to a new route.
    ///
    var doValidateWorkspaceData = () async {
      var data = await Document<Workspace>(path: result!.code).getData();
      await _providerAccess.enterWorkspace(result!.code, data);
      Navigator.pushNamedAndRemoveUntil(
        context,
        AccessWorkpsaceScreen.route,
        (route) => false,
        arguments: Workspace(
            path: result!.code,
            id: data.id,
            name: data.name,
            currentInWorkspace: data.currentInWorkspace,
            maxInWorkspace: data.maxInWorkspace),
      );
    };

    /// Fetches data from the backend based on the qr code data and
    /// navigates to a new route.
    ///
    var doValidateCertificateData = () async {
      var data = await Document<Certificate>(path: result!.code).getData();
      await _providerUsage.checkUserAuthorization(data.assignedTo!);
      Navigator.pushNamed(
        context,
        UseMachineScreen.route,
        arguments: Certificate(
          name: data.name,
          description: data.description,
          machine: data.machine,
          safetyInstruction: data.safetyInstruction,
          assignedTo: data.assignedTo,
        ),
      );
    };

    final Widget textForInformation = Align(
      alignment: Alignment.centerLeft,
      child: Text(
        I18n.of(context).qrInformation,
        style: BuildTextStyle(type: TextBackground.white).body2,
        textAlign: TextAlign.left,
      ),
    );

    if (result != null && result!.code.length > 35 && this.hasData == false) {
      toogleHasData();
      doValidateWorkspaceData();
    } else if (result != null &&
        result!.code.length < 35 &&
        this.hasData == false) {
      toogleHasData();
      doValidateCertificateData();
    }
    return Scaffold(
      appBar: appBar,
      body: _providerAccess.userAccessStatus == UserAccessStatus.Pending
          ? Loading()
          : Padding(
              padding: EdgeInsets.only(
                left: 24.0,
                top: 24.0,
                right: 24.0,
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.50,
                    ),
                    child: _buildQrView(context),
                  ),
                  textForInformation,
                  //if (result != null) button,
                ],
              ),
            ),
    );
  }

  /// The QR code widget that is displayed in this screen.
  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 400.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Color(0xff000000).withOpacity(0.0),
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void toogleHasData() {
    setState(() {
      this.hasData = true;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

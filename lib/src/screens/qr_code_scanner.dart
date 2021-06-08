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
      title: 'Scan QR code',
    );

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

    /// The button to validate the qr code scan.
    final Widget button = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: BuildSecondaryButton(
          text: 'Validate data',
          withIcon: true,
          icon: Icons.qr_code_outlined,
          function: () => result!.code.length > 35
              ? doValidateWorkspaceData()
              : doValidateCertificateData(),
          hint: 'Validate qr code data',
        ),
      ),
    );

    /// The loading widget for this screen.
    final Widget loading = Row(
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
      body: _providerAccess.userAccessStatus == UserAccessStatus.Pending
          ? Center(
              child: loading,
            )
          : Stack(
              children: <Widget>[
                _buildQrView(context),
                if (result != null) button,
              ],
            ),
    );
  }

  /// The QR code widget that is displayed in this screen.
  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: color_accent_green,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

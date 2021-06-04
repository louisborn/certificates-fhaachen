import 'dart:io';

import 'package:certificates/components.dart';
import 'package:certificates/generated/i18n.dart';
import 'package:certificates/models.dart';
import 'package:certificates/screens.dart';
import 'package:certificates/services.dart';
import 'package:certificates/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScreen extends StatefulWidget {
  static const String route = '/scan';

  @override
  State<StatefulWidget> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    AccessControlService _providerAccess =
        Provider.of<AccessControlService>(context);
    UsageControlService _providerUsage =
        Provider.of<UsageControlService>(context);

    final PreferredSizeWidget appBar = BuildAppBar(
      title: 'Scan QR code',
    );

    var doEnter = () async {
      var data = await Document<Workspace>(path: result!.code).getData();
      await _providerAccess.enterWorkspace(result!.code, data);
      Navigator.pushNamedAndRemoveUntil(
        context,
        WorkspaceScreen.route,
        (route) => false,
        arguments: Workspace(
            path: result!.code,
            id: data.id,
            name: data.name,
            currentInWorkspace: data.currentInWorkspace,
            maxInWorkspace: data.maxInWorkspace),
      );
    };

    var doValidateCertificate = () async {
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

    final Widget button = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: BuildSecondaryButton(
          text: 'Next',
          withIcon: false,
          width: 114.0,
          function: () =>
              result!.code.length > 35 ? doEnter() : doValidateCertificate(),
          hint: 'Validate qr code data',
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

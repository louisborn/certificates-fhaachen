import 'package:certificates/services.dart';
import 'package:flutter/material.dart';

import '../../components.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = PreferredSize(
      preferredSize: Size.fromHeight(64.0),
      child: BuildAppBar(
        title: 'Home',
        actions: [
          BuildIconButton(
            icon: Icons.info_outline,
            onTap: () => {},
          ),
          const SizedBox(width: 16.0),
          BuildIconButton(
            icon: Icons.history,
            onTap: () => {},
          ),
          const SizedBox(width: 16.0),
          BuildIconButton(
            icon: Icons.person_outline,
            onTap: () => {},
          ),
          const SizedBox(width: 16.0),
        ],
      ),
    );

    final Widget drawer = BuildDrawer(
      name: '',
      lastName: 'Born',
      children: [
        ListTile(
          title: Text('Logout'),
          onTap: () => Navigator.pop(context),
        )
      ],
    );

    final Widget title = Column(
      children: [
        Text(
          'Hello Louis',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff000000),
          ),
        ),
        Text(
          'Choose a action below.',
          style: TextStyle(
            fontSize: 16.0,
            color: Color(0xff000000),
          ),
        ),
      ],
    );

    final Widget buttonQrCode = BuildButtonContainer(
      title: 'Enter workspace',
      subtitle: 'Scan the qr code at the entrance of a workspace.',
      button: BuildPrimaryButton(
        text: 'Scan qr code',
        withIcon: false,
        function: () => {},
      ),
      icon: BuildIcon(
        icon: Icons.qr_code,
        size: 80.0,
      ),
    );

    final Widget buttonCertificates = BuildButtonContainer(
      title: 'My certificates',
      subtitle: 'Shows the students approved certificates.',
      button: BuildPrimaryButton(
        text: 'Show certificates',
        withIcon: false,
        function: () => {},
      ),
      icon: BuildIcon(
        icon: Icons.file_copy_outlined,
        size: 80.0,
      ),
    );

    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 24.0),
            title,
            const SizedBox(height: 24.0),
            buttonQrCode,
            const SizedBox(height: 16.0),
            buttonCertificates,
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'components.dart';
import 'services.dart';
import 'screens.dart';

import 'generated/i18n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceService().getInstance();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.delegate;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationService>(
          create: (_) => AuthenticationService(),
        ),
        ChangeNotifierProvider<AccessControlService>(
          create: (_) => AccessControlService(),
        ),
        ChangeNotifierProvider<UsageControlService>(
          create: (_) => UsageControlService(),
        ),
      ],
      child: MaterialApp(
        title: 'Certificates',
        debugShowCheckedModeBanner: false,
        home: PreferenceService().getString('studentId') != ''
            ? BuildBottomNavigationBar()
            : LoginScreen(),
        supportedLocales: i18n.supportedLocales,
        localeResolutionCallback: i18n.resolution(
          fallback: Locale('en', 'US'),
        ),
        localizationsDelegates: [
          i18n,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routes: <String, WidgetBuilder>{
          LoginScreen.route: (context) => LoginScreen(),
          TwoFactorScreen.route: (context) => TwoFactorScreen(),
          BuildBottomNavigationBar.route: (context) =>
              BuildBottomNavigationBar(),
          HomeScreen.route: (context) => HomeScreen(),
          MoreScreen.route: (context) => MoreScreen(),
          AccountScreen.route: (context) => AccountScreen(),
          HistoryLogScreen.route: (context) => HistoryLogScreen(),
          CertificatesScreen.route: (context) => CertificatesScreen(),
          SafetyInstructionScreen.route: (context) => SafetyInstructionScreen(),
          AboutScreen.route: (context) => AboutScreen(),
          CampusScreen.route: (context) => CampusScreen(),
          CampusDetailScreen.route: (context) => CampusDetailScreen(),
          QRCodeScannerScreen.route: (context) => QRCodeScannerScreen(),
          AccessWorkpsaceScreen.route: (context) => AccessWorkpsaceScreen(),
          UseMachineScreen.route: (context) => UseMachineScreen(),
        },
      ),
    );
  }
}

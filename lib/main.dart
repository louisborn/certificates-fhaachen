import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'services.dart';
import 'screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApplicationPreferences().getInstance();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        home: LoginScreen(),
        routes: <String, WidgetBuilder>{
          LoginScreen.route: (context) => LoginScreen(),
          TwoFactorScreen.route: (context) => TwoFactorScreen(),
          LogoutScreen.route: (context) => LogoutScreen(),
          HomeScreen.route: (context) => HomeScreen(),
        },
      ),
    );
  }
}

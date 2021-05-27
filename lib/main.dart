import 'package:certificates/services.dart';
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
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider<AccessControlProvider>(
          create: (_) => AccessControlProvider(),
        ),
        ChangeNotifierProvider<UsageControlProvider>(
          create: (_) => UsageControlProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Certificates',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: <String, WidgetBuilder>{
          LoginScreen.route: (context) => LoginScreen(),
          HomeScreen.route: (context) => HomeScreen(),
        },
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:certificates/providers.dart';
import 'package:certificates/src/screens/authentication/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      ],
      child: MaterialApp(
        title: 'Certificates',
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: <String, WidgetBuilder>{
          LoginScreen.route: (context) => LoginScreen(),
        },
      ),
    );
  }
}

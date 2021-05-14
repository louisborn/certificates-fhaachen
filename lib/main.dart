import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:certificates/providers/providers.dart';
import 'package:certificates/screens/authentication/login.dart';

void main() {
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

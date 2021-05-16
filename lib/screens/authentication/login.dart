import 'package:certificates/providers/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:certificates/providers/authentication.dart';
import 'package:certificates/theme/theme.dart';

//* A screen to provide a student authentication to get access
//* to the application.
//*
class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  String _studentId, _studentLastname;

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider _provider =
        Provider.of<AuthenticationProvider>(context);
    //! For testing. Will be removed.
    DatabaseProvider _testing = Provider.of<DatabaseProvider>(context);

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(ACCENT_PINK),
        ),
        const SizedBox(width: 8.0),
        Text('Loading', style: BODY1),
      ],
    );

    var doLogin = () async {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();

        //Todo: Add login logic.
      }
    };

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => _testing.leaveWorkspace(""),
          child: Text(
            'Testing',
          ),
        ),
      ),
    );
  }
}

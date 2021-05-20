import 'package:certificates/components.dart';
import 'package:certificates/src/providers/access_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:certificates/src/providers/authentication.dart';
import 'package:certificates/theme.dart';

/// A screen to provide a student authentication to get access
/// to the application.
///
class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  String? _studentId, _studentLastname;

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider _provider =
        Provider.of<AuthenticationProvider>(context);
    //! Only for testing. Remove after.
    AccessControlProvider _testing =
        Provider.of<AccessControlProvider>(context);

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color_accent_pink),
        ),
        const SizedBox(width: 8.0),
        Text('Loading'),
      ],
    );

    var doLogin = () async {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();

        //Todo: Add login logic.
      }
    };

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _testing.leaveWorkspace(),
              child: Text('Enter WS'),
            ),
            CalloutAccessControl(
                type: Type2.allowed,
                title: 'Test title for allowed people',
                subtitle: 'Subtitle'),
            Callout(
              title: "This is an attention",
              type: Type1.attention,
              exception: "No internet connection",
            ),
          ],
        ),
      ),
    );
  }
}

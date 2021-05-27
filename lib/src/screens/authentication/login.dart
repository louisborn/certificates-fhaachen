import 'package:certificates/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:certificates/services.dart';
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
    UsageControlProvider _testing = Provider.of<UsageControlProvider>(context);

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64.0),
        child: BuildAppBar(
          title: 'Test',
          centered: false,
          actions: [
            BuildIconButton(icon: Icons.arrow_forward, onTap: () => {})
          ],
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _testing.checkUserAuthorization(),
              child: Text('Check'),
            ),
            BuildModale(
              type: ModaleType.allowed,
              function: () {},
              title: 'Workspace entered - Workspace: Bibliothek',
              subtitle: 'Entered at: 02021.M.17 23:14',
              actionText: "Leave workspace",
            ),
            BuildModale(
              type: ModaleType.denied,
              function: () {},
              title: 'Workspace full - Workspace: Bibliothek',
              subtitle: 'Current in workspace: 25',
              actionText: "Try later again",
            ),
            BuildCallout(
              title: "This is an attention",
              type: CalloutType.attention,
              exception: "No internet connection",
            ),
            BuildCallout(
              title: "This is an error",
              type: CalloutType.error,
              exception: "Validation in login failed",
            ),
            BuildCallout(
              title: "This is an success",
              type: CalloutType.success,
            ),
          ],
        ),
      ),
    );
  }
}

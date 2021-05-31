import 'package:certificates/generated/i18n.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../components.dart';
import '../../../screens.dart';
import '../../../services.dart';
import '../../../theme.dart';

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

  late String? _studentId, _studentLastname;

  @override
  Widget build(BuildContext context) {
    AuthenticationService _provider =
        Provider.of<AuthenticationService>(context);

    final PreferredSizeWidget appbar = BuildAppBar(
      title: 'Login',
      centered: false,
    );

    final Widget logoAndText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/images/logo.svg'),
        const SizedBox(height: 8.0),
        Text(
          'Please login into your digital.access account.',
          style: BuildTextStyle(type: TextStyleType.white).subtitle2,
        ),
      ],
    );

    final Widget inputUserId = BuildTextField(
      label: 'Studend id',
      isMandatory: true,
      onSaved: (String? value) => _studentId = value,
      validator: (String? value) =>
          value!.isEmpty ? 'This is a mandatory field' : '',
      hint: 'Input for the user`s student id',
    );

    final Widget inputUserName = BuildTextField(
      label: 'Last name',
      isMandatory: true,
      onSaved: (String? value) => _studentLastname = value,
      validator: (String? value) =>
          value!.isEmpty ? 'This is a mandatory field' : '',
      hint: 'Input for the user`s last name',
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

    var doLogin = () async {
      final form = formKey.currentState;
      if (!form!.validate()) {
        form.save();
        await _provider.login(this._studentId!.toLowerCase(),
            this._studentLastname!.toUpperCase());
        if (_provider.loggedInStatus == AuthenticationStatus.ReadyFor2fA)
          Navigator.pushNamed(context, TwoFactorScreen.route);
      }
    };

    return Scaffold(
      appBar: appbar,
      body: Padding(
        padding: EdgeInsets.only(left: 8.0, top: 24.0, right: 8.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                logoAndText,
                const SizedBox(height: 32.0),
                inputUserId,
                const SizedBox(height: 16.0),
                inputUserName,
                const SizedBox(height: 32.0),
                _provider.authenticationError == AuthenticationError.Exception
                    ? BuildCallout(
                        type: CalloutType.error,
                        title: I18n.of(context).error_default,
                        exception: _provider.exception,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
      bottomSheet:
          _provider.loggedInStatus == AuthenticationStatus.Authenticating
              ? loading
              : BuildPrimaryButton(
                  text: 'Login',
                  withIcon: false,
                  function: doLogin,
                  hint:
                      'Validates the input data and navigates to the two factor page',
                ),
    );
  }
}

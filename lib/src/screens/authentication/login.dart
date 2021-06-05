import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../components.dart';
import '../../../generated/i18n.dart';
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
      title: I18n.of(context).loginTitle,
      centered: false,
    );

    final Widget logoAndText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/images/logo.svg'),
        const SizedBox(height: 8.0),
        Text(
          I18n.of(context).loginSubtitle,
          style: BuildTextStyle(type: TextStyleType.white).subtitle2,
        ),
      ],
    );

    final Widget inputUserId = BuildTextField(
      label: I18n.of(context).loginTextfield_1_label,
      isMandatory: true,
      onSaved: (String? value) => _studentId = value,
      validator: (value) =>
          value!.isEmpty ? I18n.of(context).textfield_error : '',
      hint: I18n.of(context).loginTextfield_1_hint,
    );

    final Widget inputUserName = BuildTextField(
      label: I18n.of(context).loginTextfield_2_label,
      isMandatory: true,
      onSaved: (String? value) => _studentLastname = value,
      validator: (String? value) =>
          value!.isEmpty ? I18n.of(context).textfield_error : '',
      hint: I18n.of(context).loginTextfield_1_hint,
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
      if (this.formKey.currentState!.validate()) {
        //form.save();
        await _provider.login(
          this._studentId!.toLowerCase(),
          this._studentLastname!.toUpperCase(),
        );
        if (_provider.loggedInStatus == AuthenticationStatus.ReadyFor2fA)
          Navigator.pushNamed(context, TwoFactorScreen.route);
      }
    };

    return Scaffold(
      appBar: appbar,
      body: Form(
        key: this.formKey,
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, top: 24.0, right: 8.0),
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
                  text: I18n.of(context).loginTitle,
                  withIcon: false,
                  function: doLogin,
                  hint: I18n.of(context).loginLogin_btn_hint,
                ),
    );
  }
}

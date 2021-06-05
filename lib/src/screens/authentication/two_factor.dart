import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../components.dart';
import '../../../generated/i18n.dart';
import '../../../services.dart';
import '../../../theme.dart';

/// A screen to provide the two factor authentication inorder to
/// let a user login into his account.
///
class TwoFactorScreen extends StatefulWidget {
  /// The route name for this screen.
  static const String route = '/twofactor';

  @override
  _TwoFactorScreenState createState() => _TwoFactorScreenState();
}

class _TwoFactorScreenState extends State<TwoFactorScreen> {
  /// The global text field state.
  final formKey = GlobalKey<FormState>();

  /// The unique token for the two factor authentication.
  late String? _token;

  @override
  Widget build(BuildContext context) {
    AuthenticationService _provider =
        Provider.of<AuthenticationService>(context);

    final PreferredSizeWidget appbar = BuildAppBar(
      title: I18n.of(context).twofaTitle,
      centered: false,
    );

    final Widget logoAndSubtitle = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/images/logo.svg'),
        const SizedBox(height: 8.0),
        Text(
          I18n.of(context).twofaSubtitle,
          style: BuildTextStyle(type: TextStyleType.white).subtitle2,
        ),
      ],
    );

    final Widget vectorGraphic = Align(
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/images/vector_authentication.svg',
      ),
    );

    final Widget inputForToken = BuildTextField(
      label: I18n.of(context).twofaTextfield_1_label,
      isMandatory: true,
      onSaved: (String? value) => _token = value!,
      validator: (value) =>
          value!.isEmpty ? I18n.of(context).textfield_error : null,
      hint: I18n.of(context).twofaTextfield_1_hint,
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

    var do2fA = () async {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        await _provider.validate2fAToken(this._token!);
        if (_provider.loggedInStatus == AuthenticationStatus.LoggedIn)
          Navigator.pushNamedAndRemoveUntil(
              context, BuildBottomNavigationBar.route, (route) => false);
      }
    };

    return Scaffold(
      appBar: appbar,
      body: _provider.loggedInStatus != AuthenticationStatus.Authenticating
          ? Form(
              key: this.formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8.0,
                    top: 24.0,
                    right: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      logoAndSubtitle,
                      const SizedBox(
                        height: 16.0,
                      ),
                      vectorGraphic,
                      const SizedBox(
                        height: 16.0,
                      ),
                      inputForToken,
                      const SizedBox(
                        height: 32.0,
                      ),
                      _provider.authenticationError ==
                              AuthenticationError.Exception
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
            )
          : Center(
              child: loading,
            ),
      bottomSheet: BuildPrimaryButton(
        text: I18n.of(context).twofa_btn_label,
        withIcon: false,
        function: do2fA,
        hint: I18n.of(context).twofa_btn_hint,
      ),
    );
  }
}

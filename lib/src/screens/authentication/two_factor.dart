import 'package:certificates/components.dart';
import 'package:certificates/screens.dart';
import 'package:certificates/services.dart';
import 'package:certificates/src/components/organisms/bottom_navigation_bar.dart';
import 'package:certificates/src/theme/text_style.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TwoFactorScreen extends StatefulWidget {
  static const String route = '/twofactor';

  @override
  _TwoFactorScreenState createState() => _TwoFactorScreenState();
}

class _TwoFactorScreenState extends State<TwoFactorScreen> {
  final formKey = GlobalKey<FormState>();

  late String? _token;

  @override
  Widget build(BuildContext context) {
    AuthenticationService _provider =
        Provider.of<AuthenticationService>(context);

    final PreferredSizeWidget appbar = BuildAppBar(
      title: 'Two factor',
      centered: false,
    );

    final Widget logoAndText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/images/logo.svg'),
        const SizedBox(height: 8.0),
        Text(
          'Please confirm your account by entering the token send per email.',
          style: BuildTextStyle(type: TextStyleType.white).subtitle2,
        ),
      ],
    );

    final Widget vector = Align(
      alignment: Alignment.center,
      child: SvgPicture.asset('assets/images/vector_authentication.svg'),
    );

    final Widget inputToken = BuildTextField(
      label: 'Unique token',
      isMandatory: true,
      onSaved: (String? value) => _token = value!,
      validator: (String? value) =>
          value!.isEmpty ? 'This is a mandatory field' : '',
      hint: 'Input for the user`s unique two factor token',
    );

    var do2fA = () async {
      final form = formKey.currentState;
      if (!form!.validate()) {
        form.save();
        await _provider.validate2fAToken(this._token!);
        if (_provider.loggedInStatus == AuthenticationStatus.LoggedIn)
          Navigator.pushNamedAndRemoveUntil(
              context, BuildBottomNavigationBar.route, (route) => false);
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
                const SizedBox(height: 16.0),
                vector,
                const SizedBox(height: 16.0),
                inputToken,
                const SizedBox(height: 32.0),
                _provider.authenticationError == AuthenticationError.Exception
                    ? BuildCallout(
                        type: CalloutType.error,
                        title: 'An error has occured',
                        exception: _provider.exception,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: BuildPrimaryButton(
        text: 'Validate token',
        withIcon: false,
        function: do2fA,
        hint: 'Validates the input token and login the user',
      ),
    );
  }
}

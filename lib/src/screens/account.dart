import 'package:flutter/material.dart';

import '../../generated/i18n.dart';
import '../../services.dart';
import '../../theme.dart';
import '../../components.dart';

class AccountScreen extends StatelessWidget {
  /// The route name for this screen.
  static const String route = '/home/account';

  /// The unique [_id] of a user.
  final String _id = PreferenceService().getString('studentId')!;

  /// The [_firstName] of a user.
  final String _firstName = PreferenceService().getString('firstName')!;

  /// The [_lastName] of a user.
  final String _lastName = PreferenceService().getString('lastName')!;

  @override
  Widget build(BuildContext context) {
    /// The app bar for this screen.
    final PreferredSizeWidget appBar = BuildAppBar(
      title: I18n.of(context).accountTitle,
    );

    /// The circle avatar with the first letter of the
    /// user first and last name.
    ///
    final Widget avatar = Align(
      alignment: Alignment.center,
      child: BuildAccountCircle(
        firstName: this._firstName,
        lastName: this._lastName,
      ),
    );

    /// The user`s name.
    final Widget textWithUserName = Text(
      I18n.of(context).accountUser(
        this._firstName.toLowerCase() + ' ' + this._lastName.toLowerCase(),
      ),
      style: BuildTextStyle(type: TextBackground.white).body2,
      textAlign: TextAlign.center,
    );

    /// The user`s student id.
    final Widget textWithUserId = Text(
      I18n.of(context).accountId(
        this._id,
      ),
      style: BuildTextStyle(type: TextBackground.white).body2,
      textAlign: TextAlign.center,
    );

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          top: 24.0,
          right: 8.0,
        ),
        child: Column(
          children: [
            avatar,
            const SizedBox(
              height: 16.0,
            ),
            textWithUserName,
            const SizedBox(
              height: 8.0,
            ),
            textWithUserId,
          ],
        ),
      ),
    );
  }
}

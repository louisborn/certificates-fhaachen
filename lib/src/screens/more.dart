import 'package:flutter/material.dart';

import '../../generated/i18n.dart';
import '../../components.dart';
import '../../screens.dart';
import '../../services.dart';

class MoreScreen extends StatelessWidget {
  static const String route = '/more';

  @override
  Widget build(BuildContext context) {
    final Widget listTileAccount = GestureDetector(
      onTap: () => Navigator.pushNamed(context, AccountScreen.route),
      child: ListTile(
        leading: BuildIcon(
          icon: Icons.account_circle_outlined,
        ),
        title: Text(
          I18n.of(context).moreListTile_1_title,
        ),
        trailing: BuildIcon(
          icon: Icons.arrow_forward_ios_outlined,
        ),
      ),
    );

    final Widget listTileCampus = GestureDetector(
      onTap: () => Navigator.pushNamed(context, CampusScreen.route),
      child: ListTile(
        leading: BuildIcon(
          icon: Icons.home_work_outlined,
        ),
        title: Text(
          'Campus status',
        ),
        trailing: BuildIcon(
          icon: Icons.arrow_forward_ios_outlined,
        ),
      ),
    );

    final Widget listTileQuestions = GestureDetector(
      onTap: () {},
      child: ListTile(
        leading: BuildIcon(
          icon: Icons.question_answer_outlined,
        ),
        title: Text(
          I18n.of(context).moreListTile_2_title,
        ),
        trailing: BuildIcon(
          icon: Icons.arrow_forward_ios_outlined,
        ),
      ),
    );

    final Widget listTileLogout = GestureDetector(
      onTap: () => Navigator.of(context).restorablePush(_dialogBuilder),
      child: ListTile(
        leading: BuildIcon(
          icon: Icons.logout,
        ),
        title: Text(
          I18n.of(context).moreListTile_3_title,
        ),
        trailing: BuildIcon(
          icon: Icons.arrow_forward_ios_outlined,
        ),
      ),
    );

    return Column(
      children: [
        listTileAccount,
        listTileCampus,
        listTileQuestions,
        listTileLogout,
      ],
    );
  }

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: BuildCallout(
          type: CalloutType.attention,
          title: I18n.of(context).moreAlert_logout_title,
        ),
        actions: [
          Container(
            width: 126,
            child: BuildSecondaryButton(
              text: I18n.of(context).moreAlert_logout_cancel_text,
              withIcon: false,
              function: () => Navigator.pop(context),
              hint: I18n.of(context).moreAlert_logout_cancel_hint,
            ),
          ),
          Container(
            width: 126,
            child: BuildPrimaryButton(
              text: I18n.of(context).moreAlert_logout_logout_text,
              withIcon: false,
              function: () async {
                if (await AuthenticationService().logout()) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.route, (route) => false);
                }
              },
              hint: I18n.of(context).moreAlert_logout_logout_hint,
            ),
          ),
        ],
      ),
    );
  }
}

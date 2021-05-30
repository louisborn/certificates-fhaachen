import 'package:certificates/services.dart';
import 'package:certificates/src/theme/text_style.dart';
import 'package:flutter/material.dart';

import '../../components.dart';

class AccountScreen extends StatelessWidget {
  static const String route = '/account';

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = BuildAppBar(
      title: 'Account',
    );

    final Widget avatar = Align(
      alignment: Alignment.center,
      child: BuildProfileImage(
        firstName: 'Louis',
        lastName: 'Born',
      ),
    );

    final Widget user = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'User:',
          style: BuildTextStyle(type: TextStyleType.white).subtitle2,
        ),
        Text(
          PreferenceService().getString('firstName')!.toLowerCase() +
              ' ' +
              PreferenceService().getString('lastName')!.toLowerCase(),
          style: BuildTextStyle(type: TextStyleType.white).header3,
        ),
      ],
    );

    final Widget id = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Id:',
          style: BuildTextStyle(type: TextStyleType.white).subtitle2,
        ),
        Text(
          PreferenceService().getString('studentId')!,
          style: BuildTextStyle(type: TextStyleType.white).header3,
        ),
      ],
    );

    final Widget personalInformation = Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          user,
          const SizedBox(height: 8.0),
          id,
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.only(left: 8.0, top: 24.0, right: 8.0),
        child: Column(
          children: [
            avatar,
            const SizedBox(height: 16.0),
            personalInformation,
          ],
        ),
      ),
    );
  }
}

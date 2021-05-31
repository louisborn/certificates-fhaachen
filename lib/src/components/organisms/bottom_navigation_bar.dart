import 'package:certificates/generated/i18n.dart';
import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../screens.dart';
import '../../../theme.dart';

class BuildBottomNavigationBar extends StatefulWidget {
  static const String route = '/bottomNavigationBar';

  @override
  _BuildBottomNavigationBar createState() => _BuildBottomNavigationBar();
}

class _BuildBottomNavigationBar extends State<BuildBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var _onItemTapped = (int index) => setState(
          () {
            _selectedIndex = index;
          },
        );

    final PreferredSizeWidget appBar = BuildAppBar(
      title: I18n.of(context).homeTitle,
      actions: [
        BuildIconButton(
          icon: Icons.info_outline,
          hint: 'Navigates to the about page',
          onTap: () => Navigator.pushNamed(context, AboutScreen.route),
        ),
        const SizedBox(width: 16.0),
        BuildIconButton(
          icon: Icons.history,
          hint: 'Navigates to the about history log page',
          onTap: () => Navigator.pushNamed(context, HistoryLogScreen.route),
        ),
        const SizedBox(width: 16.0),
        BuildIconButton(
          icon: Icons.person_outline,
          hint: 'Navigates to the account page',
          onTap: () => Navigator.pushNamed(context, AccountScreen.route),
        ),
        const SizedBox(width: 16.0),
      ],
    );

    final Widget bottomNavigationBar = BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: I18n.of(context).homeTitle,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_outlined),
          label: I18n.of(context).homeMore,
        ),
      ],
      selectedItemColor: color_accent_green,
    );

    final List<Widget> _widgets = <Widget>[
      HomeScreen(),
      MoreScreen(),
    ];

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: _widgets.elementAt(_selectedIndex),
      ),
    );
  }
}

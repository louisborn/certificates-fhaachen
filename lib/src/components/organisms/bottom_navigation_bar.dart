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
    final PreferredSizeWidget appBar = BuildAppBar(
      title: 'Home',
      actions: [
        BuildIconButton(
          icon: Icons.info_outline,
          onTap: () => {},
        ),
        const SizedBox(width: 16.0),
        BuildIconButton(
          icon: Icons.history,
          onTap: () => {},
        ),
        const SizedBox(width: 16.0),
        BuildIconButton(
          icon: Icons.person_outline,
          onTap: () => {},
        ),
        const SizedBox(width: 16.0),
      ],
    );

    var _onItemTapped = (int index) => setState(
          () {
            _selectedIndex = index;
          },
        );

    final Widget bottomNavigationBar = BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_outlined),
          label: 'More',
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

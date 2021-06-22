import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../generated/i18n.dart';
import '../../../screens.dart';
import '../../../theme.dart';

/// A bottom navigation for this application.
///
/// Is used as the base for the [HomeScreen] and [MoreScreen] enabling
/// to switch between those two screens.
///
class BuildBottomNavigationBar extends StatefulWidget {
  /// The route name for this screen.
  static const String route = '/start';

  @override
  _BuildBottomNavigationBar createState() => _BuildBottomNavigationBar();
}

class _BuildBottomNavigationBar extends State<BuildBottomNavigationBar> {
  /// The selected index for the current displayed widget.
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    /// Holds a list of widgets to be displayed by the
    /// bottom navigation.
    ///
    final List<Widget> _widgets = <Widget>[
      HomeScreen(),
      MoreScreen(),
    ];

    /// Sets the `_selectedIndex` to the current index.
    var _onItemTapped = (int index) => setState(() {
          _selectedIndex = index;
        });

    /// The app bar for this screen.
    final PreferredSizeWidget appBar = BuildAppBar(
      title: I18n.of(context).homeTitle,
      actions: [
        BuildIconButton(
          icon: Icons.info_outline,
          hint: I18n.of(context).homeAppBar_hint_1,
          onTap: () => Navigator.pushNamed(
            context,
            AboutScreen.route,
          ),
        ),
        const SizedBox(width: 16.0),
        BuildIconButton(
          icon: Icons.history,
          hint: I18n.of(context).homeAppBar_hint_2,
          onTap: () => Navigator.pushNamed(
            context,
            HistoryLogScreen.route,
          ),
        ),
        const SizedBox(width: 16.0),
        BuildIconButton(
          icon: Icons.person_outline,
          hint: I18n.of(context).homeAppBar_hint_3,
          onTap: () => Navigator.pushNamed(
            context,
            AccountScreen.route,
          ),
        ),
        const SizedBox(width: 16.0),
      ],
    );

    /// The bottom navigation bar for this screen.
    final Widget bottomNavigationBar = BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.home_outlined,
          ),
          label: I18n.of(context).homeTitle,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.more_horiz_outlined,
          ),
          label: I18n.of(context).homeMore,
        ),
      ],
      selectedItemColor: color_accent_green,
    );

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          top: 24.0,
          right: 8.0,
        ),
        child: _widgets.elementAt(
          _selectedIndex,
        ),
      ),
    );
  }
}

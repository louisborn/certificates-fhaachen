import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

import '../../components.dart';
import '../../screens.dart';
import '../../services.dart';

/// A screen to provide a splash animation when loading the
/// application.
///
class SplashAnimationScreen extends StatefulWidget {
  /// The route name for this screen.
  static const String route = '/splash';

  const SplashAnimationScreen({Key? key}) : super(key: key);

  @override
  _SplashAnimationScreenState createState() => _SplashAnimationScreenState();
}

class _SplashAnimationScreenState extends State<SplashAnimationScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      PreferenceService().getString('studentId') != ''
          ? Navigator.pushNamedAndRemoveUntil(
              context, BuildBottomNavigationBar.route, (route) => false)
          : Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.route, (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// The brand logo.
    final Widget logo = SvgPicture.asset(
      'assets/images/logo.svg',
    );

    /// The splash animation.
    final Widget animation = Container(
      width: 48.0,
      height: 48.0,
      child: RiveAnimation.asset(
        'assets/images/splash.riv',
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            animation,
            const SizedBox(
              height: 16.0,
            ),
            logo,
          ],
        ),
      ),
    );
  }
}

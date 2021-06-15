import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

/// A banner with the brand color for this application.
///
class BuildBanner extends StatelessWidget {
  /// Create a banner.
  ///
  /// The default [width] is full screen size. The default
  /// [height] is 8.0 pixels.
  ///
  BuildBanner({
    this.width = double.infinity,
    this.height = 8.0,
  });

  /// The width of the banner.
  final double width;

  /// The height of the banner.
  final double height;

  /// The banner itself.
  final SvgPicture svg = SvgPicture.asset(
    'assets/images/banner.svg',
  );

  @override
  Widget build(BuildContext context) {
    final Widget result = Container(
      width: this.width,
      height: this.height,
      child: this.svg,
    );

    return Semantics(
      readOnly: true,
      hint: 'A banner with the brand colors.',
      child: result,
    );
  }
}

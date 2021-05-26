import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildBanner extends StatelessWidget {
  BuildBanner({
    this.width = double.infinity,
    this.height = 8.0,
  });

  final double width;

  final double height;

  final SvgPicture svg = SvgPicture.asset('assets/images/banner.svg');

  @override
  Widget build(BuildContext context) {
    final Widget result = Container(
      width: this.width,
      height: this.height,
      child: this.svg,
    );

    return result;
  }
}

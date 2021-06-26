import 'package:flutter/material.dart';

import '../../../generated/i18n.dart';
import '../../../theme.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// The loading widget for this screen.
    final Widget loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color_accent_green),
        ),
        const SizedBox(width: 8.0),
        Text(I18n.of(context).loading),
      ],
    );

    return Center(
      child: loading,
    );
  }
}

import 'package:flutter/material.dart';

import '../../../generated/i18n.dart';
import '../../../components.dart';

/// A error screen for a no data error.
///
/// Uses a [BuildCallout] with a [CalloutType.error].
///
class ErrorNoData extends StatelessWidget {
  const ErrorNoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          top: 24.0,
          right: 8.0,
        ),
        child: BuildCallout(
          type: CalloutType.attention,
          title: I18n.of(context).error_noData,
        ),
      ),
    );
  }
}

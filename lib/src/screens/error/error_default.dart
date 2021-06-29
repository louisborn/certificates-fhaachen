import 'package:flutter/material.dart';

import '../../../generated/i18n.dart';
import '../../../components.dart';

/// A default error screen.
///
/// Uses a [BuildCallout] with a [CalloutType.error].
///
class ErrorDefault extends StatelessWidget {
  const ErrorDefault({Key? key}) : super(key: key);

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
          type: CalloutType.error,
          title: I18n.of(context).error_default,
        ),
      ),
    );
  }
}

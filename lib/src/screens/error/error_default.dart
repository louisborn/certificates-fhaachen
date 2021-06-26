import 'package:flutter/material.dart';

import '../../../generated/i18n.dart';
import '../../../components.dart';

class ErrorDefault extends StatelessWidget {
  const ErrorDefault({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BuildCallout(
        type: CalloutType.error,
        title: I18n.of(context).error_default,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../generated/i18n.dart';
import '../../../components.dart';

class ErrorNoData extends StatelessWidget {
  const ErrorNoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BuildCallout(
        type: CalloutType.attention,
        title: I18n.of(context).error_noData,
      ),
    );
  }
}

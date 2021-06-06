import 'package:flutter/material.dart';

import '../../../generated/i18n.dart';
import '../../../screens.dart';
import '../../../services.dart';
import '../../../theme.dart';
import '../../../components.dart';

class BuildCertificateContainer extends StatelessWidget {
  BuildCertificateContainer({
    required this.name,
    required this.usage,
    required this.assignedTo,
    required this.descripition,
    required this.safetyInstruction,
  });

  final String? name;

  final String? usage;

  final List? assignedTo;

  final String? descripition;

  final String? safetyInstruction;

  @override
  Widget build(BuildContext context) {
    final Widget link = GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        SafetyInstructionScreen.route,
        arguments: ImageModel(imageRef: safetyInstruction),
      ),
      child: Text(
        I18n.of(context).certificatesShow_certificate,
        style: BuildTextStyle(type: TextBackground.white)
            .body2
            .copyWith(color: color_accent_blue),
      ),
    );

    final Widget iconAndLink = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BuildIcon(
          icon: this.assignedTo!.contains(
                    PreferenceService().getString('studentId'),
                  )
              ? Icons.check_box_outlined
              : Icons.indeterminate_check_box_outlined,
          color: this.assignedTo!.contains(
                    PreferenceService().getString('studentId'),
                  )
              ? color_success
              : color_error,
        ),
        link,
      ],
    );

    final Widget certificateInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          I18n.of(context).certificatesCertificate_name + ': ' + this.name!,
          style: BuildTextStyle(type: TextBackground.white).body1,
        ),
        const SizedBox(height: 8.0),
        Text(
          I18n.of(context).certificatesCertificate_usage + ': ' + this.usage!,
          style: BuildTextStyle(type: TextBackground.white).body1,
        ),
        const SizedBox(height: 16.0),
        Text(
          I18n.of(context).certificatesCertificate_descr +
              ': ' +
              this.descripition!,
          style: BuildTextStyle(type: TextBackground.white).body2,
        ),
      ],
    );

    final Widget result = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff000000),
          width: 2.0,
        ),
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            iconAndLink,
            const SizedBox(height: 16.0),
            certificateInformation,
          ],
        ),
      ),
    );

    return result;
  }
}

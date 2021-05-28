import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class BuildTextField extends StatelessWidget {
  BuildTextField({
    required this.hint,
    required this.isMandatory,
    required this.onSaved,
    required this.validator,
    this.textStyle =
        const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
  });

  final String? hint;

  final bool? isMandatory;

  final void Function(String?)? onSaved;

  final String Function(String? s)? validator;

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    final Widget result = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          this.isMandatory! ? this.hint! + '*' : this.hint!,
          style: this.textStyle,
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: Color(0xff000000),
                width: 2.0,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: color_accent_green,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: color_error,
                width: 2.0,
              ),
            ),
          ),
          onSaved: this.onSaved,
          validator: this.validator,
        ),
      ],
    );

    return result;
  }
}

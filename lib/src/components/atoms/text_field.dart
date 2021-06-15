import 'package:flutter/material.dart';

import '../../theme/colors.dart';

/// A text field used in the application.
///
/// The [BuildTextField] consists of a [Column] containing a
/// [label] text and a [TextFormField].
///
/// The [hint] is used in the [Semantics] widget for accessibility reason.
///
class BuildTextField extends StatelessWidget {
  /// Create a text field.
  ///
  /// The [label], [isMandatory] function, [onSaved] function,
  /// [validator] is required.
  ///
  BuildTextField({
    required this.label,
    required this.isMandatory,
    required this.onSaved,
    required this.validator,
    this.textStyle = const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
    this.hint,
  });

  /// The text field`s label text.
  final String? label;

  /// Indicates if the text field is mandatory
  /// or not.
  final bool? isMandatory;

  /// The function to save the entered text.
  final void Function(String?)? onSaved;

  /// The function to validate the entered text.
  final String? Function(String? s)? validator;

  /// The text style of the input text.
  final TextStyle textStyle;

  /// The brief textual description of the required input.
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final Widget result = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          this.isMandatory! ? this.label! + '*' : this.label!,
          style: this.textStyle,
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          decoration: const InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: Color(0xff000000),
                width: 2.0,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: color_accent_green,
                width: 2.0,
              ),
            ),
            errorBorder: const OutlineInputBorder(
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

    return Semantics(
      textField: true,
      hint: this.hint,
      child: result,
    );
  }
}

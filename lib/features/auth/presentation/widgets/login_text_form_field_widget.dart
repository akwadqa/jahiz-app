import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jahiz/core/shared_functions.dart';

class LoginTextFormField extends StatelessWidget {
  final String? initialValue;
  final String? labelText;
  final bool readOnly;
  final bool? filled;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final InputBorder? enabledBorder;
  const LoginTextFormField(
      {super.key,
      this.initialValue,
      this.readOnly = false,
      this.filled,
      this.fillColor,
      this.validator,
      this.onSaved,
      this.enabledBorder,
      this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      readOnly: readOnly,
      textInputAction: TextInputAction.done,
      textAlign: TextAlign.center,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        ArabicNumberInputFormatter(),
      ],
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      validator: validator,
      onSaved: onSaved,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          isDense: true,
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: enabledBorder,
          filled: filled,
          fillColor: fillColor),
    );
  }
}

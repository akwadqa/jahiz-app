import 'package:flutter/material.dart';

import 'error_text.dart';

class CheckBoxFormField extends FormField<bool> {
  CheckBoxFormField(
      {super.key,
      super.onSaved,
      super.validator,
      required final List<Widget> sideWidgets})
      : super(
            initialValue: true,
            builder: (FormFieldState<bool> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)),
                          value: state.value,
                          onChanged: (value) => state.didChange(value)),
                      ...sideWidgets
                    ],
                  ),
                  if (state.hasError) ErrorText(text: state.errorText!)
                ],
              );
            });
}

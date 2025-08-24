import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/presentation/components/datepicker%20/datepicker.dart';
import 'package:personal_health_app/presentation/components/styled_text_form_field.dart';

class MultiTypeField extends StatelessWidget {
  final DynamicFieldEntity dynamicField;
  final TextEditingController textController;

  const MultiTypeField({
    super.key,
    required this.dynamicField,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    if (dynamicField.dataType == 'date') {
      return DatePickerTextField(
        label: dynamicField.name,
        controller: textController,
      );
    }
    if (dynamicField.dataType == 'number') {
      return StyledTextFormField(
        label: dynamicField.name,
        controller: textController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]*\.?[0-9]*'))
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Insira algum valor';
          }
          return null;
        },
      );
    }

    return StyledTextFormField(
      label: dynamicField.name,
      controller: textController,
      keyboardType: TextInputType.none,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira algum valor';
        }
        return null;
      },
    );
  }
}

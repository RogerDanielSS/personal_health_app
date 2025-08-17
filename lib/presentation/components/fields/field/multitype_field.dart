import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/presentation/components/styled_text_form_field.dart';

class MultiTypeField extends StatelessWidget {
  final DynamicFieldEntity? dynamicField;
  // final TextEditingController _stringTextTypeController = TextEditingController();

  const MultiTypeField({
    super.key,
    this.dynamicField,
  });

  @override
  Widget build(BuildContext context) {
    if (dynamicField?.dataType == 'date') {
      return StyledTextFormField(
        label: dynamicField?.name ?? '',
        keyboardType: TextInputType.datetime,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Insira algum valor';
          }
          return null;
        },
      );
    }
    if (dynamicField?.dataType == 'float') return TextField();

    return StyledTextFormField(
      label: dynamicField?.name ?? '',
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

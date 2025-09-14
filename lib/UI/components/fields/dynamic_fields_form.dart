import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/UI/components/fields/field/multitype_field.dart';

class DynamicFieldsForm extends StatefulWidget {
  final List<DynamicFieldEntity>? dynamicFields;
  final Function(Map<String, String>)? onSubmit;

  const DynamicFieldsForm({super.key, this.dynamicFields, this.onSubmit});

  @override
  State<DynamicFieldsForm> createState() => _DynamicFieldsFormState();
}

class _DynamicFieldsFormState extends State<DynamicFieldsForm> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.dynamicFields?.length ?? 0,
      (index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    // Dispose all controllers to prevent memory leaks
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<Widget> buildFields() {
    return List.generate(
      widget.dynamicFields?.length ?? 0,
      (index) => MultiTypeField(
        dynamicField: widget.dynamicFields![index],
        textController: _controllers[index],
      ),
    );
  }

  // Optional: Method to get all field values as a map (fieldId -> value)
  Map<String, String> _getFieldValues() {
    final Map<String, String> values = {};
    for (int i = 0; i < (widget.dynamicFields?.length ?? 0); i++) {
      final field = widget.dynamicFields![i];
      values[field.name] = _controllers[i].text;
    }
    return values;
  }

  // Optional: Method to clear all fields
  // void _clearAllFields() {
  //   for (var controller in _controllers) {
  //     controller.clear();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                key: widget.key,
                spacing: 16,
                children: buildFields(),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () => widget.onSubmit!(_getFieldValues()),
                child: Text('Salvar'),
              ),
            ],
          )),
    );
  }
}

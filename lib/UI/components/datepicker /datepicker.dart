import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_health_app/UI/components/styled_text_form_field/styled_text_form_field.dart';

class DatePickerTextField extends StatefulWidget {
  const DatePickerTextField({
    super.key,
    required this.controller,
    this.label = '',
  });

  final TextEditingController controller;
  final String label;

  @override
  State<DatePickerTextField>  createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  DateTime? _selectedDate;
  final TextEditingController internalController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale('pt', 'BR'),
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // widget.controller.text = "${picked.toLocal()}".split(' ')[0];
        
        // Or format the date as you prefer:
        widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
        internalController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StyledTextFormField(
      controller: internalController,
      label: widget.label,
      onTap: () => _selectDate(context),
      readOnly: true, 
      suffixIcon: Icon(Icons.calendar_today),
      keyboardType: TextInputType.none, 
      validator: (String? value) {
        return null;
        }, // Prevents keyboard from appearing
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
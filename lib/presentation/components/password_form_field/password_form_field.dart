import 'package:flutter/material.dart';
import 'package:personal_health_app/presentation/components/styled_text_form_field/styled_text_form_field.dart';

class StyledPasswordFormField extends StatefulWidget {
  const StyledPasswordFormField({
    super.key,
    required this.controller,
    this.label = '',
    this.suffixIcon,
    required this.validator,
  });

  final TextEditingController controller;
  final String label;
  final Widget? suffixIcon;
  final FormFieldValidator<String> validator;

  @override
  State<StyledPasswordFormField> createState() =>
      _StyledPasswordFormFieldState();
}

class _StyledPasswordFormFieldState extends State<StyledPasswordFormField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StyledTextFormField(
      controller: widget.controller,
      suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[600],
              ),
              onPressed: _togglePasswordVisibility,
            ),
      keyboardType: TextInputType.none,
      validator: widget.validator,
    );
  }
}

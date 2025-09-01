import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StyledTextFormField extends StatefulWidget {
  const StyledTextFormField({
    super.key,
    required this.controller,
    this.enableObscureText = false,
    this.readOnly = false,
    this.obscureText = false,
    this.label = '',
    this.suffixIcon,
    this.onTap,
    this.inputFormatters,
    required this.keyboardType,
    required this.validator,
  });

  final TextEditingController controller;
  final bool enableObscureText;
  final bool readOnly;
  final bool obscureText;
  final String label;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;

  @override
  State<StyledTextFormField> createState() => _StyledTextFormFieldState();
}

class _StyledTextFormFieldState extends State<StyledTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText:  widget.obscureText,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        labelText: widget.label,
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        labelStyle: TextStyle(color: Colors.grey[600]),
        floatingLabelStyle: const TextStyle(color: Colors.black),
      ),
      style: const TextStyle(color: Colors.black),
      keyboardType: widget.keyboardType,
      validator: widget.validator,
    );
  }
}

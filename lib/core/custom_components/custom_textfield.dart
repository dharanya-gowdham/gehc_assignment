import 'package:flutter/material.dart';

import '../custom_validations.dart';

enum FieldType { email, password }

class GEHCCustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final FieldType fieldType;
  final bool showError;
  final ValueChanged<String>? onChanged;

  const GEHCCustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.fieldType,
    required this.onChanged,
    this.showError = false,
  });

  @override
  State<GEHCCustomTextField> createState() {
    return _GEHCCustomTextFieldState();
  }
}

class _GEHCCustomTextFieldState extends State<GEHCCustomTextField> {
  bool _obscureText = true;
  String? _errorMessage;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _validateInput(String value) {
    if (widget.fieldType == FieldType.email) {
      return CustomValidations().emailValidation(value);
    } else if (widget.fieldType == FieldType.password) {
      return CustomValidations().passwordValidation(value);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: widget.key,
      controller: widget.controller,
      obscureText:
          widget.fieldType == FieldType.password ? _obscureText : false,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: widget.fieldType == FieldType.password
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _toggleVisibility,
              )
            : null,
        errorText: widget.showError ? _errorMessage : null,
        border: OutlineInputBorder(),
      ),
      keyboardType: widget.fieldType == FieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      onChanged: (value) {
        widget.onChanged!(value);
        setState(() {
          _errorMessage = _validateInput(value);
        });
      },
    );
  }
}

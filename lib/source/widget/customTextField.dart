import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String? hint, label, msgError;
  final TextEditingController? controller;
  final TextInputType? inputType;

  CustomFormField({
    super.key,
    this.inputType,
    this.hint,
    this.label,
    this.controller,
    this.msgError,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Color(0xFF0D4C92),
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        errorStyle: TextStyle(fontSize: 15),
        hintStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return msgError;
        }
        return null;
      },
    );
  }
}

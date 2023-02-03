import 'package:flutter/material.dart';

class CustomFormFieldRead extends StatelessWidget {
  final String? hint, label, msgError;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  
  CustomFormFieldRead({
    super.key,
    this.hint,
    this.label,
    this.controller,
    this.msgError,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      cursorColor: Color(0xFF0D4C92),
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
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

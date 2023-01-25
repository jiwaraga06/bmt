import 'package:flutter/material.dart';

class CustomButtonSave extends StatelessWidget {
  final VoidCallback? onPressed;
  const CustomButtonSave({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[600],
      ),
      child: Text(
        'SAVE',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}

// ===============================
// campo_input.dart
// ===============================

import 'package:flutter/material.dart';

class CampoInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? prefixo;
  final IconData icon;

  const CampoInput({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.prefixo,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefixo,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
// ===============================
// campo_dropdown.dart
// ===============================

import 'package:flutter/material.dart';

class CampoDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> itens;
  final IconData icon;
  final Function(String?) onChanged;

  const CampoDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.itens,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: itens.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
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
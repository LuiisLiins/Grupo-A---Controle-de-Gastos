// ===============================
// switch_parcelado.dart
// ===============================

import 'package:flutter/material.dart';

class SwitchParcelado extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const SwitchParcelado({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: const Text('Compra parcelada'),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
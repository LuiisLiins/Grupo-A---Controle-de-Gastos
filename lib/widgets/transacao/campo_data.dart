// ===============================
// campo_data.dart
// ===============================

import 'package:flutter/material.dart';

class CampoData extends StatelessWidget {
  final DateTime data;
  final VoidCallback onTap;

  const CampoData({
    super.key,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${data.day}/${data.month}/${data.year}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
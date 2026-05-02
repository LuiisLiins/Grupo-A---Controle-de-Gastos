import 'package:flutter/material.dart';

class SaldoCard extends StatelessWidget {
  const SaldoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(colors: [Color(0xff0f6fe8), Color(0xff4a9bff)]),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Saldo Atual', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 10),
          Text('R\$ 3.862,28', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Receitas: R\$ 4.500,00   Despesas: R\$ 637,72', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
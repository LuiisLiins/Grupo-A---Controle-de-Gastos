import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/transacao_provider.dart';
import '../../models/enums.dart';

class SaldoCard extends StatelessWidget {
  const SaldoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<TransacaoProvider>();
    
    final totalReceitas = prov.filtradas
        .where((t) => t.tipo == TipoTransacao.receita)
        .fold(0.0, (sum, t) => sum + t.valor);
        
    final totalDespesas = prov.filtradas
        .where((t) => t.tipo == TipoTransacao.despesa)
        .fold(0.0, (sum, t) => sum + t.valor);

    final saldo = totalReceitas - totalDespesas;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: saldo >= 0 
            ? [const Color(0xff0f6fe8), const Color(0xff4a9bff)]
            : [const Color(0xffe80f0f), const Color(0xffff4a4a)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Saldo Atual', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 10),
          Text(
            'R\$ ${saldo.toStringAsFixed(2)}', 
            style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 8),
          Text(
            'Receitas: R\$ ${totalReceitas.toStringAsFixed(2)}   Despesas: R\$ ${totalDespesas.toStringAsFixed(2)}', 
            style: const TextStyle(color: Colors.white, fontSize: 13)
          ),
        ],
      ),
    );
  }
}
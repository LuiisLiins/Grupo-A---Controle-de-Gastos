import 'package:flutter/material.dart';
import 'mov_item.dart';

class MovimentacoesCard extends StatelessWidget {
  const MovimentacoesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Align(alignment: Alignment.centerLeft, child: Text('Últimas movimentações', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            MovItem(
              icon: Icons.shopping_cart,
              titulo: 'Supermercado Silva',
              sub: '24/10 • Alimentação',
              valor: '- R\$ 142,50',
              cor: Colors.red,
            ),

            MovItem(
              icon: Icons.local_gas_station,
              titulo: 'Posto Ipiranga',
              sub: '24/10 • Transporte',
              valor: '- R\$ 250,00',
              cor: Colors.red,
            ),

            MovItem(
              icon: Icons.attach_money,
              titulo: 'Salário Mensal',
              sub: '23/10 • Renda',
              valor: '+ R\$ 4.500,00',
              cor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
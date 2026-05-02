import 'package:flutter/material.dart';
import '../widgets/home/saldo_card.dart';
import '../widgets/home/movimentacoes_card.dart';
import '../widgets/home/grafico_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final desktop = largura > 1100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Gastos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Olá, Luis 👋',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const SaldoCard(),

            const SizedBox(height: 20),

            desktop
                ? const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: MovimentacoesCard(),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: GraficoCard(),
                      ),
                    ],
                  )
                : const Column(
                    children: [
                      MovimentacoesCard(),
                      SizedBox(height: 16),
                      GraficoCard(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
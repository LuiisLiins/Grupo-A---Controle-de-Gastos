import 'package:flutter/material.dart';
import '../widgets/home/saldo_card.dart';
import '../widgets/home/movimentacoes_card.dart';
import '../widgets/home/grafico_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Gastos'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final largura = constraints.maxWidth;

          final isMobile = largura < 600;
          final isTablet = largura >= 600 && largura < 1100;
          final isDesktop = largura >= 1100;

          final paddingHorizontal = isDesktop
              ? largura * 0.15
              : isTablet
                  ? 32.0
                  : 16.0;

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              paddingHorizontal,
              20,
              paddingHorizontal,
              30,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Olá, Luis 👋',
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const SaldoCard(),

                    const SizedBox(height: 20),

                    if (isDesktop)
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: MovimentacoesCard()),
                          SizedBox(width: 16),
                          Expanded(child: GraficoCard()),
                        ],
                      )
                    else if (isTablet)
                      const Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: MovimentacoesCard()),
                              SizedBox(width: 16),
                              Expanded(child: GraficoCard()),
                            ],
                          ),
                        ],
                      )
                    else
                      const Column(
                        children: [
                          MovimentacoesCard(),
                          SizedBox(height: 16),
                          GraficoCard(),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
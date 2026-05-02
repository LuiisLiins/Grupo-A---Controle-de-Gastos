import 'package:flutter/material.dart';

class HistoricoPage extends StatelessWidget {
  const HistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final largura = constraints.maxWidth;
          final isTablet = largura >= 600;

          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 40 : 16,
                vertical: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: isTablet ? 80 : 60,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Histórico',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isTablet ? 28 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Aqui você verá suas movimentações',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isTablet ? 18 : 14,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: isTablet ? 300 : double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Carregar histórico'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
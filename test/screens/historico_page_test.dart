import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestaodegastos/historico_transacoes.dart';

void main() {
  testWidgets('renderiza resumo e lista de transações', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HistoricoPage(
          showBackButton: false,
          showBottomNavigationBar: false,
        ),
      ),
    );

    expect(find.text('Histórico'), findsOneWidget);
    expect(find.text('Pesquisar transações'), findsOneWidget);
    expect(find.text('Entradas'), findsOneWidget);
    expect(find.text('Saídas'), findsOneWidget);
    expect(find.text('Supermercado Silva'), findsOneWidget);
    expect(find.text('Salário Mensal'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestaodegastos/transacao.dart';

void main() {
  testWidgets('permite alternar o tipo de transação', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: TransacaoScreen()),
    );

    expect(find.text('Adicionar transação'), findsOneWidget);
    expect(find.text('Salvar despesa'), findsOneWidget);

    await tester.tap(find.text('Receita'));
    await tester.pumpAndSettle();

    expect(find.text('Salvar receita'), findsOneWidget);
    expect(find.text('Descrição'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestaodegastos/myhomepage.dart';

void main() {
  Finder quickActionCard(String label) => find.ancestor(
    of: find.text(label),
    matching: find.byType(InkWell),
  ).first;

  testWidgets('exibe atalhos da tela principal e dispara callbacks', (
    WidgetTester tester,
  ) async {
    var abriuHistorico = false;
    var abriuRelatorios = false;
    var abriuPerfil = false;
    var abriuTransacao = false;

    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(
          title: 'Página Inicial',
          onOpenHistorico: () => abriuHistorico = true,
          onOpenRelatorios: () => abriuRelatorios = true,
          onOpenPerfil: () => abriuPerfil = true,
          onAddTransaction: () => abriuTransacao = true,
        ),
      ),
    );

    expect(find.text('Controle financeiro'), findsOneWidget);
    expect(find.text('Ver histórico'), findsOneWidget);
    expect(find.text('Relatórios'), findsOneWidget);
    expect(find.text('Meu perfil'), findsOneWidget);
    expect(find.text('Nova transação'), findsOneWidget);

    await tester.ensureVisible(find.text('Ver histórico'));
    await tester.tap(quickActionCard('Ver histórico'));
    await tester.pumpAndSettle();
    expect(abriuHistorico, isTrue);

    await tester.ensureVisible(find.text('Relatórios'));
    await tester.tap(quickActionCard('Relatórios'));
    await tester.pumpAndSettle();
    expect(abriuRelatorios, isTrue);

    await tester.ensureVisible(find.text('Meu perfil'));
    await tester.tap(quickActionCard('Meu perfil'));
    await tester.pumpAndSettle();
    expect(abriuPerfil, isTrue);

    await tester.ensureVisible(find.text('Nova transação'));
    await tester.tap(quickActionCard('Nova transação'));
    await tester.pumpAndSettle();
    expect(abriuTransacao, isTrue);
  });
}

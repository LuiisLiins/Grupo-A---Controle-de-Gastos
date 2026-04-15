import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestaodegastos/models/usuario.dart';
import 'package:gestaodegastos/perfil.dart';

void main() {
  testWidgets('mostra os dados principais do usuário', (
    WidgetTester tester,
  ) async {
    final usuario = Usuario(
      id: 1,
      nome: 'Bruno Silva',
      email: 'bruno@email.com',
      telefone: '(11) 99999-9999',
      criadoEm: DateTime(2024, 1, 1),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: PerfilScreen(
          usuario: usuario,
          showBackButton: false,
          showBottomNavigationBar: false,
        ),
      ),
    );

    expect(find.text('Perfil'), findsOneWidget);
    expect(find.text('Bruno Silva'), findsOneWidget);
    expect(find.text('bruno@email.com'), findsOneWidget);
    expect(find.text('MEMBRO PREMIUM'), findsOneWidget);
    expect(find.text('Sair da Conta'), findsOneWidget);
  });
}

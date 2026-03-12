import 'package:flutter_test/flutter_test.dart';
import 'package:gestaodegastos/models/usuario.dart';

void main() {
  test('fromJson cria objeto Usuario corretamente', () {
    final json = {
      'id': 1,
      'nome': 'João',
      'email': 'joao@email.com',
      'telefone': '11999999999',
      'criado_em': '2026-03-05T12:00:00.000',
    };

    final usuario = Usuario.fromJson(json);

    expect(usuario.id, 1);
    expect(usuario.nome, 'João');
    expect(usuario.email, 'joao@email.com');
    expect(usuario.telefone, '11999999999');
    expect(usuario.criadoEm, DateTime.parse('2026-03-05T12:00:00.000'));
  });

  test('toJson produz JSON correto', () {
    final usuario = Usuario(
      id: 2,
      nome: 'Maria',
      email: 'maria@email.com',
      telefone: null,
      criadoEm: DateTime.parse('2026-03-06T08:30:00.000'),
    );

    final json = usuario.toJson();

    expect(json['id'], 2);
    expect(json['nome'], 'Maria');
    expect(json['email'], 'maria@email.com');
    expect(json['telefone'], null);
    expect(json['criado_em'], '2026-03-06T08:30:00.000');
  });

  test('copyWith modifica apenas os campos especificados', () {
    final usuario = Usuario(
      id: 3,
      nome: 'Carlos',
      email: 'carlos@email.com',
      telefone: '11888888888',
      criadoEm: DateTime.parse('2026-03-07T10:00:00.000'),
    );

    final novoUsuario = usuario.copyWith(nome: 'Carlos Silva');

    expect(novoUsuario.id, 3);
    expect(novoUsuario.nome, 'Carlos Silva');
    expect(novoUsuario.email, 'carlos@email.com');
    expect(novoUsuario.telefone, '11888888888');
    expect(novoUsuario.criadoEm, DateTime.parse('2026-03-07T10:00:00.000'));
  });
}
import 'package:flutter_test/flutter_test.dart';
import 'package:gestaodegastos/models/categoria.dart';

void main() {
  test('fromJson cria objeto corretamente', () {
    final json = {
      'id': 1,
      'nome': 'Alimentação',
      'usuario_id': 10,
    };

    final categoria = Categoria.fromJson(json);

    expect(categoria.id, 1);
    expect(categoria.nome, 'Alimentação');
    expect(categoria.usuarioId, 10);
  });

  test('toJson gera JSON correto', () {
    final categoria = Categoria(
      id: 1,
      nome: 'Alimentação',
      usuarioId: 10,
    );

    final json = categoria.toJson();

    expect(json['id'], 1);
    expect(json['nome'], 'Alimentação');
    expect(json['usuario_id'], 10);
  });

  test('copyWith altera apenas campos informados', () {
    final categoria = Categoria(
      id: 1,
      nome: 'Alimentação',
      usuarioId: 10,
    );

    final novaCategoria = categoria.copyWith(nome: 'Transporte');

    expect(novaCategoria.id, 1);
    expect(novaCategoria.nome, 'Transporte');
    expect(novaCategoria.usuarioId, 10);
  });
}
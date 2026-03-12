import 'package:flutter_test/flutter_test.dart';
import 'package:gestaodegastos/models/enums.dart';
import 'package:gestaodegastos/models/gasto.dart';

void main() {
  test('fromJson cria objeto corretamente', () {
    final json = {
      'id': 1,
      'descricao': 'Hamburguer',
      'valor': 30.0,
      'data': '2026-03-05T12:00:00.000',
      'categoria_id': 2,
      'usuario_id': 10,
      'tipo': 'despesa',
    };

    final gasto = Gasto.fromJson(json);

    expect(gasto.id, 1);
    expect(gasto.descricao, 'Hamburguer');
    expect(gasto.valor, 30.0);
    expect(gasto.categoriaId, 2);
    expect(gasto.usuarioId, 10);
    expect(gasto.tipo, TipoTransacao.despesa);
  });

  test('toJson gera JSON correto', () {
    final gasto = Gasto(
      id: 1,
      descricao: 'Uber',
      valor: 20.0,
      data: DateTime.parse('2026-03-05T12:00:00.000'),
      categoriaId: 2,
      usuarioId: 10,
      tipo: TipoTransacao.despesa,
    );

    final json = gasto.toJson();

    expect(json['id'], 1);
    expect(json['descricao'], 'Uber');
    expect(json['valor'], 20.0);
    expect(json['categoria_id'], 2);
    expect(json['usuario_id'], 10);
    expect(json['tipo'], 'despesa');
  });

  test('copyWith altera apenas campos informados', () {
    final gasto = Gasto(
      id: 1,
      descricao: 'Uber',
      valor: 20.0,
      data: DateTime.parse('2026-03-05T12:00:00.000'),
      categoriaId: 2,
      usuarioId: 10,
      tipo: TipoTransacao.despesa,
    );

    final novoGasto = gasto.copyWith(valor: 35.0);

    expect(novoGasto.valor, 35.0);
    expect(novoGasto.descricao, 'Uber');
    expect(novoGasto.categoriaId, 2);
  });
}
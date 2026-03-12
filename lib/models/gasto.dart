import 'enums.dart';

class Gasto {
  final int id;
  final String descricao;
  final double valor;
  final DateTime data;
  final int categoriaId;
  final int usuarioId;
  final TipoTransacao tipo;

  const Gasto({
    required this.id,
    required this.descricao,
    required this.valor,
    required this.data,
    required this.categoriaId,
    required this.usuarioId,
    required this.tipo,
  });

  factory Gasto.fromJson(Map<String, dynamic> json) {
    return Gasto(
      id: json['id'] as int,
      descricao: json['descricao'] as String,
      valor: (json['valor'] as num).toDouble(),
      data: DateTime.parse(json['data'] as String),
      categoriaId: json['categoria_id'] as int,
      usuarioId: json['usuario_id'] as int,
      tipo: TipoTransacao.values.firstWhere(
        (e) => e.name == json['tipo'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'valor': valor,
      'data': data.toIso8601String(),
      'categoria_id': categoriaId,
      'usuario_id': usuarioId,
      'tipo': tipo.name,
    };
  }

  Gasto copyWith({
    int? id,
    String? descricao,
    double? valor,
    DateTime? data,
    int? categoriaId,
    int? usuarioId,
    TipoTransacao? tipo,
  }) {
    return Gasto(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
      data: data ?? this.data,
      categoriaId: categoriaId ?? this.categoriaId,
      usuarioId: usuarioId ?? this.usuarioId,
      tipo: tipo ?? this.tipo,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Gasto &&
        other.id == id &&
        other.descricao == descricao &&
        other.valor == valor &&
        other.data == data &&
        other.categoriaId == categoriaId &&
        other.usuarioId == usuarioId &&
        other.tipo == tipo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        descricao.hashCode ^
        valor.hashCode ^
        data.hashCode ^
        categoriaId.hashCode ^
        usuarioId.hashCode ^
        tipo.hashCode;
  }
}
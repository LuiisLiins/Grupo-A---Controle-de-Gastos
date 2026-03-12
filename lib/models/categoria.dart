class Categoria {
  final int id;
  final String nome;
  final int usuarioId;

  const Categoria({
    required this.id,
    required this.nome,
    required this.usuarioId,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'] as int,
      nome: json['nome'] as String,
      usuarioId: json['usuario_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'usuario_id': usuarioId,
    };
  }

  Categoria copyWith({
    int? id,
    String? nome,
    int? usuarioId,
  }) {
    return Categoria(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Categoria &&
          id == other.id &&
          nome == other.nome &&
          usuarioId == other.usuarioId;

  @override
  int get hashCode => id.hashCode ^ nome.hashCode ^ usuarioId.hashCode;
}
class Usuario {
  final int id;
  final String nome;
  final String email;
  final String? telefone;
  final DateTime criadoEm;

  const Usuario({
    required this.id,
    required this.nome,
    required this.email,
    this.telefone,
    required this.criadoEm,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      nome: json['nome'] as String,
      email: json['email'] as String,
      telefone: json['telefone'] as String?,
      criadoEm: DateTime.parse(json['criado_em'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'criado_em': criadoEm.toIso8601String(),
    };
  }

  Usuario copyWith({
    int? id,
    String? nome,
    String? email,
    String? telefone,
    DateTime? criadoEm,
  }) {
    return Usuario(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Usuario &&
        other.id == id &&
        other.nome == nome &&
        other.email == email &&
        other.telefone == telefone &&
        other.criadoEm == criadoEm;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        email.hashCode ^
        telefone.hashCode ^
        criadoEm.hashCode;
  }

  @override
  String toString() {
    return 'Usuario(id: $id, nome: $nome, email: $email, telefone: $telefone, criadoEm: $criadoEm)';
  }
}
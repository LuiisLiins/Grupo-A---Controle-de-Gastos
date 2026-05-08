class Validadores {
  Validadores._();

  static String? obrigatorio(
    String? valor, {
    String campo = 'Este campo',
  }) {
    if (valor == null || valor.trim().isEmpty) {
      return '$campo é obrigatório';
    }

    return null;
  }

  static String? nomeCompleto(String? valor) {
    final obrigatorioErro =
        obrigatorio(valor, campo: 'O nome');

    if (obrigatorioErro != null) {
      return obrigatorioErro;
    }

    final partes = valor!
        .trim()
        .split(' ')
        .where((p) => p.isNotEmpty)
        .toList();

    if (partes.length < 2) {
      return 'Informe nome e sobrenome';
    }

    return null;
  }

  static String? email(String? valor) {
    final obrigatorioErro =
        obrigatorio(valor, campo: 'O e-mail');

    if (obrigatorioErro != null) {
      return obrigatorioErro;
    }

    final regex = RegExp(
      r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
    );

    if (!regex.hasMatch(valor!.trim())) {
      return 'Informe um e-mail válido';
    }

    return null;
  }

  static String? senha(String? valor) {
    final obrigatorioErro =
        obrigatorio(valor, campo: 'A senha');

    if (obrigatorioErro != null) {
      return obrigatorioErro;
    }

    if (valor!.length < 6) {
      return 'A senha deve ter no mínimo 6 caracteres';
    }

    return null;
  }

  static String? Function(String?) confirmarSenha(
    String senhaOriginal,
  ) {
    return (String? valor) {
      final obrigatorioErro = obrigatorio(
        valor,
        campo: 'A confirmação de senha',
      );

      if (obrigatorioErro != null) {
        return obrigatorioErro;
      }

      if (valor != senhaOriginal) {
        return 'As senhas não coincidem';
      }

      return null;
    };
  }
}
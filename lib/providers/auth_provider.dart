import 'package:flutter/material.dart';
import '../models/usuario.dart';

class AuthProvider extends ChangeNotifier {
  Usuario? _usuario;
  bool _estaLogado = false;

  final String _emailCorreto = "luis@gmail.com";
  final String _senhaCorreta = "123456";

  Usuario? get usuario => _usuario;
  bool get estaLogado => _estaLogado;

  Future<void> login(String email, String senha) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (email == _emailCorreto && senha == _senhaCorreta) {
      _usuario = Usuario(
        id: 1, 
        nome: "Luis Lins", 
        email: _emailCorreto, 
        criadoEm: DateTime.now()
      );
      _estaLogado = true;
      notifyListeners();
    } else {
      throw Exception('Credenciais inválidas');
    }
  }

  void logout() {
    _usuario = null;
    _estaLogado = false;
    notifyListeners();
  }
}
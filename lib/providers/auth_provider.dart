import 'package:flutter/material.dart';
import '../models/usuario.dart';

class AuthProvider extends ChangeNotifier {
  Usuario? _usuario;
  bool _estaLogado = false;

  Usuario? get usuario => _usuario;
  bool get estaLogado => _estaLogado;

  // Simula o login
  Future<void> login(String email, String senha) async {
    // Aqui entraria a chamada para API futuramente
    await Future.delayed(const Duration(seconds: 1));
    
    _usuario = Usuario(
      id: 1, 
      nome: "Luis Lins", 
      email: email, 
      criadoEm: DateTime.now()
    );
    _estaLogado = true;
    
    notifyListeners(); // Isso avisa os widgets para reconstruírem
  }

  void logout() {
    _usuario = null;
    _estaLogado = false;
    notifyListeners();
  }
}
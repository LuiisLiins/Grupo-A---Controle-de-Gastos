import 'package:flutter/material.dart';

class ConfigProvider extends ChangeNotifier {
  bool _isDark = false;
  bool _pinAtivo = true;
  bool _biometriaAtiva = true;

  bool get isDark => _isDark;
  bool get pinAtivo => _pinAtivo;
  bool get biometriaAtiva => _biometriaAtiva;

  void toggleTema() {
    _isDark = !_isDark;
    notifyListeners();
  }

  void togglePin(bool valor) {
    _pinAtivo = valor;
    notifyListeners();
  }

  void toggleBiometria(bool valor) {
    _biometriaAtiva = valor;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import '../models/gasto.dart';
import '../models/enums.dart';

class TransacaoProvider extends ChangeNotifier {
  List<Gasto> _transacoes = [];
  
  String _busca = "";
  String _tipoSelecionado = "Todos";
  String _categoriaSelecionada = "Todos";
  DateTime _dataInicio = DateTime.now().subtract(const Duration(days: 90));
  DateTime _dataFim = DateTime.now();
  String _ordenarPor = "data";
  bool _ordemCrescente = false;

  String get busca => _busca;
  String get tipoSelecionado => _tipoSelecionado;
  String get categoriaSelecionada => _categoriaSelecionada;
  DateTime get dataInicio => _dataInicio;
  DateTime get dataFim => _dataFim;
  String get ordenarPor => _ordenarPor;
  bool get ordemCrescente => _ordemCrescente;

  List<Gasto> get filtradas {
    List<Gasto> lista = _transacoes.where((t) {
      final bateData = t.data.isAfter(_dataInicio.subtract(const Duration(days: 1))) && 
                       t.data.isBefore(_dataFim.add(const Duration(days: 1)));
      
      final bateTipo = _tipoSelecionado == "Todos" || 
                       (t.tipo == (_tipoSelecionado == "Receita" ? TipoTransacao.receita : TipoTransacao.despesa));
      
      final bateBusca = t.descricao.toLowerCase().contains(_busca.toLowerCase());
      
      return bateData && bateTipo && bateBusca;
    }).toList();

    if (_ordenarPor == "data") {
      lista.sort((a, b) => _ordemCrescente ? a.data.compareTo(b.data) : b.data.compareTo(a.data));
    } else {
      lista.sort((a, b) => _ordemCrescente ? a.valor.compareTo(b.valor) : b.valor.compareTo(a.valor));
    }

    return lista;
  }

  Map<String, List<Gasto>> get agrupadasPorData {
    final agrupado = <String, List<Gasto>>{};
    for (var t in filtradas) {
      final dia = DateTime(t.data.year, t.data.month, t.data.day);
      final hoje = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      final ontem = hoje.subtract(const Duration(days: 1));

      String chave;
      if (dia == hoje) {
        chave = "Hoje";
      // ignore: curly_braces_in_flow_control_structures
      } else if (dia == ontem) chave = "Ontem";
      // ignore: curly_braces_in_flow_control_structures
      else chave = "${dia.day.toString().padLeft(2, '0')}/${dia.month.toString().padLeft(2, '0')}/${dia.year}";

      agrupado.putIfAbsent(chave, () => []);
      agrupado[chave]!.add(t);
    }
    return agrupado;
  }

  void configurarFiltros({String? busca, String? tipo, String? categoria, DateTime? inicio, DateTime? fim, String? ordem, bool? crescente}) {
    if (busca != null) _busca = busca;
    if (tipo != null) _tipoSelecionado = tipo;
    if (categoria != null) _categoriaSelecionada = categoria;
    if (inicio != null) _dataInicio = inicio;
    if (fim != null) _dataFim = fim;
    if (ordem != null) _ordenarPor = ordem;
    if (crescente != null) _ordemCrescente = crescente;
    notifyListeners();
  }

  void adicionarTransacao(Gasto gasto) {
    _transacoes.add(gasto);
    notifyListeners();
  }

  void removerTransacao(int id) {
    _transacoes.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void carregarMocks(List<Gasto> mocks) {
    _transacoes = mocks;
    notifyListeners();
  }
}
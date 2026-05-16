import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/transacao_provider.dart';
import '../../models/enums.dart';
import 'mov_item.dart';

class MovimentacoesCard extends StatelessWidget {
  const MovimentacoesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final transacoes = context.watch<TransacaoProvider>().filtradas;
    final recentes = transacoes.take(5).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft, 
              child: Text('Últimas movimentações', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
            ),
            if (recentes.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Text('Nenhuma movimentação encontrada.', style: TextStyle(color: Colors.grey)),
              )
            else
              ...recentes.map((t) {
                final isReceita = t.tipo == TipoTransacao.receita;
                return MovItem(
                  icon: isReceita ? Icons.attach_money : Icons.shopping_cart,
                  titulo: t.descricao,
                  sub: '${t.data.day}/${t.data.month} • Categoria ${t.categoriaId}',
                  valor: '${isReceita ? '+' : '-'} R\$ ${t.valor.toStringAsFixed(2)}',
                  cor: isReceita ? Colors.green : Colors.red,
                );
              }),
          ],
        ),
      ),
    );
  }
}
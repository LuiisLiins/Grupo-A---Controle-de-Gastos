import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/transacao/tipo_selector.dart';
import '../widgets/transacao/campo_input.dart';
import '../widgets/transacao/botao_salvar.dart';
import '../widgets/transacao/campo_dropdown.dart';
import '../widgets/transacao/campo_data.dart';
import '../widgets/transacao/switch_parcelado.dart';

class NovaTransacaoPage extends StatefulWidget {
  const NovaTransacaoPage({super.key});

  @override
  State<NovaTransacaoPage> createState() => _NovaTransacaoPageState();
}

class _NovaTransacaoPageState extends State<NovaTransacaoPage> {
  final descricaoController = TextEditingController();
  final valorController = TextEditingController();

  String tipo = 'Despesa';
  String categoria = 'Alimentação';
  String pagamento = 'Pix';
  bool parcelado = false;

  DateTime data = DateTime.now();

  final categoriasDespesa = [
    'Alimentação',
    'Transporte',
    'Moradia',
    'Lazer',
    'Saúde',
  ];

  final categoriasReceita = [
    'Salário',
    'Freelance',
    'Extra',
    'Investimento',
  ];

  final pagamentos = [
    'Pix',
    'Cartão',
    'Dinheiro',
    'Boleto',
  ];

  @override
  Widget build(BuildContext context) {
    final cor = tipo == 'Receita'
        ? const Color(0xFF34C759)
        : const Color(0xFFFF3B30);

    final categoriasAtuais =
        tipo == 'Receita'
            ? categoriasReceita
            : categoriasDespesa;

    if (!categoriasAtuais.contains(categoria)) {
      categoria = categoriasAtuais.first;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text('Nova Transação'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F7FB),
        elevation: 0,
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final largura = constraints.maxWidth;

          final isTablet =
              largura >= 600 && largura < 1100;
          final isDesktop = largura >= 1100;

          final paddingHorizontal = isDesktop
              ? largura * 0.25
              : isTablet
                  ? 60.0
                  : 16.0;

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              paddingHorizontal,
              20,
              paddingHorizontal,
              30,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 520),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          0.04,
                        ),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      TipoSelector(
                        tipoAtual: tipo,
                        onChanged: (value) {
                          setState(() {
                            tipo = value;

                            categoria =
                                value == 'Receita'
                                    ? categoriasReceita
                                        .first
                                    : categoriasDespesa
                                        .first;
                          });
                        },
                      ),

                      const SizedBox(height: 28),

                      const Text(
                        'Informações',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 18),

                      CampoInput(
                        controller:
                            valorController,
                        label: 'Valor',
                        prefixo: 'R\$ ',
                        icon: Icons.attach_money,
                      ),

                      const SizedBox(height: 16),

                      CampoInput(
                        controller:
                            descricaoController,
                        label:
                            tipo == 'Receita'
                                ? 'Origem'
                                : 'Descrição',
                        icon: Icons.edit_note,
                      ),

                      const SizedBox(height: 16),

                      CampoDropdown(
                        label: 'Categoria',
                        value: categoria,
                        itens: categoriasAtuais,
                        icon: Icons.category,
                        onChanged: (v) {
                          setState(() {
                            categoria = v!;
                          });
                        },
                      ),

                      const SizedBox(height: 16),

                      if (tipo == 'Despesa') ...[
                        CampoDropdown(
                          label: 'Pagamento',
                          value: pagamento,
                          itens: pagamentos,
                          icon:
                              Icons.credit_card,
                          onChanged: (v) {
                            setState(() {
                              pagamento = v!;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        SwitchParcelado(
                          value: parcelado,
                          onChanged: (v) {
                            setState(() {
                              parcelado = v;
                            });
                          },
                        ),

                        const SizedBox(height: 16),
                      ],

                      CampoData(
                        data: data,
                        onTap: () async {
                          final nova =
                              await showDatePicker(
                            context: context,
                            initialDate: data,
                            firstDate:
                                DateTime(2020),
                            lastDate:
                                DateTime(2035),
                          );

                          if (nova != null) {
                            setState(() {
                              data = nova;
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 28),

                      BotaoSalvar(
                        texto:
                            tipo == 'Receita'
                                ? 'Salvar Receita'
                                : 'Salvar Despesa',
                        cor: cor,
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/validadores.dart';
import '../widgets/auth/cadastro_button.dart';
import '../widgets/auth/cadastro_textfield.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  final _emailFocus = FocusNode();
  final _senhaFocus = FocusNode();
  final _confirmarSenhaFocus = FocusNode();

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    _emailFocus.dispose();
    _senhaFocus.dispose();
    _confirmarSenhaFocus.dispose();
    super.dispose();
  }

  Future<void> cadastrar() async {
    final formularioValido = _formKey.currentState!.validate();

    if (!formularioValido) {
      return;
    }

    try {
      await context.read<AuthProvider>().login(
        emailController.text.trim(),
        senhaController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cadastro de ${nomeController.text} realizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao realizar cadastro.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              width: 390,
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.person_add_alt_rounded,
                      size: 62,
                      color: Color(0xFF007AFF),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Criar Conta',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Cadastre-se para continuar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          CadastroTextField(
                            controller: nomeController,
                            hint: 'Nome completo',
                            icon: Icons.person_outline,
                            validator: Validadores.nomeCompleto,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_emailFocus);
                            },
                          ),
                          const Divider(height: 1),
                          CadastroTextField(
                            controller: emailController,
                            focusNode: _emailFocus,
                            hint: 'E-mail',
                            icon: Icons.mail_outline,
                            validator: Validadores.email,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_senhaFocus);
                            },
                          ),
                          const Divider(height: 1),
                          CadastroTextField(
                            controller: senhaController,
                            focusNode: _senhaFocus,
                            hint: 'Senha',
                            icon: Icons.lock_outline,
                            obscure: true,
                            validator: Validadores.senha,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_confirmarSenhaFocus);
                            },
                          ),
                          const Divider(height: 1),
                          CadastroTextField(
                            controller: confirmarSenhaController,
                            focusNode: _confirmarSenhaFocus,
                            hint: 'Confirmar senha',
                            icon: Icons.lock_outline,
                            obscure: true,
                            validator: Validadores.confirmarSenha(senhaController.text),
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => cadastrar(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: CadastroButton(
                        texto: 'Cadastrar',
                        onPressed: cadastrar,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
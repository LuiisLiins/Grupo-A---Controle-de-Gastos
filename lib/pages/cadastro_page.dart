import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
  }

  void cadastrar() {
    final valido = _formKey.currentState!.validate();

    if (!valido) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cadastro realizado com sucesso!'),
      ),
    );

    context.go('/login');
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
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Informe seu nome';
                              }

                              if (value.trim().length < 3) {
                                return 'Nome muito curto';
                              }

                              return null;
                            },
                          ),

                          const Divider(height: 1),

                          CadastroTextField(
                            controller: emailController,
                            hint: 'E-mail',
                            icon: Icons.mail_outline,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Informe seu e-mail';
                              }

                              final emailRegex =
                                  RegExp(r'^[^@]+@[^@]+\.[^@]+$');

                              if (!emailRegex.hasMatch(value.trim())) {
                                return 'E-mail inválido';
                              }

                              return null;
                            },
                          ),

                          const Divider(height: 1),

                          CadastroTextField(
                            controller: senhaController,
                            hint: 'Senha',
                            icon: Icons.lock_outline,
                            obscure: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Informe a senha';
                              }

                              if (value.length < 6) {
                                return 'Mínimo 6 caracteres';
                              }

                              return null;
                            },
                          ),

                          const Divider(height: 1),

                          CadastroTextField(
                            controller: confirmarSenhaController,
                            hint: 'Confirmar senha',
                            icon: Icons.lock_outline,
                            obscure: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirme sua senha';
                              }

                              if (value != senhaController.text) {
                                return 'As senhas não coincidem';
                              }

                              return null;
                            },
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

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Já possui conta? ',
                          style: TextStyle(
                            color: Color(0xFF8E8E93),
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.go('/login');
                          },
                          child: const Text(
                            'Entrar',
                            style: TextStyle(
                              color: Color(0xFF007AFF),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
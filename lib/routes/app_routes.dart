import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../layouts/app_layout.dart';
import '../pages/home_page.dart';
import '../pages/historico_page.dart';
import '../pages/relatorios_page.dart';
import '../pages/perfil_page.dart';
import '../pages/nova_transacao_page.dart';
import '../pages/login_page.dart';
import '../pages/cadastro_page.dart';

class AuthService extends ChangeNotifier {
  bool _logado = false;

  bool get logado => _logado;

  void login() {
    _logado = true;
    notifyListeners();
  }

  void logout() {
    _logado = false;
    notifyListeners();
  }
}

final authService = AuthService();

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    refreshListenable: authService,

    redirect: (context, state) {
      final logado = authService.logado;
      final indoLogin = state.matchedLocation == '/login';
      final indoCadastro = state.matchedLocation == '/cadastro';


      final rotaPublica = indoLogin || indoCadastro;

      if (!logado && !rotaPublica) {
        return '/login';
      }

      if (logado && rotaPublica) {
        return '/';
      }

      return null;
    },

    errorBuilder: (context, state) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7FB),
        appBar: AppBar(
          title: const Text('Página não encontrada'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 70,
                  color: Colors.grey,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Oops!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'A página "${state.uri}" não foi encontrada.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: 220,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => context.go('/'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F6FE8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Voltar ao início',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },

    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),

      GoRoute(
        path: '/cadastro',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CadastroPage(),
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppLayout(
            navigationShell: navigationShell,
            body: navigationShell,
          );
        },

        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const HomePage(),
                  transitionDuration:
                      const Duration(milliseconds: 300),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/historico',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const HistoricoPage(),
                  transitionDuration:
                      const Duration(milliseconds: 300),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/relatorios',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const RelatoriosPage(),
                  transitionDuration:
                      const Duration(milliseconds: 300),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/perfil',
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const PerfilPage(),
                  transitionDuration:
                      const Duration(milliseconds: 300),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: '/nova-transacao',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const NovaTransacaoPage(),
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            final offset = Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ),
            );

            return SlideTransition(
              position: offset,
              child: child,
            );
          },
        ),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/locator.dart';
import 'providers/auth_provider.dart';
import 'providers/transacao_provider.dart';
import 'providers/config_provider.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<TransacaoProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<ConfigProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = context.watch<ConfigProvider>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Gestão de Gastos',
      themeMode: config.isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      routerConfig: AppRouter.router,
    );
  }
}
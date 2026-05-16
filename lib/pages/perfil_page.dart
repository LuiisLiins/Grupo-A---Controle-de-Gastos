import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/config_provider.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuta as mudanças nas configurações e nos dados do usuário
    final config = context.watch<ConfigProvider>();
    final auth = context.watch<AuthProvider>();

    final isDark = config.isDark;
    final theme = Theme.of(context);
    final textStyle = TextStyle(color: isDark ? Colors.white : Colors.black);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue.shade100,
                  child: const CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=3',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  auth.usuario?.nome ?? 'Usuário',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(auth.usuario?.email ?? 'email@exemplo.com'),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'MEMBRO PREMIUM',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const ListTile(
                    leading: Icon(Icons.flag),
                    title: Text('Meta Financeira'),
                    subtitle: Text('R\$ 10.000,00'),
                    trailing: Icon(Icons.edit),
                  ),
                ),
                const SizedBox(height: 20),
                _title('CONFIGURAÇÕES'),
                Card(
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(Icons.lock),
                        title: Text('Alterar senha'),
                      ),
                      SwitchListTile(
                        value: config.pinAtivo,
                        onChanged: (v) => config.togglePin(v),
                        title: const Text('Segurança por PIN'),
                      ),
                      SwitchListTile(
                        value: config.biometriaAtiva,
                        onChanged: (v) => config.toggleBiometria(v),
                        title: const Text('Biometria'),
                      ),
                      SwitchListTile(
                        value: config.isDark,
                        onChanged: (v) => config.toggleTema(),
                        title: const Text('Tema escuro'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _title('PREFERÊNCIAS'),
                Card(
                  child: Column(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.language),
                        title: Text('Idioma'),
                        subtitle: Text('Português'),
                      ),
                      ListTile(
                        leading: Icon(Icons.attach_money),
                        title: Text('Moeda padrão'),
                        subtitle: Text('BRL (R\$)'),
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications),
                        title: Text('Notificações'),
                      ),
                      ListTile(
                        leading: Icon(Icons.backup),
                        title: Text('Backup (em breve)'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _title('ESTATÍSTICAS'),
                Card(
                  child: Column(
                    children: const [
                      ListTile(
                        title: Text('Total de transações'),
                        trailing: Text('120'),
                      ),
                      ListTile(
                        title: Text('Economia anual'),
                        trailing: Text('R\$ 5.000'),
                      ),
                      ListTile(
                        title: Text('Sequência de uso'),
                        trailing: Text('15 dias'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Sair da conta',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  onTap: () => auth.logout(),
                ),
                const SizedBox(height: 20),
                const Text(
                  'VERSÃO 2.0.0',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
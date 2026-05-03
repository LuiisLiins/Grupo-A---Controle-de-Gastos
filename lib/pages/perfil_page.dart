import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  bool isDark = false;
  bool pin = true;
  bool biometria = true;

  void _logout() {
    authService.logout();
  }

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFF5F7FB);
    final text = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        backgroundColor: bg,
        elevation: 0,
        foregroundColor: text,
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
                  'Luis Lins',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: text,
                  ),
                ),

                const Text('luis@email.com'),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('MEMBRO PREMIUM'),
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
                        value: pin,
                        onChanged: (v) => setState(() => pin = v),
                        title: const Text('Segurança por PIN'),
                      ),
                      SwitchListTile(
                        value: biometria,
                        onChanged: (v) => setState(() => biometria = v),
                        title: const Text('Biometria'),
                      ),
                      SwitchListTile(
                        value: isDark,
                        onChanged: (v) => setState(() => isDark = v),
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
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: _logout,
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
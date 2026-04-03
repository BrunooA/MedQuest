import 'package:flutter/material.dart';
import 'fluxo_cadastro_screen.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  static const Color colorBlue = Color(0xFF3498DB);
  static const Color colorGreen = Color(0xFF2ECC71);
  static const Color colorBg = Color(0xFFF5F7FB);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mostrarAlertaCompletarPerfil();
    });
  }

  void _mostrarAlertaCompletarPerfil() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/3064/3064197.png', 
              height: 80
            ),
            const SizedBox(height: 20),
            const Text(
              "Vamos completar seu perfil rapidinho?",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: colorGreen),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const FluxoCadastroScreen())
              );
            },
            child: const Text("Começar", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar", style: TextStyle(color: colorGreen)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: colorBlue),
                  child: const SafeArea(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: BackButton(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFC0CB), 
                      shape: BoxShape.circle
                    ),
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      // --- CAMINHO CORRIGIDO ---
                      backgroundImage: AssetImage('assets/images/foto.jpg'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            const Text("Bruno Silva", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("bruno@teste.com", style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: _actionButton(Icons.chat_bubble_outline, "Chat", '/chat')),
                  const SizedBox(width: 10),
                  Expanded(child: _actionButton(Icons.videocam_outlined, "Consulta", '/video_call')),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _infoCard("Informações pessoais", isGov: true, dados: {
                    "Nome": "Bruno Silva",
                    "Gênero": "Masculino",
                    "Data de Nascimento": "10/05/1995",
                  }),
                  const SizedBox(height: 15),
                  _infoCard("Saúde", isGov: false, dados: {
                    "Peso": "80kg",
                    "Altura": "1.80m",
                  }),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 180,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: colorGreen),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const FluxoCadastroScreen())
                        );
                      },
                      child: const Text("Editar Perfil", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, String rota) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorGreen,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () => Navigator.pushNamed(context, rota),
      icon: Icon(icon, color: Colors.white, size: 18),
      label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Widget _infoCard(String title, {required bool isGov, required Map<String, String> dados}) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              if (isGov) const Icon(Icons.lock_outline, size: 16, color: Colors.orange),
            ],
          ),
          const Divider(height: 25),
          ...dados.entries.map((e) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(e.value, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 8),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}
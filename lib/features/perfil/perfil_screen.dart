import 'package:flutter/material.dart';
import 'user_controller.dart';
import 'fluxo_cadastro_screen.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Cinza Fundo Figma
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  _botoesAcaoTop(),
                  const SizedBox(height: 25),
                  _cardInformacoesCompleto(),
                  const SizedBox(height: 30),
                  _botaoEditarPerfil(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 160,
          width: double.infinity,
          color: const Color(0xFF3498DB), // Azul Figma
          child: const Padding(
            padding: EdgeInsets.only(left: 20, top: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          top: 80,
          child: Column(
            children: [
              // CORREÇÃO AQUI: Borda rosa definida diretamente para evitar o erro de 'null'
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFFC0CB), width: 4), 
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: const CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('assets/images/foto.jpg'),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                userController.nome,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                userController.email,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 250), 
      ],
    );
  }

  Widget _botoesAcaoTop() {
    return Row(
      children: [
        Expanded(child: _actionButton(Icons.chat_bubble, "Chat com médico")),
        const SizedBox(width: 12),
        Expanded(child: _actionButton(Icons.videocam, "Iniciar consulta")),
      ],
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white, size: 18),
      label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2ECC71), // Verde Figma
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    );
  }

  Widget _cardInformacoesCompleto() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(Icons.assignment_ind_outlined, "Informações pessoais"),
          const Divider(height: 30),
          _infoItem("Nome", userController.nome),
          _infoItem("Gênero", userController.genero),
          _infoItem("Data de Nascimento", userController.nascimento),
          const SizedBox(height: 25),
          _sectionHeader(Icons.monitor_heart_outlined, "Saúde"),
          const Divider(height: 30),
          _infoItem("Peso", userController.peso.isEmpty ? "-" : "${userController.peso} kg"),
          _infoItem("Altura", userController.altura.isEmpty ? "-" : "${userController.altura} m"),
        ],
      ),
    );
  }

  Widget _sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _infoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _botaoEditarPerfil() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (c) => const FluxoCadastroScreen()));
          setState(() {});
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2ECC71),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(15),
        ),
        child: const Text("Editar Perfil", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
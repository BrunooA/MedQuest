import 'package:flutter/material.dart';
import 'user_controller.dart';
import '../chat/chat_screen.dart';
import '../chat/video_call_screen.dart';
import 'fluxo_cadastro_screen.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  // Constante para a altura do header azul, facilitando o cálculo da sobreposição
  static const double _headerHeight = 160.0;
  // O quanto o conteúdo branco sobe para sobrepor o header azul
  static const double _overlapAmount = 32.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3498DB), // Azul Header Figma
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // 🟦 1. O HEADER AZUL (Sem Stack interno)
            _headerAzul(),

            // ⚪ 2. O CONTEÚDO BRANCO (Sobe e arredonda no topo)
            Padding(
              padding: const EdgeInsets.only(
                top: _headerHeight - _overlapAmount,
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F9FA), // Cinza Fundo Figma
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_overlapAmount),
                    topRight: Radius.circular(_overlapAmount),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Espaço exato para que os textos fiquem centralizados abaixo da imagem
                      const SizedBox(height: (_overlapAmount * 2) + 20),

                      // 👤 Nome e Email (Centralizados)
                      _infoTopCentralizada(),

                      const SizedBox(height: 25),

                      // 🟢 Botões de Ação (Maiores e centralizados)
                      _botoesAcaoTop(),

                      const SizedBox(height: 25),

                      // 📑 Card de Informações
                      _cardInformacoesCompleto(),

                      const SizedBox(height: 30),

                      // 🛠️ Botão Editar Perfil
                      _botaoEditarPerfil(),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),

            // 👤 3. A IMAGEM DE PERFIL (Em cima de tudo)
            Positioned(
              // Calculado para que a metade inferior da imagem fique no conteúdo branco
              top: (_headerHeight - _overlapAmount) - 55.0,
              child: _imagemPerfilComBorda(),
            ),
          ],
        ),
      ),
    );
  }

  // Apenas o bloco azul com o ícone de voltar
  Widget _headerAzul() {
    return Container(
      height: _headerHeight,
      width: double.infinity,
      color: const Color(0xFF3498DB),
      child: const Padding(
        padding: EdgeInsets.only(left: 20, top: 40),
        child: Align(
          alignment: Alignment.topLeft,
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
    );
  }

  // A imagem com a borda rosa, separada para organização
  Widget _imagemPerfilComBorda() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFFFC0CB), width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const CircleAvatar(
        radius: 55,
        backgroundColor: Colors.grey,
        backgroundImage: AssetImage('assets/images/foto.jpg'),
      ),
    );
  }

  // Nome e Email centralizados
  Widget _infoTopCentralizada() {
    return Column(
      children: [
        Text(
          userController.nome,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          userController.email,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }

  Widget _botoesAcaoTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _actionButton(
            Icons.chat_bubble,
            "Chat com médico",
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _actionButton(
            Icons.videocam,
            "Iniciar consulta",
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VideoCallScreen()),
            ),
          ),
        ),
      ],
    );
  }

  // Atualizei o _actionButton para receber a função de clique (onTap)
  Widget _actionButton(IconData icon, String label, VoidCallback onTap) {
    return SizedBox(
      height: 55,
      child: FilledButton.icon(
        onPressed: onTap, // Agora ele executa a navegação
        icon: Icon(icon, color: Colors.white, size: 20),
        label: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF2ECC71),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
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
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15),
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
          _infoItem(
            "Peso",
            userController.peso.isEmpty ? "-" : "${userController.peso} kg",
          ),
          _infoItem(
            "Altura",
            userController.altura.isEmpty ? "-" : "${userController.altura} m",
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
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
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _botaoEditarPerfil() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: FilledButton(
        onPressed: () async {
          // Navega para o fluxo de cadastro/edição
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FluxoCadastroScreen(),
            ),
          );

          // Quando o usuário terminar de editar e voltar (pop),
          // o setState força a tela a redesenhar com os novos dados do userController
          setState(() {});
        },
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFF2ECC71), // Verde Figma
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Editar Perfil",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../consultas/widgets/consultas_exames_screen.dart';
import '../chat/chat_screen.dart';
import '../perfil/perfil_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _mudarPagina(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Definimos as páginas que serão exibidas em cada aba
    final List<Widget> _pages = [
      HomeContent(onAgendarClick: () => _mudarPagina(1)), // Conteúdo da Home
      const ConsultasExamesScreen(), // Tela de Exames
      ChatScreen(onBackToHome: () => _mudarPagina(0)), // Tela de Chat
      const PerfilScreen(), // Tela de Perfil
    ];

    return Scaffold(
      body: IndexedStack(
        // IndexedStack mantém o estado das páginas ao trocar de aba
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _mudarPagina,
        type: BottomNavigationBarType
            .fixed, // Mantém os itens fixos (sem animação de shift)
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            activeIcon: Icon(Icons.description),
            label: 'Exames',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

// --- CONTEÚDO DA HOME ---
class HomeContent extends StatefulWidget {
  final VoidCallback onAgendarClick; // Callback para agendar consulta
  const HomeContent({super.key, required this.onAgendarClick});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool showMedicamentos = false; // Controla a exibição da seção de medicamentos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB), // Cor de fundo suave
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            // --- HEADER AZUL ---
            // --- HEADER AZUL (Logo na Direita) ---
            // --- HEADER AZUL ATUALIZADO (Logo Maior na Direita) ---
            Container(
              width: double.infinity,
              //SafeArea manual via padding superior
              padding: const EdgeInsets.only(
                top: 60,
                left: 20,
                right: 20,
                bottom: 30,
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                // spaceBetween empurra o texto para a esquerda e a logo para a direita
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // center alinha o texto e a logo pelo meio da linha
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1. TEXTO DE BOAS-VINDAS (ESQUERDA)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Bem-vinda,',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      Text(
                        'Irina 👋',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // 2. LOGO NO CANTO DIREITO (Aumentada)
                  // Envolvi em um Padding para não ficar colado na borda direita
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 5,
                    ), // Respiro da borda
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 65, // <-- AUMENTADA PARA 65 (estava 40)
                      fit: BoxFit.contain, // Garante que a imagem não distorça
                      // Exibe um ícone médico como backup se a logo sumir
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.medical_services_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- SEÇÃO DE CONTEÚDO (CARDS E BOTÕES) ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _statusCard(), // Card de status do dia
                  const SizedBox(height: 15),
                  _graficoCard(), // Card do gráfico (placeholder)
                  const SizedBox(height: 20),

                  // Botão de Check-in Diário
                  _buildButton(
                    title: 'Check-in diário',
                    icon: Icons.check_circle_outline,
                    onTap: () => Navigator.pushNamed(context, '/checkin'),
                  ),
                  const SizedBox(height: 10),

                  _medicamentosCard(), // Card expansível de medicamentos
                  const SizedBox(height: 10),

                  // Botão de Agendar Consultas
                  _buildButton(
                    title: 'Agendar consultas',
                    icon: Icons.calendar_today_outlined,
                    onTap:
                        widget.onAgendarClick, // Aciona callback do HomeScreen
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES (CARDS E BOTÕES) ---

  // Card de status simples
  Widget _statusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Gradiente conforme design do Figma
        gradient: const LinearGradient(
          colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00f2fe).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Text(
        'Seu status hoje: Normal 😊',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Placeholder para o gráfico
  Widget _graficoCard() {
    return Container(
      height: 180,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: const Center(
        child: Text(
          "Gráfico de Progresso Semanal",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  // Widget genérico para botões de ação (Check-in, Agendar)
  Widget _buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 22),
            const SizedBox(width: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Card expansível para medicamentos
  Widget _medicamentosCard() {
    return Column(
      children: [
        _buildButton(
          title: 'Medicamentos',
          icon: Icons.medication_outlined,
          // Alterna a exibição da lista
          onTap: () => setState(() => showMedicamentos = !showMedicamentos),
        ),
        if (showMedicamentos) // Exibe a lista se showMedicamentos for true
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Próximas doses:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "💊 Dipirona (500mg) - 08:00",
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(height: 6),
                Text(
                  "💊 Vitamina C (1g) - 12:00",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

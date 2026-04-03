import 'package:flutter/material.dart';

// IMPORTS DAS TELAS
import '../exames/exames_screen.dart';
import '../chat/chat_screen.dart';
import '../perfil/perfil_screen.dart';
import '../checkin/checkin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const ExamesScreen(),
    const ChatScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Exames',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

// 👇 CONTEÚDO DA HOME
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool showMedicamentos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 50,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Bem-vindo,',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Bruno 👋',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  Image.asset(
                    'assets/images/logo.png',
                    height: 70,
                    width: 70,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),

            _statusCard(),
            const SizedBox(height: 15),

            _graficoCard(),
            const SizedBox(height: 20),

            _buildButton(
              title: 'Check-in diário',
              icon: Icons.check_circle,
              onTap: () {
                Navigator.pushNamed(context, '/checkin');
              },
            ),

            const SizedBox(height: 10),

            _medicamentosCard(),

            const SizedBox(height: 10),

            _buildButton(
              title: 'Testar alarme',
              icon: Icons.alarm,
              onTap: () {
                Navigator.pushNamed(context, '/alarme');
              },
            ),

            const SizedBox(height: 10),

            _buildButton(
              title: 'Agendar consultas',
              icon: Icons.calendar_month,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  // ================= STATUS =================

  Widget _statusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seu status hoje: Normal 😊',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Último check-in: Ontem',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // ================= GRÁFICO =================

  Widget _graficoCard() {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Seu progresso semanal',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _Bar(80, 'Seg'),
                _Bar(50, 'Ter'),
                _Bar(70, 'Qua'),
                _Bar(30, 'Qui'),
                _Bar(90, 'Sex'),
                _Bar(60, 'Sáb'),
                _Bar(40, 'Dom'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= BOTÕES =================

  Widget _buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  // ================= MEDICAMENTOS =================

  Widget _medicamentosCard() {
    return Column(
      children: [
        _buildButton(
          title: 'Medicamentos',
          icon: Icons.medication,
          onTap: () {
            setState(() {
              showMedicamentos = !showMedicamentos;
            });
          },
        ),

        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: showMedicamentos
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4),
              ],
            ),
            child: const Column(
              children: [
                _MedicamentoItem('Dipirona', '08:00'),
                _MedicamentoItem('Vitamina C', '12:00'),
                _MedicamentoItem('Paracetamol', '20:00'),
              ],
            ),
          ),
          secondChild: const SizedBox(),
        ),
      ],
    );
  }
}

// ================= BARRA DO GRÁFICO =================

class _Bar extends StatelessWidget {
  final double value;
  final String label;

  const _Bar(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 12,
              height: value,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// ================= MEDICAMENTO =================

class _MedicamentoItem extends StatelessWidget {
  final String nome;
  final String hora;

  const _MedicamentoItem(this.nome, this.hora);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.circle, size: 8, color: Colors.blue),
      title: Text(nome),
      trailing: Text(hora),
    );
  }
}

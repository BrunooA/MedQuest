import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // 🛠️ FUNÇÃO DE SIMULAÇÃO (Mantenha fora do build)
  void _simularLoginGovBr(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(32),
          height: 300,
          child: Column(
            children: [
              const Icon(Icons.lock_outline, size: 48, color: Color(0xFF5AB2FF)),
              const SizedBox(height: 16),
              const Text(
                "Conectando ao Gov.br",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Você será redirecionado para o ambiente seguro de autenticação.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const Spacer(),
              const CircularProgressIndicator(color: Color(0xFF5AB2FF)),
              const Spacer(),
            ],
          ),
        );
      },
    );

    // Simula o tempo de resposta do servidor
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pop(context); // Fecha o BottomSheet
        Navigator.pushNamed(context, '/loading'); // Vai para a próxima tela
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 🔵 PARTE SUPERIOR: IMAGEM COM OVERLAY
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                image: DecorationImage(
                  image: const AssetImage('assets/images/login.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.blue.withValues(alpha: 0.5),
                    BlendMode.srcATop,
                  ),
                ),
              ),
            ),
          ),

          // ⚪ PARTE INFERIOR: CONTEÚDO
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Acesse sua conta para continuar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Entre com o Gov.br e acesse todas as aplicações do novo app MedQuest',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  const SizedBox(height: 40),

                  // 🔘 BOTÃO ESTILIZADO
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _simularLoginGovBr(context), // Chamada limpa
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5AB2FF),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Entrar com Gov.br',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
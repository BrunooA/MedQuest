import 'package:flutter/material.dart';
import 'loading_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void handleLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoadingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // 🔵 IMAGEM DE FUNDO
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/login.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 🔵 OVERLAY
          Container(
            color: Colors.blue.withOpacity(0.6),
          ),

          // 🔽 CONTEÚDO
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [

                    Text(
                      "MedQuest",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20),

                    Text(
                      "Acesse sua conta para continuar\nEntre com o Gov.br e acesse todas as aplicações do novo app",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),

                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),

          // 🔘 BOTÃO (separado pra usar context)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => handleLogin(context),
                child: const Text("Entrar com Gov.br"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
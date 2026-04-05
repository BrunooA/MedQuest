import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco para a parte de baixo
      body: Column(
        children: [
          // 🔵 PARTE SUPERIOR: IMAGEM COM OVERLAY AZUL
          Expanded(
            flex:
                5, // Define que a imagem ocupa metade da tela (ajuste se necessário)
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                // Arredondamento das bordas inferiores conforme o Figma
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                image: DecorationImage(
                  image: const AssetImage('assets/images/login.jpg'),
                  fit: BoxFit.cover,
                  // O ColorFilter substitui o Container de overlay separado
                  colorFilter: ColorFilter.mode(
                    Colors.blue.withOpacity(0.5),
                    BlendMode.srcATop,
                  ),
                ),
              ),
            ),
          ),

          // ⚪ PARTE INFERIOR: CONTEÚDO (TEXTOS E BOTÃO)
          Expanded(
            flex: 4, // Define o espaço para o conteúdo branco
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Centraliza os itens no espaço branco
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Acesse sua conta para continuar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors
                          .black87, // Texto escuro agora que o fundo é branco
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
                    width:
                        200, // Largura menor conforme a imagem do Figma mobile
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/loading');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFF5AB2FF,
                        ), // Tom de azul do botão no Figma
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

import 'package:flutter/material.dart';
import 'editar_perfil/etapa1_dados.dart';
import 'editar_perfil/etapa2_saude.dart';
import 'editar_perfil/etapa3_medicacoes.dart';
import 'editar_perfil/etapa4_emergencia.dart';

class FluxoCadastroScreen extends StatefulWidget {
  const FluxoCadastroScreen({super.key});

  @override
  State<FluxoCadastroScreen> createState() => _FluxoCadastroScreenState();
}

class _FluxoCadastroScreenState extends State<FluxoCadastroScreen> {
  // O controlador que faz a mágica de mudar de página
  final PageController _pageController = PageController();

  void _proximaEtapa() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _voltarEtapa() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O PageView segura suas 4 telas
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Travamos o arrasto manual
        children: [
          Etapa1Dados(onNext: _proximaEtapa),
          Etapa2Saude(onNext: _proximaEtapa, onBack: _voltarEtapa),
          Etapa3Medicacoes(onNext: _proximaEtapa, onBack: _voltarEtapa),
          Etapa4Emergencia(onBack: _voltarEtapa),
        ],
      ),
    );
  }
}
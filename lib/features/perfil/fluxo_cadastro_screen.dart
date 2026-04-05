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
  final PageController _pageController = PageController();

  void _proximaEtapa() {
    _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _etapaAnterior() {
    _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Etapa1Dados(onNext: _proximaEtapa),
          Etapa2Saude(onNext: _proximaEtapa, onBack: _etapaAnterior), // Adicionado onBack aqui
          Etapa3Medicacoes(onNext: _proximaEtapa, onBack: _etapaAnterior),
          Etapa4Emergencia(onBack: _etapaAnterior),
        ],
      ),
    );
  }
}
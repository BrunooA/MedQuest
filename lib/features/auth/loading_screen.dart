import 'dart:async';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  int step = 0;

  final List<String> steps = [
    'Importando seus dados...',
    'Nome ✔',
    'Email ✔',
    'Data de nascimento ✔',
  ];

  @override
  void initState() {
    super.initState();

    // ❤️ animação de "batimento"
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _scaleAnimation = Tween(begin: 0.9, end: 1.1).animate(_controller);

    // 🔄 simulação de carregamento
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (step < steps.length - 1) {
        setState(() {
          step++;
        });
      } else {
        timer.cancel();

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/home');
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand( // 🔥 GARANTE TELA TODA
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.green,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // ❤️ LOGO ANIMADA
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 120,
                  ),
                ),

                const SizedBox(height: 30),

                // 📝 TEXTO DINÂMICO
                Text(
                  steps[step],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 10),

                // 🏥 SUBTEXTO
                const Text(
                  'Aplicativo para Monitoramento de Saúde',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
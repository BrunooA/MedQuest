import 'package:flutter/material.dart';
import 'dart:async';
import '../home/home_screen.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  @override
  void initState() {
    super.initState();

    // espera 2 segundos e vai pra home
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F80ED),
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 120, // 👈 logo grande
        ),
      ),
    );
  }
}
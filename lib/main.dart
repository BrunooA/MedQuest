import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // tira o banner DEBUG

      title: 'MedQuest',

      theme: ThemeData(
        primaryColor: const Color(0xFF2F80ED),
        scaffoldBackgroundColor: Colors.white,
      ),

      home: const LoginScreen(), // 👈 começa pelo login
    );
  }
}
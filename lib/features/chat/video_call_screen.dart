import 'dart:async';
import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _showControls = true;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _iniciarTimer();
  }

  void _iniciarTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showControls = false);
    });
  }

  void _alternarControles() {
    setState(() {
      _showControls = !_showControls;
      if (_showControls) _iniciarTimer();
    });
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.black, // Fundo preto caso a imagem demore a carregar
      body: GestureDetector(
        onTap: _alternarControles,
        child: Stack(
          children: [
            // 1. IMAGEM DA DOUTORA (CORREÇÃO: Extensão .jpg incluída)
            SizedBox.expand(
              child: Image.asset(
                'assets/images/doutora.jpg', // CERTIFIQUE-SE DO .jpg AQUI
                fit: BoxFit.cover,
                // Tratamento de erro caso o asset falhe
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[900],
                    child: const Center(
                      child: Icon(Icons.person, color: Colors.white, size: 100),
                    ),
                  );
                },
              ),
            ),

            // 2. GRADIENTE (Figma feel)
            IgnorePointer(
              // Impede que o gradiente bloqueie o toque do GestureDetector
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.5),
                    ],
                  ),
                ),
              ),
            ),

            // 3. TEXTOS (Superior Esquerdo)
            Positioned(
              top: 60,
              left: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.circle, color: Colors.green, size: 10),
                      const SizedBox(width: 8),
                      const Text(
                        "Em chamada",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Dra. Anna Silva",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Clínico Geral",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),

            // 4. MINIATURA DO PACIENTE
            Positioned(
              bottom: 120,
              right: 20,
              child: Container(
                width: 100,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                  boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 10)],
                  image: const DecorationImage(
                    image: NetworkImage(
                      "https://www.w3schools.com/howto/img_avatar.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // 5. BARRA DE CONTROLES ANIMADA
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              bottom: _showControls ? 40 : -100,
              left: 50,
              right: 50,
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.videocam_outlined),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.mic_none_outlined),
                      onPressed: () {},
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 22,
                        child: Icon(Icons.call_end, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

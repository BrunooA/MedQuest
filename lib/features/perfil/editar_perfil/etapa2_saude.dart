import 'package:flutter/material.dart';

class Etapa2Saude extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Etapa2Saude({super.key, required this.onNext, required this.onBack});

  @override
  State<Etapa2Saude> createState() => _Etapa2SaudeState();
}

class _Etapa2SaudeState extends State<Etapa2Saude> {
  // Map para controlar os Checkboxes do seu Figma
  Map<String, bool> condicoes = {
    "Nenhuma": true,
    "Diabetes": false,
    "Hipertensão": false,
    "Asma": false,
    "Outra": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF3498DB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: widget.onBack, // Volta para a Etapa 1
        ),
        title: const Text("Dados de Saúde", style: TextStyle(color: Colors.white)),
        actions: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text("2 \\ 4", style: TextStyle(color: Colors.white70)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Você possui alguma condição?", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            
            // Gera a lista de Checkboxes baseada no seu Map
            ...condicoes.keys.map((String key) {
              return CheckboxListTile(
                title: Text(key),
                value: condicoes[key],
                activeColor: const Color(0xFF2ECC71),
                onChanged: (bool? value) {
                  setState(() {
                    condicoes[key] = value!;
                  });
                },
              );
            }).toList(),

            const SizedBox(height: 30),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2ECC71)),
                onPressed: widget.onNext, // Vai para Etapa 3
                child: const Text("Próximo", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
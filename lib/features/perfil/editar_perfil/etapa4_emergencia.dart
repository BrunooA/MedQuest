import 'package:flutter/material.dart';

class Etapa4Emergencia extends StatefulWidget {
  final VoidCallback onBack;
  const Etapa4Emergencia({super.key, required this.onBack});

  @override
  State<Etapa4Emergencia> createState() => _Etapa4EmergenciaState();
}

class _Etapa4EmergenciaState extends State<Etapa4Emergencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF3498DB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: widget.onBack,
        ),
        title: const Text("Contato de emergência", style: TextStyle(color: Colors.white)),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: Text("4 \\ 4", style: TextStyle(color: Colors.white70)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("Nome Completo"),
            _input("Felipe Reges"),
            const SizedBox(height: 15),
            _label("E-mail de contato"),
            _input("irineusilva.borges@teste.com"),
            const SizedBox(height: 15),
            _label("Número de Telefone"),
            _input("adicione o seu numero de telefone"),
            const SizedBox(height: 15),
            _label("Relação com o contato"),
            _input("Selecionar"), // Aqui você pode depois trocar por um Dropdown
            
            const SizedBox(height: 50),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2ECC71),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // MÁGICA: Fecha todo o fluxo e volta para a tela de Perfil
                  Navigator.pop(context);
                },
                child: const Text("Salvar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String texto) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _input(String hint) => TextField(
    decoration: InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF8F9FA),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    ),
  );
}
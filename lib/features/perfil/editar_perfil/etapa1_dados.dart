import 'package:flutter/material.dart';

class Etapa1Dados extends StatefulWidget {
  final VoidCallback onNext; 
  const Etapa1Dados({super.key, required this.onNext});

  @override
  State<Etapa1Dados> createState() => _Etapa1DadosState();
}

// ESTA É A PARTE QUE ESTAVA FALTANDO NO SEU CÓDIGO:
class _Etapa1DadosState extends State<Etapa1Dados> {
  // Controladores para capturar o texto
  final TextEditingController _nomeController = TextEditingController(text: "Irina S. Borges");
  final TextEditingController _emailController = TextEditingController(text: "irina.silva.borges@teste.com");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF3498DB), 
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: const Text("Dados Pessoais", style: TextStyle(color: Colors.white, fontSize: 18)),
        
        // CORREÇÃO AQUI: centerTitle fica fora do actions
        centerTitle: false, 
        
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: Text("1 \\ 4", style: TextStyle(color: Colors.white70)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Círculo de Avatar do Figma
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFC0CB), // Rosa claro do seu print
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),

            _label("Nome Completo"),
            _input(_nomeController, "Digite seu nome"),

            const SizedBox(height: 15),

            _label("Digite seu e-mail"),
            _input(_emailController, "email@exemplo.com"),

            const SizedBox(height: 15),

            _label("Data de Nascimento"),
            _input(TextEditingController(text: "17/03/1998"), "DD/MM/AAAA"),

            const SizedBox(height: 40),

            // Botão Próximo
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2ECC71), // Verde do Figma
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: widget.onNext, // <--- CHAMA A FUNÇÃO DO PAI (FLUXO)
                child: const Text("Próximo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widgets auxiliares para manter o código limpo
  Widget _label(String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _input(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF0F0F0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
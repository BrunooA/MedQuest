import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importante para o FilteringTextInputFormatter
import '../user_controller.dart';
import '../figma_styles.dart';

class Etapa4Emergencia extends StatefulWidget {
  final VoidCallback onBack;
  const Etapa4Emergencia({super.key, required this.onBack});

  @override
  State<Etapa4Emergencia> createState() => _Etapa4EmergenciaState();
}

class _Etapa4EmergenciaState extends State<Etapa4Emergencia> {
  final _nomeCont = TextEditingController(text: userController.contatoEmergencia);
  final _telCont = TextEditingController(text: userController.telefoneEmergencia);
  String? _parentesco = userController.parentescoEmergencia.isEmpty ? null : userController.parentescoEmergencia;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          figmaHeader("Contato de emergência", "4 \\ 4", 1.0),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  figmaLabel("Nome Completo"),
                  TextField(controller: _nomeCont, decoration: figmaInputDecoration),
                  figmaLabel("Número de Telefone"),
                  TextField(
                    controller: _telCont,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly], // BLOQUEIA LETRAS
                    decoration: figmaInputDecoration.copyWith(hintText: "Somente números"),
                  ),
                  figmaLabel("Relação"),
                  DropdownButtonFormField<String>(
                    initialValue: _parentesco,
                    items: ["Pai", "Mãe", "Amigo", "Parente", "Cônjuge"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (v) => setState(() => _parentesco = v),
                    decoration: figmaInputDecoration,
                  ),
                ],
              ),
            ),
          ),
          _buildBotaoSalvar(),
        ],
      ),
    );
  }

  Widget _buildBotaoSalvar() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: SizedBox(width: double.infinity, height: 50, child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: colorFigmaGreen),
        onPressed: () {
          if (_nomeCont.text.isEmpty || _telCont.text.isEmpty) {
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Preencha todos os campos!")));
             return;
          }
          userController.contatoEmergencia = _nomeCont.text;
          userController.telefoneEmergencia = _telCont.text;
          userController.parentescoEmergencia = _parentesco ?? "Parente";
          Navigator.pop(context); // Volta para o Perfil
        },
        child: const Text("Salvar Perfil", style: TextStyle(color: Colors.white)),
      )),
    );
  }
}
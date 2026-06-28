import 'package:flutter/material.dart';
import '../user_controller.dart';
import '../figma_styles.dart';

class Etapa2Saude extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack; // Adiciona esta linha
  const Etapa2Saude({super.key, required this.onNext, required this.onBack}); // Atualiza o construtor

  @override
  State<Etapa2Saude> createState() => _Etapa2SaudeState();
}

class _Etapa2SaudeState extends State<Etapa2Saude> {
  final _pesoCont = TextEditingController(text: userController.peso);
  final _altCont = TextEditingController(text: userController.altura);
  List<String> alergias = List.from(userController.alergias);

  void _addAlergia() {
    TextEditingController a = TextEditingController();
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Nova Alergia"),
        content: TextField(
          controller: a, 
          decoration: const InputDecoration(hintText: "Ex: Amendoim, Lactose"),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text("Cancelar")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: colorFigmaGreen),
            onPressed: () {
              if (a.text.trim().isNotEmpty) {
                setState(() => alergias.add(a.text.trim()));
                Navigator.pop(c);
              }
            }, 
            child: const Text("Adicionar", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              figmaHeader("Saúde", "2 \\ 4", 0.5),
              Positioned(top: 40, left: 10, child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: widget.onBack, // Agora funciona!
              )),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  figmaLabel("Peso (kg)"),
                  TextField(controller: _pesoCont, keyboardType: TextInputType.number, decoration: figmaInputDecoration),
                  figmaLabel("Altura (m)"),
                  TextField(controller: _altCont, keyboardType: TextInputType.number, decoration: figmaInputDecoration),
                  const SizedBox(height: 25),
                  figmaLabel("Alergias"),
                  _buildAddAlergiaBtn(),
                  const SizedBox(height: 15),
                  // Lista de Alergias em Cards com botão de remover
                  ...alergias.map((al) => Card(
                    elevation: 0,
                    color: Colors.red[50],
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: const Icon(Icons.warning_amber, color: Colors.red),
                      title: Text(al, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () => setState(() => alergias.remove(al)),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: SizedBox(width: double.infinity, height: 50, child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: colorFigmaGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: () {
                userController.peso = _pesoCont.text;
                userController.altura = _altCont.text;
                userController.alergias = alergias;
                widget.onNext();
              },
              child: const Text("Próximo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            )),
          )
        ],
      ),
    );
  }

  Widget _buildAddAlergiaBtn() {
    return InkWell(
      onTap: _addAlergia,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(border: Border.all(color: colorFigmaBlue), borderRadius: BorderRadius.circular(12)),
        child: const Row(children: [Icon(Icons.add, color: colorFigmaBlue), SizedBox(width: 10), Text("Adicionar Alergia", style: TextStyle(color: colorFigmaBlue))]),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../user_controller.dart';
import '../figma_styles.dart';

class Etapa3Medicacoes extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Etapa3Medicacoes({super.key, required this.onNext, required this.onBack});

  @override
  State<Etapa3Medicacoes> createState() => _Etapa3MedicacoesState();
}

class _Etapa3MedicacoesState extends State<Etapa3Medicacoes> {
  List<Map<String, String>> medicamentos = List.from(userController.medicamentos);

  void _abrirDialogo({int? index}) {
    TextEditingController n = TextEditingController(
      text: index != null ? medicamentos[index]['nome'] : ""
    );
    
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(index == null ? "Adicionar Remédio" : "Editar Remédio"),
        content: TextField(
          controller: n, 
          decoration: const InputDecoration(hintText: "Nome do medicamento"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text("Cancelar")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2ECC71)),
            onPressed: () {
              if (n.text.trim().isEmpty) return; 
              setState(() {
                if (index == null) {
                  medicamentos.add({"nome": n.text, "horario": "08:00 - 20:00"});
                } else {
                  medicamentos[index]['nome'] = n.text;
                }
              });
              Navigator.pop(c);
            }, 
            child: const Text("Salvar", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              figmaHeader("Medicações", "3 \\ 4", 0.75),
              Positioned(top: 40, left: 10, child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: widget.onBack,
              )),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(25),
              children: [
                InkWell(onTap: () => _abrirDialogo(), child: _buildAddCard()),
                ...medicamentos.asMap().entries.map((e) => InkWell(
                  onTap: () => _abrirDialogo(index: e.key),
                  child: _buildMedCard(e.value['nome']!, e.value['horario']!),
                )).toList(),
              ],
            ),
          ),
          _buildRodape(),
        ],
      ),
    );
  }

  Widget _buildRodape() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(children: [
            Expanded(child: ElevatedButton(onPressed: () => setState(() => medicamentos.clear()), child: const Text("Limpar"))),
            const SizedBox(width: 10),
            Expanded(child: ElevatedButton(onPressed: widget.onNext, child: const Text("Próximo"))),
          ]),
        ],
      ),
    );
  }

  Widget _buildAddCard() => const Card(child: ListTile(leading: Icon(Icons.add), title: Text("Adicionar")));
  Widget _buildMedCard(String n, String h) => Card(child: ListTile(leading: const Icon(Icons.medication), title: Text(n), subtitle: Text(h)));
}
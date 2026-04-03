import 'package:flutter/material.dart';

class Etapa3Medicacoes extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Etapa3Medicacoes({super.key, required this.onNext, required this.onBack});

  @override
  State<Etapa3Medicacoes> createState() => _Etapa3MedicacoesState();
}

class _Etapa3MedicacoesState extends State<Etapa3Medicacoes> {
  // Lista simulada baseada no seu Figma
  final List<Map<String, String>> medicamentos = [
    {"nome": "Dipirona", "horario": "08:00 • 20:00"},
    {"nome": "Ibuprofeno", "horario": "08:00 • 20:00"},
    {"nome": "Torcilax", "horario": "08:00 • 20:00"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3498DB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: widget.onBack,
        ),
        title: const Text("Medicações", style: TextStyle(color: Colors.white)),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: Text("3 \\ 4", style: TextStyle(color: Colors.white70)),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildAddCard(),
                const SizedBox(height: 15),
                ...medicamentos.map((med) => _buildMedCard(med['nome']!, med['horario']!)).toList(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2ECC71),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: widget.onNext,
                child: const Text("Próximo", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.medication, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          const Text("Adicionar Medicações", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMedCard(String nome, String horario) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Icon(Icons.medical_services, color: Colors.blue),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nome, style: const TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 12, color: Colors.blue),
                  const SizedBox(width: 5),
                  Text(horario, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
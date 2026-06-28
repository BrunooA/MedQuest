import 'package:flutter/material.dart';

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  int? humorSelecionado;

  final List<IconData> iconesHumor = [
    Icons.sentiment_very_dissatisfied,
    Icons.sentiment_dissatisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_satisfied,
    Icons.sentiment_very_satisfied,
  ];

  List<String> sintomas = [
    'Dor de cabeça',
    'Tosse',
    'Febre',
    'Náusea',
    'Cansaço',
    'Ansiedade',
  ];

  List<String> sintomasSelecionados = [];

  TextEditingController detalhesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check-in diário')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🧠 CARD 1 - HUMOR
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Como você está se sentindo hoje?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(iconesHumor.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            humorSelecionado = index;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              iconesHumor[index],
                              size: 32,
                              color: humorSelecionado == index
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            if (humorSelecionado == index)
                              const Icon(Icons.check, size: 16),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // 🤒 CARD 2 - SINTOMAS
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'O que você está sentindo?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: sintomas.map((sintoma) {
                      final selecionado = sintomasSelecionados.contains(
                        sintoma,
                      );

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selecionado) {
                              sintomasSelecionados.remove(sintoma);
                            } else {
                              sintomasSelecionados.add(sintoma);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: selecionado
                                ? Colors.blue
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                sintoma,
                                style: TextStyle(
                                  color: selecionado
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              if (selecionado) ...[
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // 📝 CARD 3 - DETALHES
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quer adicionar mais detalhes?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  TextField(
                    controller: detalhesController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Ex: Dor leve desde manhã...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 💾 BOTÃO SALVAR
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('Humor: $humorSelecionado');
                  debugPrint('Sintomas: $sintomasSelecionados');
                  debugPrint('Detalhes: ${detalhesController.text}');

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Check-in salvo com sucesso!'),
                    ),
                  );

                  Navigator.pop(context);
                },
                child: const Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.black.withValues(alpha: 0.05)),
        ],
      ),
      child: child,
    );
  }
}

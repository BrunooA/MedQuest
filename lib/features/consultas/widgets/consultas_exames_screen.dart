import 'package:flutter/material.dart';
import 'dados_temporarios.dart';
import 'nova_consulta_screen.dart';
import 'novo_exame_screen.dart';

class ConsultasExamesScreen extends StatefulWidget {
  const ConsultasExamesScreen({super.key});

  @override
  State<ConsultasExamesScreen> createState() => _ConsultasExamesScreenState();
}

class _ConsultasExamesScreenState extends State<ConsultasExamesScreen> {
  // AQUI ESTÁ A CORREÇÃO: O nome deve ser exatamente abaConsultas
  bool abaConsultas = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Column(
        children: [
          // Cabeçalho Azul
          Container(
            width: double.infinity,
            color: const Color(0xFF3498DB),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.arrow_back, color: Colors.white),
                const SizedBox(height: 15),
                Text(
                  abaConsultas ? "Minhas Consultas" : "Meus Exames",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildSeletorAbas(),
                  const SizedBox(height: 20),
                  _buildBotaoAdicionar(),
                  const SizedBox(height: 25),
                  // Chamada das listas baseada na variável abaConsultas
                  abaConsultas ? _listaConsultas() : _listaExames(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeletorAbas() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          _abaItem(
            "Consultas",
            abaConsultas,
            () => setState(() => abaConsultas = true),
          ),
          _abaItem(
            "Exames",
            !abaConsultas,
            () => setState(() => abaConsultas = false),
          ),
        ],
      ),
    );
  }

  Widget _abaItem(String label, bool ativa, VoidCallback onTap) => Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ativa ? const Color(0xFF3498DB) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: ativa ? Colors.white : Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );

  Widget _buildBotaoAdicionar() => GestureDetector(
    onTap: () async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => abaConsultas
              ? const NovaConsultaScreen()
              : const NovoExameScreen(),
        ),
      );
      setState(() {});
    },
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.add_circle, color: Color(0xFF3498DB), size: 28),
          const SizedBox(width: 12),
          Text(
            abaConsultas ? "Agendar Consulta" : "Agendar Exame",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );

  Widget _listaConsultas() {
    return Column(
      children: listaConsultasCadastradas.reversed.map((c) {
        bool ehVideo = c['tipoAtendimento'] == "Vídeo";
        return _cardItem(
          titulo: c['nome'],
          subtitulo: "${c['especialidade']} • ${c['local']}",
          onEntrar: ehVideo ? () {} : null,
          onDetalhes: () => _mostrarOverlayDetalhes(c),
        );
      }).toList(),
    );
  }

  Widget _listaExames() {
    return Column(
      children: listaExamesCadastrados
          .map(
            (e) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: Text(
                  e['titulo']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(e['data']!),
                trailing: const Icon(Icons.check_circle, color: Colors.green),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _cardItem({
    required String titulo,
    required String subtitulo,
    required VoidCallback? onEntrar,
    required VoidCallback onDetalhes,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Text(subtitulo, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: onEntrar != null
                        ? const Color(0xFF2ECC71)
                        : Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: onEntrar,
                  child: const Text(
                    "Entrar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF2ECC71)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: onDetalhes,
                  child: const Text(
                    "Detalhes",
                    style: TextStyle(color: Color(0xFF2ECC71)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _mostrarOverlayDetalhes(Map<String, dynamic> c) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Detalhes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _linhaDetalhe(Icons.person, c['nome']),
              _linhaDetalhe(Icons.medical_services, c['especialidade']),
              _linhaDetalhe(Icons.calendar_today, c['data']),
              _linhaDetalhe(Icons.location_on, c['local']),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2ECC71),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Fechar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _linhaDetalhe(IconData icon, String texto) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(icon, color: Colors.blue, size: 22),
        const SizedBox(width: 15),
        Text(texto, style: const TextStyle(fontSize: 16)),
      ],
    ),
  );
}

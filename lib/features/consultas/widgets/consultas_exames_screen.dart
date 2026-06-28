import 'package:flutter/material.dart';
import 'dados_temporarios.dart';
import 'nova_consulta_screen.dart';
import 'novo_exame_screen.dart';
import 'package:meu_app/features/chat/video_call_screen.dart'; // Importação absoluta corrigida

class ConsultasExamesScreen extends StatefulWidget {
  const ConsultasExamesScreen({super.key});

  @override
  State<ConsultasExamesScreen> createState() => _ConsultasExamesScreenState();
}

class _ConsultasExamesScreenState extends State<ConsultasExamesScreen> {
  bool abaConsultas = true;
  String queryBusca = "";
  final TextEditingController _buscaController = TextEditingController();

  // Helper de Cores para o Status conforme o Figma
  Color _getStatusColor(String status) {
    switch (status) {
      case "Agendado":
        return Colors.amber;
      case "Cancelada":
        return Colors.red;
      case "Concluído":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Column(
        children: [
          // Cabeçalho Azul com Campo de Busca Integrado (Fidelidade ao Figma)
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
                const SizedBox(height: 15),
                // Campo de Busca
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: _buscaController,
                    onChanged: (value) {
                      setState(() {
                        queryBusca = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: abaConsultas ? "Buscar Consultas" : "Buscar Exames",
                      prefixIcon: const Icon(Icons.search, color: Colors.black54),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
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
                  // Chamada das listas filtradas baseada na aba ativa
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
        border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          _abaItem(
            "Consultas",
            abaConsultas,
            () => setState(() {
              abaConsultas = true;
              _buscaController.clear();
              queryBusca = "";
            }),
          ),
          _abaItem(
            "Exames",
            !abaConsultas,
            () => setState(() {
              abaConsultas = false;
              _buscaController.clear();
              queryBusca = "";
            }),
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
      if (abaConsultas) {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NovaConsultaScreen()),
        );
        setState(() {});
      } else {
        // Regra de Negócio: Impede agendar exame se não houver consultas salvas
        if (listaConsultasCadastradas.isEmpty) {
          _mostrarAvisoConsultaNecessaria();
        } else {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NovoExameScreen()),
          );
          setState(() {});
        }
      }
    },
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5),
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

  void _mostrarAvisoConsultaNecessaria() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 30),
            SizedBox(width: 10),
            Text("Aviso", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          "Para agendar um novo exame, você precisa ter pelo menos uma consulta médica mapeada ou realizada no sistema."
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Entendido", 
              style: TextStyle(color: Color(0xFF3498DB), fontWeight: FontWeight.bold)
            ),
          ),
        ],
      ),
    );
  }

  Widget _listaConsultas() {
    // Filtragem em tempo real por nome do médico ou especialidade
    var filtradas = listaConsultasCadastradas.reversed.where((c) {
      final nome = c['nome']?.toString().toLowerCase() ?? "";
      final esp = c['especialidade']?.toString().toLowerCase() ?? "";
      return nome.contains(queryBusca) || esp.contains(queryBusca);
    }).toList();

    if (filtradas.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 30),
        child: Text("Nenhuma consulta encontrada.", style: TextStyle(color: Colors.grey)),
      );
    }

    return Column(
      children: filtradas.map((c) {
        bool ehVideo = c['tipoAtendimento'] == "Vídeo";
        String status = c['status'] ?? 'Agendado';

        return _cardItem(
          titulo: c['nome'],
          subtitulo: "${c['especialidade']} • ${c['local']}",
          status: status,
          // Se for chamada de vídeo, abre a tela correta. Caso contrário, botão desabilitado
          onEntrar: ehVideo 
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VideoCallScreen()),
                  );
                }
              : null,
          onDetalhes: () => _mostrarOverlayDetalhes(c),
        );
      }).toList(),
    );
  }

  Widget _listaExames() {
    // Filtragem de exames por título
    var filtrados = listaExamesCadastrados.where((e) {
      final titulo = e['titulo']?.toString().toLowerCase() ?? "";
      return titulo.contains(queryBusca);
    }).toList();

    if (filtrados.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 30),
        child: Text("Nenhum exame encontrado.", style: TextStyle(color: Colors.grey)),
      );
    }

    return Column(
      children: filtrados
          .map(
            (e) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
    required String status,
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
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  titulo, 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)
                ),
              ),
              // Indicador Visual do Status (Bolinha Colorida do Figma)
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: _getStatusColor(status),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    status,
                    style: TextStyle(
                      color: _getStatusColor(status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
          Text(subtitulo, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: onEntrar != null ? const Color(0xFF2ECC71) : Colors.grey[300],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: onEntrar,
                  child: const Text("Entrar", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF2ECC71)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: onDetalhes,
                  child: const Text("Detalhes", style: TextStyle(color: Color(0xFF2ECC71))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _mostrarOverlayDetalhes(Map<String, dynamic> c) {
    final String status = c['status'] ?? 'Agendado';

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  status == "Cancelada" ? "Consulta Cancelada" : "Detalhes",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              
              _linhaDetalhe(Icons.person, c['nome']),
              _linhaDetalhe(Icons.medical_services, c['especialidade']),
              _linhaDetalhe(Icons.calendar_today, c['data']),
              _linhaDetalhe(Icons.location_on, c['local']),
              
              // Se possuir o motivo adicionado no mapa de dados, renderiza em formato texto
              if (c.containsKey('motivo')) ...[
                const SizedBox(height: 12),
                const Text(
                  "📝 Motivo da consulta:", 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                ),
                const SizedBox(height: 4),
                Text(
                  '"${c['motivo']}"', 
                  style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black87)
                ),
              ],

              const SizedBox(height: 25),
              
              // Botão Dinâmico: Se cancelada vira "Reagendar", se não vira "Fechar"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2ECC71),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    if (status == "Cancelada") {
                      // Direciona para tela de agendamento caso queira reagendar
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const NovaConsultaScreen())
                      );
                    }
                  },
                  child: Text(
                    status == "Cancelada" ? "Reagendar" : "Fechar",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
        Expanded(child: Text(texto, style: const TextStyle(fontSize: 16))),
      ],
    ),
  );
}
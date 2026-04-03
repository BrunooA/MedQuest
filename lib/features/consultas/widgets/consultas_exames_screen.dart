import 'package:flutter/material.dart';

class ConsultasExamesScreen extends StatefulWidget {
  const ConsultasExamesScreen({super.key});

  @override
  State<ConsultasExamesScreen> createState() => _ConsultasExamesScreenState();
}

class _ConsultasExamesScreenState extends State<ConsultasExamesScreen> {
  // Controle da aba ativa: true = Consultas, false = Exames
  bool abaConsultasAtiva = true; 
  final TextEditingController _searchController = TextEditingController();

  // --- OVERLAYS DO FIGMA (Idêntico às suas imagens) ---

  void _mostrarOverlayDetalhes() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Detalhes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 15),
              _itemOverlay(Icons.person, "Dr. João Silva"),
              _itemOverlay(Icons.medical_services_outlined, "Clínico Geral"),
              _itemOverlay(Icons.calendar_today, "Hoje • 14:30"),
              _itemOverlay(Icons.location_on, "Online"),
              const Divider(height: 25),
              const Text("📝 Motivo da consulta:\n\"Estou com dores de cabeça frequentes há 3 dias...\"", textAlign: TextAlign.center),
              const SizedBox(height: 15),
              _botaoOverlayFechar(),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarOverlayResumo() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Resumo da Consulta", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 15),
              _itemOverlay(Icons.person, "Dra. Ana Costa"),
              _itemOverlay(Icons.medical_services_outlined, "Dermatologista"),
              _itemOverlay(Icons.calendar_today, "10/03 • 09:00"),
              const Divider(height: 25),
              const Text("📄 Resumo: Paciente apresentou irritação na pele...", textAlign: TextAlign.center),
              const Text("💊 Prescrição: Pomada X - 2x ao dia", textAlign: TextAlign.center),
              const SizedBox(height: 15),
              _botaoOverlayFechar(),
            ],
          ),
        ),
      ),
    );
  }

  // --- FIM DOS OVERLAYS ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Column(
        children: [
          // 1. CABEÇALHO AZUL (Dinâmico conforme Figma)
          Container(
            width: double.infinity,
            color: const Color(0xFF3498DB),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: Colors.white)),
                const SizedBox(height: 15),
                Text(
                  abaConsultasAtiva ? "Você tem 1 consulta hoje" : "Seus exames estão dentro do normal.\nContinue cuidando da sua saúde 💚",
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // 2. BUSCA
                  _buildSearch(),
                  const SizedBox(height: 15),

                  // 3. SELETOR DE ABAS [Consultas | Exames]
                  _buildSeletor(),
                  const SizedBox(height: 15),

                  // 4. BOTÃO ADICIONAR
                  _buildAddButton(),
                  const SizedBox(height: 25),

                  // 5. CONTEÚDO CORRIGIDO (Fiel ao seu Figma agora)
                  abaConsultasAtiva ? _listaConsultasHistorico() : _listaExamesCards(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- COMPONENTES AUXILIARES ---

  Widget _buildSearch() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(color: const Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          icon: const Icon(Icons.search, color: Colors.black54),
          hintText: abaConsultasAtiva ? "Buscar Consultas..." : "Buscar Exames...",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSeletor() {
    return Container(
      height: 45,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.blue.withOpacity(0.3))),
      child: Row(
        children: [
          _tabItem("Consultas", abaConsultasAtiva, () => setState(() { abaConsultasAtiva = true; _searchController.clear(); })),
          _tabItem("Exames", !abaConsultasAtiva, () => setState(() { abaConsultasAtiva = false; _searchController.clear(); })),
        ],
      ),
    );
  }

  Widget _tabItem(String label, bool active, VoidCallback onTap) => Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: active ? const Color(0xFF3498DB) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
        child: Center(child: Text(label, style: TextStyle(color: active ? Colors.white : Colors.blue, fontWeight: FontWeight.bold))),
      ),
    ),
  );

  Widget _buildAddButton() => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.withOpacity(0.2))),
    child: Row(children: [const Icon(Icons.add_circle, color: Color(0xFF3498DB), size: 30), const SizedBox(width: 10), Text(abaConsultasAtiva ? "Agendar Consultas" : "Agendar Exames", style: const TextStyle(fontWeight: FontWeight.bold))]),
  );

  // --- LISTAS DE CONTEÚDO (A CORREÇÃO ESTÁ AQUI) ---

  // ABA CONSULTAS: Agora mostra a lista simples (Histórico)
  Widget _listaConsultasHistorico() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          _itemListaSimples("Hemograma", "10/03/2026"),
          _divider(),
          _itemListaSimples("Glicose", "05/03/2026"),
          _divider(),
          _itemListaSimples("Colesterol", "20/02/2026"),
        ],
      ),
    );
  }

  // ABA EXAMES: Agora mostra os Cards detalhados (Dr. João, Dr. Carlos...)
  Widget _listaExamesCards() {
    return Column(
      children: [
        _cardExameDetalhado(
          nome: "Dr. João Silva",
          cargo: "Clínico Geral",
          data: "Hoje • 14:30",
          local: "Online",
          status: "Agendada",
          corStatus: Colors.yellow[700]!,
          botoes: [
            _botaoVerde("Entrar", () {}),
            const SizedBox(width: 10),
            _botaoVerde("Ver Detalhes", _mostrarOverlayDetalhes), // Interação OK
          ],
        ),
        _cardExameDetalhado(
          nome: "Dr. Carlos Lima",
          cargo: "Cardiologista",
          data: "05/03/2026 • 16:00",
          local: "Presencial",
          status: "Cancelada",
          corStatus: Colors.red,
          botoes: [_botaoVerde("Reagendar", () {})],
        ),
        _cardExameDetalhado(
          nome: "Dra. Ana Costa",
          cargo: "Dermatologista",
          data: "10/03 • 09:00",
          local: "Presencial",
          status: "Concluída",
          corStatus: Colors.green,
          botoes: [
            _botaoVerde("Resumo", _mostrarOverlayResumo), // Interação OK
            const SizedBox(width: 10),
            _botaoVerde("Reagendar", () {}),
          ],
        ),
      ],
    );
  }

  // --- WIDGETS DE DESIGN (Idêntico ao Figma) ---

  Widget _itemListaSimples(String titulo, String data) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Row(children: [const Icon(Icons.calendar_today, size: 14, color: Colors.blue), const SizedBox(width: 10), Text(data)]), const Text("Normal", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))]);

  Widget _divider() => const Padding(padding: EdgeInsets.symmetric(vertical: 10), child: Divider(height: 1));

  Widget _cardExameDetalhado({required String nome, required String cargo, required String data, required String local, required String status, required Color corStatus, required List<Widget> botoes}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.blue[400], borderRadius: BorderRadius.circular(10))), const SizedBox(width: 15), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(nome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text(cargo, style: const TextStyle(color: Colors.grey))])]),
          const SizedBox(height: 15),
          _rowIcon(Icons.calendar_today_outlined, data),
          _rowIcon(Icons.location_on_outlined, local, color: Colors.red[300]!),
          _rowIcon(Icons.circle, status, color: corStatus, size: 12),
          const SizedBox(height: 20),
          Row(children: botoes),
        ],
      ),
    );
  }

  Widget _rowIcon(IconData icon, String text, {Color color = Colors.blue, double size = 18}) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(children: [Icon(icon, size: size, color: color), const SizedBox(width: 10), Text(text)]));

  Widget _itemOverlay(IconData icon, String text) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children: [Icon(icon, color: Colors.blue, size: 20), const SizedBox(width: 10), Text(text)]));

  Widget _botaoVerde(String label, VoidCallback onTap) => Expanded(child: InkWell(onTap: onTap, child: Container(padding: const EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(color: const Color(0xFF2ECC71), borderRadius: BorderRadius.circular(10)), child: Center(child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))))));

  Widget _botaoOverlayFechar() => ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2ECC71)), child: const Text("Fechar", style: TextStyle(color: Colors.white)));
}
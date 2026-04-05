import 'package:flutter/material.dart';
import 'dados_temporarios.dart';

class NovaConsultaScreen extends StatefulWidget {
  const NovaConsultaScreen({super.key});

  @override
  State<NovaConsultaScreen> createState() => _NovaConsultaScreenState();
}

class _NovaConsultaScreenState extends State<NovaConsultaScreen> {
  String? especialidade;
  String? medico;
  String tipoAtendimento = "Presencial";

  void _aoMudarEspecialidade(String? novaEspec) {
    setState(() {
      especialidade = novaEspec;
      List<String> medicos = dadosMedicosPorEspecialidade[novaEspec] ?? [];
      medico = medicos.length == 1 ? medicos.first : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3498DB),
        title: const Text(
          "Agendar Consulta",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("Especialidade"),
            _buildDropdown(
              dadosMedicosPorEspecialidade.keys.toList(),
              especialidade,
              _aoMudarEspecialidade,
            ),

            _label("Nome do Médico"),
            _buildDropdown(
              especialidade == null
                  ? []
                  : dadosMedicosPorEspecialidade[especialidade]!,
              medico,
              (v) => setState(() => medico = v),
            ),

            _label("Tipo de Atendimento"),
            Row(
              children: [
                _radioBtn("Presencial", Icons.person_outline),
                const SizedBox(width: 10),
                _radioBtn("Vídeo", Icons.videocam_outlined),
              ],
            ),

            const SizedBox(height: 40),
            _botaoConfirmar(),
          ],
        ),
      ),
    );
  }

  Widget _label(String t) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8),
    child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _buildDropdown(
    List<String> itens,
    String? valor,
    Function(String?)? onChange,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: valor,
          hint: const Text("Selecione..."),
          items: itens
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChange,
        ),
      ),
    );
  }

  Widget _radioBtn(String val, IconData icon) => Expanded(
    child: InkWell(
      onTap: () => setState(() => tipoAtendimento = val),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: tipoAtendimento == val
              ? const Color(0xFF3498DB).withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: tipoAtendimento == val
                ? const Color(0xFF3498DB)
                : Colors.black12,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: tipoAtendimento == val
                  ? const Color(0xFF3498DB)
                  : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(val),
          ],
        ),
      ),
    ),
  );

  Widget _botaoConfirmar() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2ECC71),
        padding: const EdgeInsets.all(15),
      ),
      onPressed: () {
        if (medico != null) {
          listaConsultasCadastradas.add({
            "nome": medico!,
            "especialidade": especialidade!,
            "data": "12/04 • 10:00",
            "local": tipoAtendimento == "Vídeo" ? "Online" : "Clínica MedQuest",
            "status": "Agendada",
            "cor": Colors.orange,
            "tipoAtendimento": tipoAtendimento,
          });
          Navigator.pop(context);
        }
      },
      child: const Text(
        "Confirmar Agendamento",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

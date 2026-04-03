import 'package:flutter/material.dart';
import 'dados_temporarios.dart';

class NovaConsultaScreen extends StatefulWidget {
  const NovaConsultaScreen({super.key});

  @override
  State<NovaConsultaScreen> createState() => _NovaConsultaScreenState();
}

class _NovaConsultaScreenState extends State<NovaConsultaScreen> {
  String? medico;
  String? especialidade;
  String? horario;

  bool presencial = false;
  bool video = false;
  bool chat = false;

  // FUNÇÃO QUE SALVA DE VERDADE NA LISTA GLOBAL
  void _salvarConsulta() {
    if (medico == null || especialidade == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha o médico e a especialidade!")),
      );
      return;
    }

    setState(() {
      listaConsultasCadastradas.add({
        "nome": medico!,
        "especialidade": especialidade!,
        "data": "Agendado para $horario",
        "local": presencial ? "Presencial" : "Online",
        "status": "Agendada",
        "cor": Colors.orange,
      });
    });

    Navigator.pop(context); // Volta para a lista
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3498DB),
        title: const Text(
          "Nova consulta",
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
            _label("Nome do Médico"),
            _buildDropdown(
              ["Dra. Anna", "Dr. Marcos", "Dra. Beatriz"],
              medico,
              (v) => setState(() => medico = v),
            ),

            _label("Escolha a especialidade"),
            _buildDropdown(
              ["Dermatologia", "Cardiologia", "Geral"],
              especialidade,
              (v) => setState(() => especialidade = v),
            ),

            _label("Escolha um horário disponível"),
            _buildDropdown(
              ["09:00", "10:30", "15:00"],
              horario,
              (v) => setState(() => horario = v),
            ),

            _label("Tipo de atendimento"),
            _checkItem(
              "Presencial",
              presencial,
              (v) => setState(() => presencial = v!),
            ),
            _checkItem("Vídeo", video, (v) => setState(() => video = v!)),
            _checkItem("Chat", chat, (v) => setState(() => chat = v!)),

            const SizedBox(height: 30),
            _botaoAgendar(),
          ],
        ),
      ),
    );
  }

  // Widgets auxiliares mantidos e organizados
  Widget _label(String t) => Padding(
    padding: const EdgeInsets.only(top: 15, bottom: 5),
    child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _buildDropdown(
    List<String> itens,
    String? valor,
    Function(String?) onChange,
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
          hint: const Text("Selecione"),
          items: itens
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChange,
        ),
      ),
    );
  }

  Widget _checkItem(String t, bool v, Function(bool?) onChange) => Row(
    children: [
      Checkbox(value: v, onChanged: onChange),
      Text(t),
    ],
  );

  Widget _botaoAgendar() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2ECC71),
        padding: const EdgeInsets.all(15),
      ),
      onPressed: _salvarConsulta, // Agora chama a função de salvar
      child: const Text(
        "Agendar",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

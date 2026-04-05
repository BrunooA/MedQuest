import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/colors.dart'; // Importando suas cores centralizadas
import 'dados_temporarios.dart';

class NovoExameScreen extends StatefulWidget {
  const NovoExameScreen({super.key});

  @override
  State<NovoExameScreen> createState() => _NovoExameScreenState();
}

class _NovoExameScreenState extends State<NovoExameScreen> {
  String? exameSelecionado;
  final TextEditingController _medicoController = TextEditingController();
  final TextEditingController _obsController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // Função para abrir o menu de seleção de arquivo (IGUAL AO SEU PROTÓTIPO)
  void _mostrarOpcoesUpload() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 250,
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Adicionar arquivo",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _opcaoItem(Icons.photo_library_outlined, "da Galeria", ImageSource.gallery),
                  _opcaoItem(Icons.cloud_upload_outlined, "Upload", null),
                  _opcaoItem(Icons.camera_alt_outlined, "Tirar foto", ImageSource.camera),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _opcaoItem(IconData icon, String label, ImageSource? source) {
    return GestureDetector(
      onTap: () async {
        Navigator.pop(context);
        if (source != null) {
          final XFile? image = await _picker.pickImage(source: source);
          if (image != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Arquivo selecionado: ${image.name}")),
            );
          }
        }
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[100],
            child: Icon(icon, size: 30, color: AppColors.primaryBlue),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> opcoesExames = [
      'Cardiologia',
      'Clínico Geral',
      'Dermatologia',
      'Exame de Sangue',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text("Novo Exame", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
            const Text("Nome do Exame", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 8),
            _buildDropdown(opcoesExames),

            const SizedBox(height: 20),
            const Text("Nome do Médico", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 8),
            _buildTextField(_medicoController, "Ex: Dra. Anna"),

            const SizedBox(height: 20),
            const Text("Documento (Opcional)", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 8),
            _buildCaixaUpload(),

            const SizedBox(height: 20),
            const Text("Observações", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 8),
            _buildTextField(_obsController, "Ex: Jejum de 12 horas", maxLines: 3),

            const SizedBox(height: 40),
            _buildBotaoConfirmar(),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(List<String> opcoes) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: const Text("Selecione a especialidade"),
          value: exameSelecionado,
          items: opcoes.map((String v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
          onChanged: (val) => setState(() => exameSelecionado = val),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _buildCaixaUpload() {
    return GestureDetector(
      onTap: _mostrarOpcoesUpload,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F2F5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
        ),
        child: Column(
          children: [
            Icon(Icons.add_circle_outline, color: AppColors.primaryBlue, size: 35),
            const SizedBox(height: 10),
            const Text("Adicionar arquivo", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
            const Text("Formatos aceitos: JPG, PNG, PDF", style: TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildBotaoConfirmar() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryGreen,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        onPressed: () {
          if (exameSelecionado != null) {
            listaExamesCadastrados.add({
              'titulo': exameSelecionado!,
              'data': 'Agendado: Hoje às 14:30',
            });
            Navigator.pop(context);
          }
        },
        child: const Text("Confirmar Exame", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/colors.dart'; 
import 'dados_temporarios.dart';

class NovoExameScreen extends StatefulWidget {
  const NovoExameScreen({super.key});

  @override
  State<NovoExameScreen> createState() => _NovoExameScreenState();
}

class _NovoExameScreenState extends State<NovoExameScreen> {
  String? exameSelecionado;
  String? especialidadeSelecionada;
  String? horarioSelecionado;
  
  final TextEditingController _medicoController = TextEditingController();
  final TextEditingController _obsController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

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
          
          // CORREÇÃO AQUI: Verifica se o widget ainda está montado na árvore antes de usar o BuildContext
          if (!mounted) return;

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
      'Hemograma Completo',
      'Glicose em Jejum',
      'Colesterol Total e Frações',
      'Eletrocardiograma',
    ];

    final List<String> opcoesEspecialidades = [
      'Cardiologista',
      'Clínico Geral',
      'Dermatologia',
    ];

    final List<String> horariosDisponiveis = [
      'Segunda-feira às 09:00',
      'Terça-feira às 14:30',
      'Quarta-feira às 10:15',
      'Sexta-feira às 16:00',
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
            _buildDropdown("Selecione o Exame", exameSelecionado, opcoesExames, (val) {
              setState(() => exameSelecionado = val);
            }),

            const SizedBox(height: 20),
            const Text("Nome do Médico", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 8),
            _buildTextField(_medicoController, "Ex: Dra. Anna"),

            const SizedBox(height: 15),
            _buildDropdown("Selecione a Especialidade", especialidadeSelecionada, opcoesEspecialidades, (val) {
              setState(() => especialidadeSelecionada = val);
            }),

            const SizedBox(height: 15),
            const Text("Horário Disponível", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
            const SizedBox(height: 8),
            _buildDropdown("Escolha um horário disponível", horarioSelecionado, horariosDisponiveis, (val) {
              setState(() => horarioSelecionado = val);
            }),

            const SizedBox(height: 25),
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

  Widget _buildDropdown(String hint, String? value, List<String> opcoes, ValueChanged<String?> onChanged) {
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
          hint: Text(hint),
          value: value,
          items: opcoes.map((String v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
          onChanged: onChanged,
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
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F2F5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: AppColors.primaryBlue, size: 22),
                const SizedBox(width: 8),
                const Text("Adicionar arquivo", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 15)),
              ],
            ),
            const SizedBox(height: 5),
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
          if (exameSelecionado != null && horarioSelecionado != null) {
            listaExamesCadastrados.add({
              'titulo': exameSelecionado!,
              'data': 'Agendado: $horarioSelecionado',
            });
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Por favor, preencha o Exame e selecione um Horário!")),
            );
          }
        },
        child: const Text("Agendar", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
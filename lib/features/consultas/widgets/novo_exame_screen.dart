import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class NovoExameScreen extends StatefulWidget {
  const NovoExameScreen({super.key});

  @override
  State<NovoExameScreen> createState() => _NovoExameScreenState();
}

class _NovoExameScreenState extends State<NovoExameScreen> {
  // --- VARIÁVEIS DE ESTADO (Agora declaradas corretamente) ---
  final ImagePicker _picker = ImagePicker();
  String? medicoSolicitante;
  String? especialidadeSelecionada;

  // 1. 📸 BOTÃO "TIRAR FOTO"
  Future<void> _tirarFoto() async {
    // No Windows, isso geralmente abre o seletor de arquivos filtrando imagens
    // Se você instalou o 'image_picker_windows', ele tentará usar a API de mídia
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      print("Sucesso! Você 'tirou' uma foto: ${photo.name}");
    }
  }

  // 📂 BOTÃO UPLOAD (No Windows, vamos forçar só PDF)
  Future<void> _extrairArquivo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // <--- ISSO diferencia o botão no Windows!
    );

    if (result != null) {
      print("Você selecionou um PDF: ${result.files.single.name}");
    }
  }

  // 🖼️ BOTÃO GALERIA (No Windows, abre seletor de IMAGENS)
  Future<void> _pegarGaleria() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print("Você selecionou uma IMAGEM: ${image.name}");
    }
  }

  // MENU INFERIOR (BOTTOMSHEET)
  void _abrirMenuAnexo() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Como deseja adicionar o pedido?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _opcaoAnexo(
                  Icons.photo_library_outlined,
                  "da Galeria",
                  _pegarGaleria,
                ),
                _opcaoAnexo(
                  Icons.folder_open_outlined,
                  "Upload / PC",
                  _extrairArquivo,
                ),
                _opcaoAnexo(Icons.camera_alt_rounded, "Tirar foto", _tirarFoto),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _opcaoAnexo(IconData icon, String label, VoidCallback acao) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        acao();
      },
      child: Column(
        children: [
          Icon(icon, size: 35, color: Colors.blue),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // --- COMPONENTES VISUAIS ---
  Widget _label(String t) => Padding(
    padding: const EdgeInsets.only(top: 15, bottom: 5),
    child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
  );

  Widget _buildField(String h) => TextField(
    decoration: InputDecoration(
      hintText: h,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
  );

  Widget _buildDropdown(
    List<String> itens,
    String? valor,
    Function(String?) onC,
  ) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        value: valor,
        hint: const Text("Selecione"),
        items: itens
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onC,
      ),
    ),
  );

  Widget _botaoAgendar() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2ECC71),
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Exame agendado com sucesso!")),
        );
        Navigator.pop(context);
      },
      child: const Text(
        "Agendar",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text("Novo Exame", style: TextStyle(color: Colors.white)),
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
            _label("Nome do Exame"),
            _buildField("Ex: Hemograma"),

            _label("Nome do Médico"),
            _buildDropdown(["Dra. Anna", "Dr. João"], medicoSolicitante, (v) {
              setState(() => medicoSolicitante = v);
            }),

            _label("Especialidade"),
            _buildDropdown(
              ["Análises Clínicas", "Radiologia"],
              especialidadeSelecionada,
              (v) {
                setState(() => especialidadeSelecionada = v);
              },
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: _abrirMenuAnexo,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.withOpacity(0.3)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 20),
                    SizedBox(width: 10),
                    Text(
                      "Adicionar arquivo",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  "Formatos aceitos: JPG, PNG, PDF",
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
            ),

            _label("Observações"),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),
            _botaoAgendar(),
          ],
        ),
      ),
    );
  }
}

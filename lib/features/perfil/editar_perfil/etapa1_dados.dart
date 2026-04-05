import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../user_controller.dart';
import '../figma_styles.dart';

class Etapa1Dados extends StatefulWidget {
  final VoidCallback onNext;
  const Etapa1Dados({super.key, required this.onNext});

  @override
  State<Etapa1Dados> createState() => _Etapa1DadosState();
}

class _Etapa1DadosState extends State<Etapa1Dados> {
  final _telCont = TextEditingController();

  // Função para formatar telefone: +55 (27) 99999-9999
  void _formatarTelefone(String valor) {
    String numeros = valor.replaceAll(RegExp(r'\D'), '');
    if (numeros.length > 11) numeros = numeros.substring(0, 11);
    
    String formatado = "+55 ";
    if (numeros.length >= 2) {
      formatado += "(${numeros.substring(0, 2)}) ";
      if (numeros.length > 2) {
        if (numeros.length <= 7) {
          formatado += numeros.substring(2);
        } else {
          formatado += "${numeros.substring(2, 7)}-${numeros.substring(7)}";
        }
      }
    } else {
      formatado += numeros;
    }

    _telCont.value = TextEditingValue(
      text: formatado,
      selection: TextSelection.collapsed(offset: formatado.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            figmaHeader("Dados Pessoais", "1 \\ 4", 0.25),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(radius: 45, backgroundColor: Color(0xFFFFC0CB), child: Icon(Icons.person, size: 50, color: Colors.white)),
                  ),
                  const Align(alignment: Alignment.centerRight, child: Icon(Icons.lock_outline, color: Colors.orange, size: 20)),
                  
                  figmaLabel("Nome Completo (Gov.br)"),
                  TextField(controller: TextEditingController(text: userController.nome), readOnly: true, decoration: figmaInputDecoration.copyWith(filled: true, fillColor: Colors.grey[100])),
                  
                  figmaLabel("E-mail"),
                  TextField(controller: TextEditingController(text: userController.email), readOnly: true, decoration: figmaInputDecoration.copyWith(filled: true, fillColor: Colors.grey[100])),
                  
                  figmaLabel("Número de Telefone"),
                  TextField(
                    controller: _telCont,
                    keyboardType: TextInputType.phone,
                    onChanged: _formatarTelefone,
                    decoration: figmaInputDecoration.copyWith(hintText: "+55 (27) 99999-9999"),
                  ),
                  
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity, height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: colorFigmaGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      onPressed: widget.onNext,
                      child: const Text("Próximo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
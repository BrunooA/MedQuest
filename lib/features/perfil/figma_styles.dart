import 'package:flutter/material.dart';

// Cores exatas do Figma
const Color colorFigmaBlue = Color(0xFF3498DB);
const Color colorFigmaGreen = Color(0xFF2ECC71);
const Color colorFigmaGrayBg = Color(0xFFF5F7FB);
const Color colorFigmaInput = Color(0xFFE9EEF4);
const Color colorFigmaProgress = Color(0xFFBDDFFF);

// Configuração dos campos de texto (Inputs)
final InputDecoration figmaInputDecoration = InputDecoration(
  filled: true,
  fillColor: colorFigmaInput,
  hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
  ),
);

// Widget para os títulos dos campos
Widget figmaLabel(String texto) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6, top: 12),
    child: Text(
      texto,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13,
        color: Colors.black87,
      ),
    ),
  );
}

// Widget do Cabeçalho Azul com Barra de Progresso
Widget figmaHeader(String titulo, String passo, double progresso) {
  return Container(
    height: 150,
    width: double.infinity,
    decoration: const BoxDecoration(
      color: colorFigmaBlue,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
    ),
    child: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.arrow_back, color: Colors.white),
                Text(
                  passo,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            titulo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            width: 300,
            height: 4,
            decoration: BoxDecoration(
              color: colorFigmaProgress,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 300 * progresso,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

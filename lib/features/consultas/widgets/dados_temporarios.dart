import 'package:flutter/material.dart';

// Dados baseados no seu protótipo do Figma
final Map<String, List<String>> dadosMedicosPorEspecialidade = {
  "Cardiologia": ["Dr. Carlos Lima"],
  "Clínico Geral": ["Dr. João Silva", "Dra. Beatriz"],
  "Dermatologia": ["Dra. Anna"],
};

// Listas globais para persistência temporária
List<Map<String, String>> listaExamesCadastrados = [
  {"titulo": "Hemograma", "data": "10/03/2026"},
];

List<Map<String, dynamic>> listaConsultasCadastradas = [
  {
    "nome": "Dr. João Silva",
    "especialidade": "Clínico Geral",
    "data": "Hoje • 14:30",
    "local": "Online",
    "status": "Agendada",
    "cor": Colors.orange,
    "tipoAtendimento": "Vídeo",
  },
];

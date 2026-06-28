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
    "status": "Agendado", // Padronizado para bater com o _getStatusColor
    "tipoAtendimento": "Vídeo",
    "motivo": "Estou com dores de cabeça frequentes há 3 dias...", // Adicionado para o modal do Figma
  },
  {
    "nome": "Dr. Carlos Lima",
    "especialidade": "Cardiologia",
    "data": "05/03/2026 • 16:00",
    "local": "Presencial",
    "status": "Cancelada", // Ativa o botão "Reagendar" automaticamente no modal
    "tipoAtendimento": "Presencial",
    "motivo": "Check-up anual de rotina do coração.",
  },
];
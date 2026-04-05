class UserController {
  static final UserController _instance = UserController._internal();
  factory UserController() => _instance;
  UserController._internal();

  // Dados oficiais Gov.br
  String nome = "Irina S. Borges";
  String email = "irina.silva.borges@teste.com";
  String nascimento = "17/03/1998";
  String genero = "Feminino";

  // Saúde
  String peso = "";
  String altura = "";
  List<String> condicoes = [];
  List<String> alergias = []; 
  List<Map<String, String>> medicamentos = [];

  // Emergência
  String contatoEmergencia = "";
  String telefoneEmergencia = "";
  String parentescoEmergencia = ""; 
}

final userController = UserController();
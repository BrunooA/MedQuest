import 'package:flutter/material.dart';
import 'video_call_screen.dart';

class ChatScreen extends StatefulWidget {
  final VoidCallback? onBackToHome; // <--- ADICIONADO: Callback para voltar
  const ChatScreen({super.key, this.onBackToHome});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> mensagens = [
    {"texto": "Bom dia Doutora", "isMe": true, "hora": "08:50"},
    {
      "texto": "Você está podendo atender agora?",
      "isMe": true,
      "hora": "08:50",
    },
    {
      "texto":
          "Seu atendimento foi direcionado ao médico disponível. Aguarde, você será atendido em breve.",
      "isMe": false,
      "hora": "08:50",
    },
    {"texto": "Bom dia! estou sim!", "isMe": false, "hora": "08:50"},
    {"texto": "Em que posso te ajudar?", "isMe": false, "hora": "08:51"},
    {
      "texto": "Como você está se sentindo hoje?",
      "isMe": false,
      "hora": "08:51",
    },
    {
      "texto": "Tô com o corpo todo dolorido, meio febril e nariz entupido..",
      "isMe": true,
      "hora": "08:53",
    },
    {
      "isGif": true,
      "url": "https://media.giphy.com/media/l378giAZgxPw3QO52/giphy.gif",
      "isMe": true,
      "hora": "08:53",
    },
    {
      "texto": "Pelo que você descreveu, parece um quadro gripal mesmo! 🤒",
      "isMe": false,
      "hora": "08:56",
    },
    {
      "texto":
          "Tenta descansar bastante, beber bastante água e, se a febre subir, pode usar um remédio pra ajudar.",
      "isMe": false,
      "hora": "08:56",
    },
    {
      "texto":
          "Fica atenta: se piorar, tiver falta de ar ou não melhorar em alguns dias, é importante procurar atendimento presencial, tá?\nVou encerrar por aqui, mas qualquer dúvida pode me chamar!",
      "isMe": false,
      "hora": "08:56",
    },
    {"texto": "Tá Bom?", "isMe": false, "hora": "08:57"},
    {"texto": "Entendi, Obrigada doutora!", "isMe": true, "hora": "08:58"},
    {"texto": "Por nada, melhoras!", "isMe": false, "hora": "08:59"},
    {
      "texto": "Atendimento encerrado!",
      "isMe": false,
      "hora": "09:01",
      "isSystem": true,
    },
  ];

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D2C33),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(15),
              itemCount: mensagens.length,
              itemBuilder: (context, index) =>
                  _buildChatBubble(mensagens[index]),
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF333333),
      elevation: 0,
      leadingWidth: 75,
      leading: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
            onPressed: () {
              // CORREÇÃO FINAL: Se tiver o callback, volta pra aba Home.
              if (widget.onBackToHome != null) {
                widget.onBackToHome!();
              } else {
                Navigator.pop(context);
              }
            },
          ),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
        ],
      ),
      titleSpacing: 0,
      title: const Text(
        "Dra. Anna Silva",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.videocam, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VideoCallScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildChatBubble(Map<String, dynamic> msg) {
    bool isSystem = msg['isSystem'] ?? false;
    if (isSystem) {
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            msg['texto'],
            style: const TextStyle(color: Colors.white60, fontSize: 11),
          ),
        ),
      );
    }
    bool isMe = msg['isMe'] ?? false;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF25D366) : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          msg['texto'] ?? '',
          style: TextStyle(color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF333333),
                hintText: "Mensagem",
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          FloatingActionButton.small(
            backgroundColor: const Color(0xFF25D366),
            onPressed: () {
              if (_messageController.text.isNotEmpty) {
                setState(() {
                  mensagens.add({
                    "texto": _messageController.text,
                    "isMe": true,
                    "hora": "now",
                  });
                  _messageController.clear();
                });
                _scrollToBottom();
              }
            },
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

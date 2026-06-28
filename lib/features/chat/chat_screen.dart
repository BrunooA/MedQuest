import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import necessário para a área de transferência
import 'video_call_screen.dart';

class ChatScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;
  const ChatScreen({super.key, this.onBackToHome});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _atendimentoAtivo = false;

  // NOVO: Guarda a mensagem que o usuário escolheu responder
  Map<String, dynamic>? _mensagemRespondida;

  final List<Map<String, dynamic>> mensagens = [
    {
      "texto": "Atendimento encerrado!",
      "isMe": false,
      "hora": "09:01",
      "isSystem": true,
    },
    {"texto": "Por nada, melhoras!", "isMe": false, "hora": "08:59"},
    {"texto": "Entendi, Obrigada doutora!", "isMe": true, "hora": "08:58"},
    {"texto": "Tá Bom?", "isMe": false, "hora": "08:57"},
    {
      "texto":
          "Fica atenta: se piorar, tiver falta de ar ou não melhorar em alguns dias, é importante procurar atendimento presencial, tá?\nVou encerrar por aqui, mas qualquer dúvida pode me chamar!",
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
      "texto": "Pelo que você descreveu, parece um quadro gripal mesmo! 🤒",
      "isMe": false,
      "hora": "08:56",
    },
    {
      "isGif": true,
      "url": "assets/images/chorando.gif",
      "isMe": true,
      "hora": "08:53",
    },
    {
      "texto": "Tô com o corpo todo dolorido, meio febril e nariz entupido..",
      "isMe": true,
      "hora": "08:53",
    },
    {
      "texto": "Como você está se sentindo hoje?",
      "isMe": false,
      "hora": "08:51",
    },
    {"texto": "Em que posso te ajudar?", "isMe": false, "hora": "08:51"},
    {"texto": "Bom dia! estou sim!", "isMe": false, "hora": "08:50"},
    {
      "texto":
          "Seu atendimento foi direcionado ao médico disponível. Aguarde, você será atendido em breve.",
      "isMe": false,
      "hora": "08:50",
    },
    {
      "texto": "Você está podendo atender agora?",
      "isMe": true,
      "hora": "08:50",
    },
    {"texto": "Bom dia Doutora", "isMe": true, "hora": "08:50"},
  ];

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _processarRespostaBot() async {
    if (!_atendimentoAtivo) {
      _atendimentoAtivo = true;

      await Future.delayed(const Duration(milliseconds: 1500));
      if (!mounted) return;

      final TimeOfDay agora = TimeOfDay.now();
      final String horaFormatada =
          "${agora.hour.toString().padLeft(2, '0')}:${agora.minute.toString().padLeft(2, '0')}";

      setState(() {
        mensagens.insert(0, {
          "texto":
              "Seu atendimento foi direcionado ao médico disponível. Aguarde, você será atendido em breve.",
          "isMe": false,
          "hora": horaFormatada,
        });
      });
      _scrollToBottom();

      await Future.delayed(const Duration(seconds: 8));
      if (!mounted) return;

      if (_atendimentoAtivo) {
        final TimeOfDay horaFim = TimeOfDay.now();
        final String horaFimFormatada =
            "${horaFim.hour.toString().padLeft(2, '0')}:${horaFim.minute.toString().padLeft(2, '0')}";

        setState(() {
          _atendimentoAtivo = false;
          mensagens.insert(0, {
            "texto": "Atendimento encerrado!",
            "isMe": false,
            "hora": horaFimFormatada,
            "isSystem": true,
          });
        });
        _scrollToBottom();
      }
    }
  }

  void _mostrarOpcoesMensagem(
    BuildContext context,
    TapDownDetails details,
    Map<String, dynamic> msg,
  ) {
    final renderBox = context.findRenderObject() as RenderBox;

    showMenu<String>(
      context: context,
      color: const Color(0xFF222222),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        renderBox.size.width - details.globalPosition.dx,
        renderBox.size.height - details.globalPosition.dy,
      ),
      items: [
        PopupMenuItem<String>(
          value: 'responder',
          child: const Row(
            children: [
              Icon(Icons.reply, color: Colors.white70, size: 18),
              SizedBox(width: 12),
              Text('Responder', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'copiar',
          child: const Row(
            children: [
              Icon(Icons.copy, color: Colors.white70, size: 18),
              SizedBox(width: 12),
              Text('Copiar texto', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'apagar',
          child: const Row(
            children: [
              Icon(Icons.delete, color: Colors.redAccent, size: 18),
              SizedBox(width: 12),
              Text(
                'Apagar para mim',
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
        ),
      ],
    ).then((String? valorSelecionado) {
      if (valorSelecionado == null) return;

      if (valorSelecionado == 'copiar') {
        if (msg['texto'] != null) {
          Clipboard.setData(ClipboardData(text: msg['texto']));
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Texto copiado para a área de transferência!"),
            ),
          );
        }
      } else if (valorSelecionado == 'responder') {
        setState(() {
          _mensagemRespondida = msg;
        });
      } else if (valorSelecionado == 'apagar') {
        setState(() {
          mensagens.remove(msg);
        });
      }
    });
  }

  void _mostrarBarraReacoes(
    BuildContext context,
    TapDownDetails details,
    Map<String, dynamic> msg,
  ) {
    final renderBox = context.findRenderObject() as RenderBox;

    showMenu<String>(
      context: context,
      color: const Color(0xFF222222),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx - 100,
        details.globalPosition.dy - 60,
        renderBox.size.width - details.globalPosition.dx,
        renderBox.size.height - details.globalPosition.dy,
      ),
      items: [
        PopupMenuItem<String>(
          enabled: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['👍', '❤️', '😂', '😮', '😢', '🙏'].map((emoji) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    msg['reacao'] = emoji;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(emoji, style: const TextStyle(fontSize: 24)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
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
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
            msg['texto'] ?? '',
            style: const TextStyle(color: Colors.white60, fontSize: 11),
          ),
        ),
      );
    }

    bool isMe = msg['isMe'] ?? false;
    bool isGif = msg['isGif'] ?? false;
    String hora = msg['hora'] ?? '00:00';
    String? reacao = msg['reacao'];
    Map<String, dynamic>? resposta = msg['respostaContexto'];

    double larguraDisponivel = MediaQuery.of(context).size.width;
    double larguraMaximaBalao = larguraDisponivel > 800
        ? larguraDisponivel * 0.65
        : larguraDisponivel * 0.75;

    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setBubbleState) {
        return MouseRegion(
          onEnter: (_) => setBubbleState(() => isHovered = true),
          onExit: (_) => setBubbleState(() => isHovered = false),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Ícones de ação no Hover à esquerda (para minhas mensagens)
                    if (isMe && isHovered) ...[
                      _buildHoverIconButton(
                        Icons.sentiment_satisfied_outlined,
                        (details) =>
                            _mostrarBarraReacoes(context, details, msg),
                      ),
                      _buildHoverIconButton(
                        Icons.keyboard_arrow_down,
                        (details) =>
                            _mostrarOpcoesMensagem(context, details, msg),
                      ),
                    ],
                    Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isGif) ...[
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.all(3),
                            width: 240,
                            decoration: BoxDecoration(
                              color: isMe
                                  ? const Color(0xFF25D366)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                msg['url'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 4,
                              bottom: reacao != null ? 15 : 5,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isMe
                                  ? const Color(0xFF25D366)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  hora,
                                  style: TextStyle(
                                    color: isMe ? Colors.white : Colors.black45,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (isMe) ...[
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.done_all,
                                    size: 15,
                                    color: Color(0xFF34B7F1),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ] else ...[
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 5,
                            ).copyWith(bottom: reacao != null ? 15 : 5),
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 6,
                              left: 14,
                              right: 14,
                            ),
                            constraints: BoxConstraints(
                              maxWidth: larguraMaximaBalao,
                              minWidth: 100,
                            ),
                            decoration: BoxDecoration(
                              color: isMe
                                  ? const Color(0xFF25D366)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IntrinsicWidth(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (resposta != null)
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 6),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border(
                                          left: BorderSide(
                                            color: isMe
                                                ? Colors.white70
                                                : const Color(0xFF25D366),
                                            width: 4,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        resposta['texto'] ?? '[Mídia]',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: isMe
                                              ? Colors.white70
                                              : Colors.black54,
                                          fontSize: 13,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  Text(
                                    msg['texto'] ?? '',
                                    style: TextStyle(
                                      color: isMe
                                          ? Colors.white
                                          : Colors.black87,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        hora,
                                        style: TextStyle(
                                          color: isMe
                                              ? Colors.white70
                                              : Colors.black45,
                                          fontSize: 10,
                                        ),
                                      ),
                                      if (isMe) ...[
                                        const SizedBox(width: 4),
                                        const Icon(
                                          Icons.done_all,
                                          size: 14,
                                          color: Color(0xFF34B7F1),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    // Ícones de ação no Hover à direita (para mensagens da Doutora)
                    if (!isMe && isHovered) ...[
                      _buildHoverIconButton(
                        Icons.sentiment_satisfied_outlined,
                        (details) =>
                            _mostrarBarraReacoes(context, details, msg),
                      ),
                      _buildHoverIconButton(
                        Icons.keyboard_arrow_down,
                        (details) =>
                            _mostrarOpcoesMensagem(context, details, msg),
                      ),
                    ],
                  ],
                ),
              ),
              if (reacao != null)
                Positioned(
                  bottom: -2,
                  right: isMe ? 15 : null,
                  left: isMe ? null : 15,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF333333),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF0D2C33),
                        width: 2,
                      ),
                    ),
                    child: Text(reacao, style: const TextStyle(fontSize: 12)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // Widget utilitário para capturar a posição do clique dinamicamente ao disparar o menu
  Widget _buildHoverIconButton(
    IconData icon,
    Function(TapDownDetails) onPressedWithDetails,
  ) {
    TapDownDetails? currentDetails;
    return GestureDetector(
      onTapDown: (details) => currentDetails = details,
      onTap: () {
        if (currentDetails != null) {
          onPressedWithDetails(currentDetails!);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white60, size: 20),
      ),
    );
  }

  Widget _buildInputArea() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_mensagemRespondida != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            color: const Color(0xFF222222),
            child: Row(
              children: [
                const Icon(Icons.reply, color: Color(0xFF25D366), size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _mensagemRespondida!['isMe']
                            ? "Você"
                            : "Dra. Anna Silva",
                        style: const TextStyle(
                          color: Color(0xFF25D366),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        _mensagemRespondida!['texto'] ?? '[Mídia/GIF]',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white60,
                    size: 18,
                  ),
                  onPressed: () => setState(() => _mensagemRespondida = null),
                ),
              ],
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              const SizedBox(width: 8),
              FloatingActionButton.small(
                backgroundColor: const Color(0xFF25D366),
                onPressed: () {
                  if (_messageController.text.isNotEmpty) {
                    final TimeOfDay agora = TimeOfDay.now();
                    final String horaFormatada =
                        "${agora.hour.toString().padLeft(2, '0')}:${agora.minute.toString().padLeft(2, '0')}";

                    setState(() {
                      mensagens.insert(0, {
                        "texto": _messageController.text,
                        "isMe": true,
                        "hora": horaFormatada,
                        "respostaContexto": _mensagemRespondida,
                      });
                      _messageController.clear();
                      _mensagemRespondida = null;
                    });
                    _scrollToBottom();
                    _processarRespostaBot();
                  }
                },
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

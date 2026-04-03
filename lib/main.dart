import 'package:flutter/material.dart';

// 🔔 NOTIFICATION
import 'services/notification_service.dart';

// SPLASH
import 'splash/splash_screen.dart';

// AUTH
import 'features/auth/login_screen.dart';
import 'features/auth/loading_screen.dart';
import 'features/auth/cadastro_screen.dart';

// HOME
import 'features/home/home_screen.dart';

// CHECKIN
import 'features/checkin/checkin_screen.dart';

// EXAMES / CONSULTAS
import 'features/exames/exames_screen.dart';
import 'features/exames/novo_exame_screen.dart';
import 'features/consultas/consultas_screen.dart';
import 'features/consultas/nova_consulta_screen.dart';

// CHAT
import 'features/chat/chat_screen.dart';
import 'features/chat/video_call_screen.dart';

// PERFIL
import 'features/perfil/perfil_screen.dart';
import 'features/perfil/editar_perfil/etapa1_dados.dart';
import 'features/perfil/editar_perfil/etapa2_saude.dart';
import 'features/perfil/editar_perfil/etapa3_medicacoes.dart';
import 'features/perfil/editar_perfil/etapa4_emergencia.dart';

// 🚨 ALARME
import 'features/alarme/alarme_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();

  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MedQuest',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      initialRoute: '/',

      routes: {
        // SPLASH
        '/': (context) => const SplashScreen(),

        // AUTH
        '/login': (context) => const LoginScreen(),
        '/loading': (context) => const LoadingScreen(),
        '/cadastro': (context) => const CadastroScreen(),

        // HOME
        '/home': (context) => const HomeScreen(),

        // CHECKIN
        '/checkin': (context) => const CheckinScreen(),

        // EXAMES
        '/exames': (context) => const ExamesScreen(),
        '/novo-exame': (context) => const NovoExameScreen(),

        // CONSULTAS
        '/consultas': (context) => const ConsultasScreen(),
        '/nova-consulta': (context) => const NovaConsultaScreen(),

        // CHAT
        '/chat': (context) => const ChatScreen(),
        '/video-call': (context) => const VideoCallScreen(),

        // PERFIL
        '/perfil': (context) => const PerfilScreen(),

        // EDITAR PERFIL
        '/editar-perfil-1': (context) => const Etapa1Dados(),
        '/editar-perfil-2': (context) => const Etapa2Saude(),
        '/editar-perfil-3': (context) => const Etapa3Medicacoes(),
        '/editar-perfil-4': (context) => const Etapa4Emergencia(),

        // 🚨 ALARME
        '/alarme': (context) => const AlarmeScreen(),
      },
    );
  }
}
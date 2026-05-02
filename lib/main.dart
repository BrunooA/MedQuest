import 'package:flutter/material.dart';
import 'services/notification_service.dart';
import 'splash/splash_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/loading_screen.dart';
import 'features/home/home_screen.dart';
import 'features/checkin/checkin_screen.dart';
import 'features/consultas/widgets/consultas_exames_screen.dart';
import 'features/consultas/widgets/novo_exame_screen.dart';
import 'features/consultas/widgets/nova_consulta_screen.dart';
import 'features/chat/chat_screen.dart';
import 'features/chat/video_call_screen.dart';
import 'features/perfil/perfil_screen.dart';
import 'features/perfil/fluxo_cadastro_screen.dart';

// Importe o seu tema novo
import 'core/theme/app_theme.dart';

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
      // AGORA USANDO O SEU TEMA ORGANIZADO
      theme: AppTheme.lightTheme, 
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/loading': (context) => const LoadingScreen(),
        '/home': (context) => const HomeScreen(),
        '/checkin': (context) => const CheckinScreen(),
        '/consultas': (context) => const ConsultasExamesScreen(),
        '/exames': (context) => const ConsultasExamesScreen(),
        '/nova_consulta': (context) => const NovaConsultaScreen(),
        '/novo_exame': (context) => const NovoExameScreen(),
        '/chat': (context) => const ChatScreen(),
        '/video_call': (context) => const VideoCallScreen(),
        '/perfil': (context) => const PerfilScreen(),
        '/fluxo-cadastro': (context) => const FluxoCadastroScreen(),
      },
    );
  }
}
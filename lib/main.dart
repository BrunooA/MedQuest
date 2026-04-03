import 'package:flutter/material.dart';

// 🔔 SERVICES
import 'services/notification_service.dart';

// 🚀 SPLASH
import 'splash/splash_screen.dart';

// 🔐 AUTH
import 'features/auth/login_screen.dart';
import 'features/auth/loading_screen.dart';
import 'features/auth/cadastro_screen.dart';

// 🏠 HOME
import 'features/home/home_screen.dart';

// ✅ CHECKIN
import 'features/checkin/checkin_screen.dart';

// 🏥 EXAMES & CONSULTAS
import 'features/consultas/widgets/consultas_exames_screen.dart';
import 'features/consultas/widgets/novo_exame_screen.dart';
import 'features/consultas/widgets/nova_consulta_screen.dart';

// 💬 CHAT
import 'features/chat/chat_screen.dart';
import 'features/chat/video_call_screen.dart';

// 👤 PERFIL (CORREÇÃO DE CAMINHO)
// Importante: Verifique se o arquivo está mesmo nesta pasta
import 'features/perfil/perfil_screen.dart';
import 'features/perfil/fluxo_cadastro_screen.dart'; 

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
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/loading': (context) => const LoadingScreen(),
        '/cadastro': (context) => const CadastroScreen(),
        '/home': (context) => const HomeScreen(),
        '/checkin': (context) => const CheckinScreen(),
        '/consultas': (context) => const ConsultasExamesScreen(),
        '/exames': (context) => const ConsultasExamesScreen(),
        '/nova_consulta': (context) => const NovaConsultaScreen(),
        '/novo_exame': (context) => const NovoExameScreen(),
        '/chat': (context) => const ChatScreen(),
        '/video_call': (context) => const VideoCallScreen(),
        
        // --- CORREÇÃO AQUI: Removi o 'const' caso as classes tenham mudado ---
        '/perfil': (context) => PerfilScreen(), 
        '/fluxo-cadastro': (context) => FluxoCadastroScreen(),
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:fluxy/fluxy.dart';
import 'core/theme/fx_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/auth/auth_controller.dart';
import 'modules/layout/main_controller.dart';
import 'modules/auth/login_screen.dart';
import 'modules/layout/main_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FluxyPersistence.init();
  
  // Initialize Global Controllers
  Fluxy.put(AuthController());
  Fluxy.put(MainController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluxyApp(
        title: 'Fluxy Admin Dashboard',
        theme: AppTheme.lightTheme,
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF0F172A),
          colorScheme: ColorScheme.fromSeed(
            seedColor: FxColors.primary,
            brightness: Brightness.dark,
            background: const Color(0xFF0F172A),
          ),
        ),
        initialRoute: FxRoute(
          path: '/',
          builder: (params, args) => const LoginScreen(),
        ),
        routes: [
          FxRoute(
            path: '/',
            builder: (params, args) => const LoginScreen(),
          ),
          FxRoute(
            path: '/dashboard',
            builder: (params, args) => const MainLayout(),
          ),
        ],
    );
  }
}

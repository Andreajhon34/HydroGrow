import 'package:flutter/material.dart';
import 'core/theme/theme.dart';
import 'features/auth/screens/login_screen.dart';

void main() {
  runApp(const HydroGrowApp());
}

class HydroGrowApp extends StatelessWidget {
  const HydroGrowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HydroGrow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'core/state/app_state.dart';
import 'core/theme/theme.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/navigation/main_navigation_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HydroGrowApp());
}

class HydroGrowApp extends StatefulWidget {
  const HydroGrowApp({super.key});

  @override
  State<HydroGrowApp> createState() => _HydroGrowAppState();
}

class _HydroGrowAppState extends State<HydroGrowApp> {
  late final AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = AppState();
  }

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      notifier: _appState,
      child: MaterialApp(
        title: 'HydroGrow',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        initialRoute: LoginScreen.routeName,
        routes: {
          LoginScreen.routeName: (_) => const LoginScreen(),
          MainNavigationShell.routeName: (_) => const MainNavigationShell(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../core/state/app_state.dart';
import '../explore/screens/explore_screen.dart';
import '../garden/screens/my_garden_screen.dart';
import '../impact/screens/impact_screen.dart';
import '../plant_care/screens/plant_care_screen.dart';
import 'widgets/custom_bottom_nav_bar.dart';

/// Main Application Shell containing the persistent Bottom Navigation Bar
/// and switching between primary screen destinations using an [IndexedStack].
class MainNavigationShell extends StatelessWidget {
  const MainNavigationShell({super.key});

  static const routeName = '/main';

  static const List<Widget> _screens = [
    MyGardenScreen(),
    ExploreScreen(),
    PlantCareScreen(),
    ImpactScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final activeIndex = appState.currentNavIndex.clamp(0, _screens.length - 1);

    return Scaffold(
      body: IndexedStack(
        index: activeIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: activeIndex,
        onTap: (index) => appState.setNavIndex(index),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/models/lesson_model.dart';
import '../../../core/models/project_model.dart';
import '../../../core/state/app_state.dart';
import '../../../core/theme/theme.dart';
import '../../planner/screens/urban_space_planner_screen.dart';
import '../widgets/daily_checklist_card.dart';
import '../widgets/empty_garden_state.dart';
import '../widgets/garden_header.dart';
import '../widgets/lesson_card.dart';
import '../widgets/project_carousel.dart';

/// Primary Dashboard Screen for "My Garden".
/// Displays active projects, daily actionable checklist, and daily micro-lessons.
class MyGardenScreen extends StatelessWidget {
  const MyGardenScreen({super.key});

  void _showProjectOptions(BuildContext context, PlantingProject project) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final appState = AppStateScope.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : AppColors.cardLight,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.borderDark
                          : AppColors.borderLight,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  project.plantName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${project.systemType} • ${project.growthStage}',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: isDark
                        ? AppColors.mutedForegroundDark
                        : AppColors.mutedForegroundLight,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(
                    Icons.water_drop_outlined,
                    color: AppColors.primary,
                  ),
                  title: const Text('Target Nutrisi & pH'),
                  subtitle: Text(
                    'PPM: ${project.targetPpm} | pH: ${project.targetPh}',
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.primary,
                  ),
                  title: const Text('Mulai Tanam'),
                  subtitle: Text('${project.currentDay} hari yang lalu'),
                  contentPadding: EdgeInsets.zero,
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.destructiveLight,
                  ),
                  title: const Text(
                    'Hapus Proyek Ini',
                    style: TextStyle(color: AppColors.destructiveLight),
                  ),
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    Navigator.pop(ctx);
                    appState.removeProject(project.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Proyek ${project.plantName} telah dihapus.',
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final projects = appState.activeProjects;
    final tasks = appState.dailyTasks;
    final featuredLesson = SampleLessons.lessons.first;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 600));
          },
          child: ListView(
            padding: const EdgeInsets.only(bottom: 100),
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children: [
              // ── Header ────────────────────────────────────────────────────
              const GardenHeader(),
              const SizedBox(height: 8),

              // ── Active Projects Carousel OR Empty State ────────────────────
              if (projects.isNotEmpty)
                ProjectCarousel(
                  projects: projects,
                  onProjectTap: (proj) => _showProjectOptions(context, proj),
                  onAddNewTap: () => appState.setNavIndex(1), // Go to Explore
                )
              else
                EmptyGardenState(
                  onExplorePlantsTap: () => appState.setNavIndex(1),
                  onPlanSpaceTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const UrbanSpacePlannerScreen(),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 24),

              // ── Daily Checklist ───────────────────────────────────────────
              DailyChecklistCard(
                tasks: tasks,
                onTaskToggle: (id) => appState.toggleTask(id),
              ),
              const SizedBox(height: 24),

              // ── Daily Hydroponic Micro-Lesson ─────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_stories_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Pojok Edukasi Hari Ini',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.foregroundDark
                            : AppColors.foregroundLight,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              LessonCard(lesson: featuredLesson),
            ],
          ),
        ),
      ),
    );
  }
}

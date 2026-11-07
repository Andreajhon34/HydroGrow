import 'package:flutter/material.dart';
import '../models/daily_task_model.dart';
import '../models/harvest_record_model.dart';
import '../models/plant_model.dart';
import '../models/project_model.dart';
import '../models/surplus_item_model.dart';

/// Central reactive state for the HydroGrow application.
/// Manages active projects, daily tasks, harvest logs, navigation index,
/// and community surplus items (SDG 2).
class AppState extends ChangeNotifier {
  AppState() {
    _activeProjects = List.from(SampleProjects.initialProjects);
    _dailyTasks = List.from(SampleDailyTasks.initialTasks);
    _harvestHistory = [
      HarvestRecord(
        id: 'rec_1',
        plantName: 'Kangkung Air (Panen 1)',
        weightGrams: 450,
        harvestDate: DateTime.now().subtract(const Duration(days: 7)),
        notes: 'Segar renyah, cukup untuk sayur tumis sekeluarga!',
        estimatedSavingsRp: 15000,
      ),
      HarvestRecord(
        id: 'rec_2',
        plantName: 'Pakcoy Hijau (Panen Mini)',
        weightGrams: 350,
        harvestDate: DateTime.now().subtract(const Duration(days: 14)),
        notes: 'Panen tahap pertama dari botol bekas 1.5L.',
        estimatedSavingsRp: 12500,
      ),
    ];
    _surplusItems = List.from(SampleSurplusItems.initialItems);
  }

  // ─── Active Projects ───────────────────────────────────────────────────────
  late List<PlantingProject> _activeProjects;
  List<PlantingProject> get activeProjects => List.unmodifiable(_activeProjects);

  void addProjectFromPlant(Plant plant, {String? customSystem}) {
    final newProject = PlantingProject(
      id: 'proj_${DateTime.now().millisecondsSinceEpoch}',
      plantId: plant.id,
      plantName: plant.name,
      currentDay: 1,
      totalDays: plant.harvestDaysMin,
      growthStage: 'Tahap Semai & Sprout',
      nextMilestone: 'Cek perkecambahan benih dalam 2 hari',
      nextMilestoneInDays: 2,
      systemType: customSystem ?? plant.recommendedMethod,
      startDate: DateTime.now(),
      imageUrl: plant.imageUrl,
      targetPpm: plant.ppmRange,
      targetPh: plant.phRange,
    );
    _activeProjects.insert(0, newProject);

    // Also add an introductory task
    _dailyTasks.insert(
      0,
      DailyTask(
        id: 'task_${DateTime.now().millisecondsSinceEpoch}',
        title: 'Semai benih ${plant.name}',
        subtitle: 'Lembapkan media semai dan letakkan di tempat teduh',
        plantTarget: plant.name,
        isCompleted: false,
        category: TaskCategory.maintenance,
      ),
    );

    notifyListeners();
  }

  void removeProject(String id) {
    _activeProjects.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  // ─── Daily Tasks ───────────────────────────────────────────────────────────
  late List<DailyTask> _dailyTasks;
  List<DailyTask> get dailyTasks => List.unmodifiable(_dailyTasks);

  int get completedTasksCount =>
      _dailyTasks.where((t) => t.isCompleted).length;

  int get totalTasksCount => _dailyTasks.length;

  double get taskCompletionRatio =>
      totalTasksCount > 0 ? completedTasksCount / totalTasksCount : 0.0;

  void toggleTask(String id) {
    final index = _dailyTasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _dailyTasks[index].isCompleted = !_dailyTasks[index].isCompleted;
      notifyListeners();
    }
  }

  // ─── Harvest Records & SDG 2 Metrics ───────────────────────────────────────
  late List<HarvestRecord> _harvestHistory;
  List<HarvestRecord> get harvestHistory => List.unmodifiable(_harvestHistory);

  void addHarvestRecord(HarvestRecord record) {
    _harvestHistory.insert(0, record);
    notifyListeners();
  }

  int get totalHarvestWeightGrams =>
      _harvestHistory.fold(0, (sum, r) => sum + r.weightGrams);

  int get totalEstimatedSavingsRp =>
      _harvestHistory.fold(0, (sum, r) => sum + r.estimatedSavingsRp);

  /// 1 serving of vegetables ~ 75 grams (WHO standard)
  int get estimatedNutritiousPortions =>
      (totalHarvestWeightGrams / 75).floor();

  /// Estimated food miles & transport CO2e saved (approx 2 kg CO2e / kg food grown locally)
  double get estimatedCo2SavedKg =>
      (totalHarvestWeightGrams / 1000) * 2.0;

  /// Self-sufficiency percentage of a household benchmark (e.g. target 2500g/month)
  double get monthlySelfSufficiencyPercent =>
      ((totalHarvestWeightGrams / 2500) * 100).clamp(0.0, 100.0);

  // ─── Community Surplus Items (OLIO Style) ──────────────────────────────────
  late List<SurplusItem> _surplusItems;
  List<SurplusItem> get surplusItems => List.unmodifiable(_surplusItems);

  void addSurplusItem(SurplusItem item) {
    _surplusItems.insert(0, item);
    notifyListeners();
  }

  void toggleSurplusAvailability(String id) {
    final idx = _surplusItems.indexWhere((item) => item.id == id);
    if (idx != -1) {
      _surplusItems[idx].isAvailable = !_surplusItems[idx].isAvailable;
      notifyListeners();
    }
  }

  // ─── Navigation Index ──────────────────────────────────────────────────────
  int _currentNavIndex = 0;
  int get currentNavIndex => _currentNavIndex;

  void setNavIndex(int index) {
    if (_currentNavIndex != index) {
      _currentNavIndex = index;
      notifyListeners();
    }
  }

  // ─── Explore Filter State ──────────────────────────────────────────────────
  String _exploreFilter = 'Semua';
  String get exploreFilter => _exploreFilter;

  void setExploreFilter(String filter) {
    if (_exploreFilter != filter) {
      _exploreFilter = filter;
      notifyListeners();
    }
  }
}

/// InheritedWidget provider for [AppState] so any descendant can access it.
class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    super.key,
    required AppState super.notifier,
    required super.child,
  });

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'No AppStateScope found in context');
    return scope!.notifier!;
  }
}

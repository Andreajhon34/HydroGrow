/// Interactive daily checklist task for hydroponic maintenance.
class DailyTask {
  DailyTask({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.plantTarget,
    this.isCompleted = false,
    this.category = TaskCategory.maintenance,
    this.hasCalculatorShortcut = false,
  });

  final String id;
  final String title;
  final String subtitle;
  final String plantTarget;
  bool isCompleted;
  final TaskCategory category;
  final bool hasCalculatorShortcut;
}

enum TaskCategory {
  water('Air & Tandon'),
  nutrient('Nutrisi AB Mix'),
  leafCheck('Inspeksi Daun'),
  maintenance('Perawatan');

  const TaskCategory(this.label);
  final String label;
}

abstract final class SampleDailyTasks {
  static List<DailyTask> initialTasks = [
    DailyTask(
      id: 'task_1',
      title: 'Periksa ketinggian air tandon',
      subtitle: 'Pastikan 1/3 akar tetap bernapas (ruang udara)',
      plantTarget: 'Pakcoy & Kangkung',
      isCompleted: true,
      category: TaskCategory.water,
    ),
    DailyTask(
      id: 'task_2',
      title: 'Ukur kepekatan PPM & tambah AB Mix',
      subtitle: 'Target Pakcoy: 1050 - 1200 PPM',
      plantTarget: 'Pakcoy Hijau',
      isCompleted: false,
      category: TaskCategory.nutrient,
      hasCalculatorShortcut: true,
    ),
    DailyTask(
      id: 'task_3',
      title: 'Inspeksi bagian balik daun',
      subtitle: 'Waspadai kutu daun hijau atau ulat pemakan tunas',
      plantTarget: 'Selada Keriting',
      isCompleted: false,
      category: TaskCategory.leafCheck,
    ),
    DailyTask(
      id: 'task_4',
      title: 'Putar posisi botol ke arah matahari',
      subtitle: 'Agar pertumbuhan batang lurus merata',
      plantTarget: 'Semua Tanaman',
      isCompleted: false,
      category: TaskCategory.maintenance,
    ),
  ];
}

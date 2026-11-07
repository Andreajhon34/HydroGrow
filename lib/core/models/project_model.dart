/// Represents an active planting project tracked in "My Garden".
class PlantingProject {
  PlantingProject({
    required this.id,
    required this.plantId,
    required this.plantName,
    required this.currentDay,
    required this.totalDays,
    required this.growthStage,
    required this.nextMilestone,
    required this.nextMilestoneInDays,
    required this.systemType,
    required this.startDate,
    required this.imageUrl,
    this.targetPpm = '1050 - 1400',
    this.targetPh = '6.0 - 6.5',
  });

  final String id;
  final String plantId;
  final String plantName;
  int currentDay;
  final int totalDays;
  String growthStage;
  String nextMilestone;
  int nextMilestoneInDays;
  final String systemType;
  final DateTime startDate;
  final String imageUrl;
  final String targetPpm;
  final String targetPh;

  double get progress => (currentDay / totalDays).clamp(0.0, 1.0);
  int get progressPercent => (progress * 100).round();
  int get remainingDays => (totalDays - currentDay).clamp(0, totalDays);
}

/// Sample starting active projects for new/demo users.
abstract final class SampleProjects {
  static List<PlantingProject> initialProjects = [
    PlantingProject(
      id: 'proj_pakcoy_1',
      plantId: 'pakcoy',
      plantName: 'Pakcoy Hijau',
      currentDay: 12,
      totalDays: 30,
      growthStage: 'Fase Vegetatif Cepat',
      nextMilestone: 'Cek kepekatan nutrisi AB Mix & ketinggian air',
      nextMilestoneInDays: 2,
      systemType: 'Wick System (Botol 1.5L)',
      startDate: DateTime.now().subtract(const Duration(days: 12)),
      imageUrl: 'https://images.unsplash.com/photo-1708798534031-3711ec8cc16e?auto=format&fit=crop&w=800&q=80',
      targetPpm: '1050 - 1200 PPM',
      targetPh: '6.0 - 6.5',
    ),
    PlantingProject(
      id: 'proj_kangkung_1',
      plantId: 'kangkung',
      plantName: 'Kangkung Air',
      currentDay: 18,
      totalDays: 24,
      growthStage: 'Menjelang Panen',
      nextMilestone: 'Panen tahap pertama (potong pucuk)',
      nextMilestoneInDays: 3,
      systemType: 'Baskom & Besek Lubang',
      startDate: DateTime.now().subtract(const Duration(days: 18)),
      imageUrl: 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?auto=format&fit=crop&w=800&q=80',
      targetPpm: '1200 - 1400 PPM',
      targetPh: '5.8 - 6.5',
    ),
    PlantingProject(
      id: 'proj_selada_1',
      plantId: 'selada',
      plantName: 'Selada Keriting',
      currentDay: 6,
      totalDays: 40,
      growthStage: 'Pindah Tanam (Bibit)',
      nextMilestone: 'Aklimatisasi sinar matahari pagi',
      nextMilestoneInDays: 1,
      systemType: 'Kratky Jar Balkon',
      startDate: DateTime.now().subtract(const Duration(days: 6)),
      imageUrl: 'https://images.unsplash.com/photo-1622206151226-18ca2c9ab4a1?auto=format&fit=crop&w=800&q=80',
      targetPpm: '560 - 700 PPM',
      targetPh: '5.8 - 6.2',
    ),
  ];
}

/// Model for neighborhood seed & surplus harvest sharing (inspired by OLIO).
/// Supports SDG 2 — Zero Hunger by reducing urban food waste and distributing nutrition.

enum SurplusType {
  free('GRATIS', 0xFF24C46E),
  barter('BARTER / TUKAR', 0xFF3B82F6);

  const SurplusType(this.label, this.colorValue);
  final String label;
  final int colorValue;
}

enum SurplusCategory {
  seedlings('Bibit Gratis'),
  harvest('Tukar Panen'),
  equipment('Wadah & Alat');

  const SurplusCategory(this.label);
  final String label;
}

class SurplusItem {
  SurplusItem({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.donorName,
    required this.donorLocation,
    required this.distanceKm,
    required this.quantity,
    required this.postedTimeAgo,
    required this.imageUrl,
    this.isAvailable = true,
  });

  final String id;
  final String title;
  final String description;
  final SurplusType type;
  final SurplusCategory category;
  final String donorName;
  final String donorLocation;
  final double distanceKm;
  final String quantity;
  final String postedTimeAgo;
  final String imageUrl;
  bool isAvailable;

  String get formattedDistance =>
      '${distanceKm.toStringAsFixed(1)} km dari Anda';
}

abstract final class SampleSurplusItems {
  static List<SurplusItem> initialItems = [
    SurplusItem(
      id: 'surplus_1',
      title: 'Kelebihan 15 Semai Kangkung Daun',
      description: 'Kemarin semai 1 baki penuh kangkung, hanya muat 12 di sistem wick saya. Sisanya 15 semaian sehat berdaun 3 helai siap diadopsi gratis tetangga!',
      type: SurplusType.free,
      category: SurplusCategory.seedlings,
      donorName: 'Rian Pratama',
      donorLocation: 'Apartemen Green Pramuka',
      distanceKm: 0.6,
      quantity: '15 Semai Kangkung',
      postedTimeAgo: '35 mnt lalu',
      imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=600&q=80',
    ),
    SurplusItem(
      id: 'surplus_2',
      title: 'Panen Selada Keriting 400g (Barter Benih Tomat)',
      description: 'Panen selada siang ini terlalu melimpah untuk konsumsi berdua. Mau barter dengan bibit tomat cherry atau cabe rawit untuk balkon.',
      type: SurplusType.barter,
      category: SurplusCategory.harvest,
      donorName: 'Sarah Amalia',
      donorLocation: 'Komp. Melati Indah',
      distanceKm: 1.2,
      quantity: '400 gram Selada',
      postedTimeAgo: '2 jam lalu',
      imageUrl: 'https://images.unsplash.com/photo-1622206151226-18ca2c9ab4a1?auto=format&fit=crop&w=600&q=80',
    ),
    SurplusItem(
      id: 'surplus_3',
      title: '8 Netpot 5cm + Potongan Sumbu Flanel',
      description: 'Ada netpot lebih bekas proyek hidroponik lama, kondisi bersih sudah dicuci desinfektan. Siap diambil gratis untuk pemula yang butuh.',
      type: SurplusType.free,
      category: SurplusCategory.equipment,
      donorName: 'Budi Santoso',
      donorLocation: 'Jl. Tebet Barat Dalam',
      distanceKm: 1.8,
      quantity: '8 pcs Netpot + Flanel',
      postedTimeAgo: '5 jam lalu',
      imageUrl: 'https://images.unsplash.com/photo-1585320806297-9794b3e4eeae?auto=format&fit=crop&w=600&q=80',
    ),
    SurplusItem(
      id: 'surplus_4',
      title: 'Pakcoy Hijau Renyah 500g (Panen Segar Hari Ini)',
      description: 'Baru dipotong pagi ini dari sistem rakit apung styrofoam. Bebas pestisida 100%. Bagi yang dekat boleh mampir bawa wadah sendiri.',
      type: SurplusType.free,
      category: SurplusCategory.harvest,
      donorName: 'Ibu Heni',
      donorLocation: 'Jl. Pancoran Timur',
      distanceKm: 2.4,
      quantity: '500 gram (4 bonggol)',
      postedTimeAgo: 'Kemarin',
      imageUrl: 'https://images.unsplash.com/photo-1708798534031-3711ec8cc16e?auto=format&fit=crop&w=600&q=80',
    ),
  ];
}

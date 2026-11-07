/// Difficulty level for growing plants in hydroponic setups.
enum PlantDifficulty {
  beginner('Sangat Mudah'),
  easy('Mudah'),
  moderate('Sedang'),
  advanced('Menengah');

  const PlantDifficulty(this.label);
  final String label;
}

/// Category of the plant.
enum PlantCategory {
  leafyGreens('Sayuran Daun'),
  herbs('Herba & Rempah'),
  fruiting('Tanaman Buah');

  const PlantCategory(this.label);
  final String label;
}

/// Comprehensive model for hydroponic plant guides.
class Plant {
  const Plant({
    required this.id,
    required this.name,
    required this.latinName,
    required this.category,
    required this.difficulty,
    required this.harvestDaysMin,
    required this.harvestDaysMax,
    required this.phRange,
    required this.ppmRange,
    required this.sunlightHours,
    required this.recommendedMethod,
    required this.shortDescription,
    required this.fullDescription,
    required this.imageUrl,
    required this.isLowLightTolerant,
    required this.isFastHarvest,
    required this.steps,
    required this.tips,
  });

  final String id;
  final String name;
  final String latinName;
  final PlantCategory category;
  final PlantDifficulty difficulty;
  final int harvestDaysMin;
  final int harvestDaysMax;
  final String phRange;
  final String ppmRange;
  final String sunlightHours;
  final String recommendedMethod;
  final String shortDescription;
  final String fullDescription;
  final String imageUrl;
  final bool isLowLightTolerant;
  final bool isFastHarvest;
  final List<PlantGrowthStep> steps;
  final List<String> tips;

  String get harvestDuration => '$harvestDaysMin - $harvestDaysMax Hari';
}

/// Step-by-step planting guide milestone.
class PlantGrowthStep {
  const PlantGrowthStep({
    required this.dayRange,
    required this.title,
    required this.description,
    required this.targetPpm,
  });

  final String dayRange;
  final String title;
  final String description;
  final String targetPpm;
}

/// Curated sample plant dataset for HydroGrow.
abstract final class SamplePlants {
  static const List<Plant> plants = [
    Plant(
      id: 'kangkung',
      name: 'Kangkung Air',
      latinName: 'Ipomoea aquatica',
      category: PlantCategory.leafyGreens,
      difficulty: PlantDifficulty.beginner,
      harvestDaysMin: 21,
      harvestDaysMax: 25,
      phRange: '5.5 - 6.5',
      ppmRange: '1050 - 1400',
      sunlightHours: '4 - 6 Jam/Hari',
      recommendedMethod: 'Sistem Wick (Sumbu) / Besek',
      shortDescription: 'Juara tumbuh cepat untuk pemula. Sangat tahan banting dan cocok dengan wadah baskom/besek.',
      fullDescription: 'Kangkung adalah tanaman hidroponik nomor satu yang paling direkomendasikan bagi pemula di perkotaan. Tanaman ini memiliki adaptasi sangat tinggi, tidak mudah layu, dan dapat dipanen berulang kali (regrowth) dalam kurun waktu 3 minggu.',
      imageUrl: 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?auto=format&fit=crop&w=800&q=80',
      isLowLightTolerant: true,
      isFastHarvest: true,
      steps: [
        PlantGrowthStep(
          dayRange: 'Hari 1 - 3',
          title: 'Penyemaian Benih',
          description: 'Rendam benih kangkung di air hangat 2-3 jam, tebar merata di atas rockwool basah atau saringan.',
          targetPpm: 'Air Baku (0 - 300 PPM)',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 4 - 10',
          title: 'Pertunasan Awal (Sprout)',
          description: 'Pindahkan ke area terkena cahaya pagi. Mulai kenalkan nutrisi AB Mix encer.',
          targetPpm: '500 - 600 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 11 - 18',
          title: 'Fase Vegetatif Cepat',
          description: 'Akar mulai gondrong ke dalam bak air. Naikkan kepekatan nutrisi dan pastikan air tidak surut.',
          targetPpm: '1000 - 1200 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 19 - 25',
          title: 'Fase Siap Panen',
          description: 'Batang sudah mencapai 20-25 cm dengan daun rimbun. Potong 3 cm di atas pangkal akar.',
          targetPpm: '1200 - 1400 PPM',
        ),
      ],
      tips: [
        'Gunakan baskom dengan saringan dapur bekas untuk sistem tanpa rockwool.',
        'Potong bagian atas saat panen dan biarkan batangnya bertunas lagi untuk panen kedua!',
        'Pastikan wadah tidak terkena panas terik agar air larutan nutrisi tidak mendidih.',
      ],
    ),
    Plant(
      id: 'pakcoy',
      name: 'Pakcoy Hijau',
      latinName: 'Brassica rapa subsp. chinensis',
      category: PlantCategory.leafyGreens,
      difficulty: PlantDifficulty.beginner,
      harvestDaysMin: 28,
      harvestDaysMax: 35,
      phRange: '6.0 - 7.0',
      ppmRange: '1050 - 1400',
      sunlightHours: '5 - 7 Jam/Hari',
      recommendedMethod: 'Kratky / Wick System',
      shortDescription: 'Tekstur renyah, kaya vitamin A & C. Sangat populer untuk tumisan keluarga sehat.',
      fullDescription: 'Pakcoy (sendok hijau) adalah tanaman sayur favorit urban farmer. Batangnya tebal dan renyah. Sangat efisien ditanam di botol mineral bekas 1.5 Liter menggunakan metode sumbu kain flanel.',
      imageUrl: 'https://images.unsplash.com/photo-1708798534031-3711ec8cc16e?auto=format&fit=crop&w=800&q=80',
      isLowLightTolerant: false,
      isFastHarvest: true,
      steps: [
        PlantGrowthStep(
          dayRange: 'Hari 1 - 4',
          title: 'Semai di Rockwool',
          description: 'Letakkan 1 benih per lubang rockwool (ukuran 2.5x2.5 cm). Lembapkan dan simpan di tempat teduh.',
          targetPpm: 'Air Baku (0 PPM)',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 5 - 12',
          title: 'Bibit Berdaun 4',
          description: 'Setelah muncul 3-4 daun sejati, pindahkan netpot ke botol/sistem pembesaran dengan sumbu.',
          targetPpm: '600 - 800 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 13 - 25',
          title: 'Pembentukan Batang Sendok',
          description: 'Daun melebar menyerupai sendok. Tingkatkan intensitas matahari dan nutrisi harian.',
          targetPpm: '1050 - 1200 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 26 - 35',
          title: 'Panen Maksimal',
          description: 'Panen saat daun masih hijau cerah sebelum tanaman mulai membentuk bunga.',
          targetPpm: '1200 - 1400 PPM',
        ),
      ],
      tips: [
        'Bila daun menguning di ujung, cek apakah PPM air terlalu pekat.',
        'Waspadai ulat kecil di bawah daun; semprot dengan larutan sabun organik bila perlu.',
      ],
    ),
    Plant(
      id: 'selada',
      name: 'Selada Keriting',
      latinName: 'Lactuca sativa',
      category: PlantCategory.leafyGreens,
      difficulty: PlantDifficulty.easy,
      harvestDaysMin: 35,
      harvestDaysMax: 42,
      phRange: '5.8 - 6.5',
      ppmRange: '560 - 840',
      sunlightHours: '4 - 5 Jam/Hari',
      recommendedMethod: 'NFT / Wick System / Rak Pipa',
      shortDescription: 'Sayuran salad segar premium. Membutuhkan nutrisi rendah dan suhu air yang sejuk.',
      fullDescription: 'Selada keriting hijau sangat disukai karena rasanya manis segar dan tidak pahit jika ditanam secara hidroponik. Selada lebih menyukai kondisi sejuk dan tidak terlalu tahan panas ekstrem perkotaan.',
      imageUrl: 'https://images.unsplash.com/photo-1622206151226-18ca2c9ab4a1?auto=format&fit=crop&w=800&q=80',
      isLowLightTolerant: true,
      isFastHarvest: false,
      steps: [
        PlantGrowthStep(
          dayRange: 'Hari 1 - 5',
          title: 'Perkecambahan Dingin',
          description: 'Benih selada berkecambah optimal pada suhu sejuk. Jaga kelembapan media semai.',
          targetPpm: 'Air Baku (0 PPM)',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 6 - 15',
          title: 'Pindah Tanam Netpot',
          description: 'Pindahkan saat akar sudah menembus rockwool. Letakkan di tempat ternaungi dari terik siang.',
          targetPpm: '400 - 560 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 16 - 30',
          title: 'Pembesaran Daun Keriting',
          description: 'Daun mulai bergelombang rimbun. Selada sangat sensitif over-nutrition (daun terbakar).',
          targetPpm: '600 - 800 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 31 - 42',
          title: 'Panen Segar',
          description: 'Cabut seluruh tanaman bersama akarnya agar tetap segar lebih lama saat disimpan di kulkas.',
          targetPpm: '700 - 840 PPM',
        ),
      ],
      tips: [
        'Jangan berikan nutrisi terlalu pekat karena selada mudah mengalami tip-burn (ujung daun kering).',
        'Letakkan di jendela timur yang hanya mendapat sinar pagi lembut.',
      ],
    ),
    Plant(
      id: 'bayam',
      name: 'Bayam Hijau',
      latinName: 'Amaranthus tricolor',
      category: PlantCategory.leafyGreens,
      difficulty: PlantDifficulty.beginner,
      harvestDaysMin: 25,
      harvestDaysMax: 30,
      phRange: '6.0 - 7.0',
      ppmRange: '900 - 1200',
      sunlightHours: '5 - 6 Jam/Hari',
      recommendedMethod: 'Wick / Floating Raft (Rakit Apung)',
      shortDescription: 'Sumber zat besi terbaik untuk keluarga. Cepat panen dan sangat mudah dirawat.',
      fullDescription: 'Bayam hijau perkotaan dapat ditanam dengan cara sebar di bak rakit apung styrofoam. Dalam waktu kurang dari satu bulan, sayur bayam segar bebas pestisida sudah siap dipetik untuk sayur bening keluarga.',
      imageUrl: 'https://images.unsplash.com/photo-1683536905403-ea18a3176d29?auto=format&fit=crop&w=800&q=80',
      isLowLightTolerant: false,
      isFastHarvest: true,
      steps: [
        PlantGrowthStep(
          dayRange: 'Hari 1 - 3',
          title: 'Semai Sebar',
          description:
              'Satu lubang rockwool dapat diisi 3-5 butir benih bayam halus.',
          targetPpm: 'Air Baku (0 PPM)',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 4 - 10',
          title: 'Pertumbuhan Daun Awal',
          description: 'Beri sinar matahari langsung sejak awal agar bibit tidak kutilang (kurus tinggi langsing).',
          targetPpm: '500 - 700 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 11 - 22',
          title: 'Pembesaran Batang & Daun',
          description:
              'Jaga ketinggian air tandon dan pertahankan pH 6.0 - 6.5.',
          targetPpm: '900 - 1100 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 23 - 30',
          title: 'Panen Cabut',
          description:
              'Panen sebelum batang mengeras atau muncul bunga di pucuk.',
          targetPpm: '1100 - 1200 PPM',
        ),
      ],
      tips: [
        'Bayam menyukai sinar matahari penuh sepanjang hari.',
        'Rutin putar posisi pot agar semua sisi tanaman terkena sinar merata.',
      ],
    ),
    Plant(
      id: 'tomat_cherry',
      name: 'Tomat Cherry',
      latinName: 'Solanum lycopersicum var. cerasiforme',
      category: PlantCategory.fruiting,
      difficulty: PlantDifficulty.moderate,
      harvestDaysMin: 65,
      harvestDaysMax: 80,
      phRange: '5.5 - 6.5',
      ppmRange: '1400 - 2400',
      sunlightHours: '6 - 8 Jam/Hari',
      recommendedMethod: 'Dutch Bucket / Drip Irigasi',
      shortDescription: 'Buah manis segar kaya antioksidan. Menghias balkon dengan buah merah mengkilap.',
      fullDescription: 'Tomat cherry hidroponik sangat produktif di balkon apartemen yang terkena sinar matahari terik. Menggunakan sistem ember Dutch Bucket dengan media hidroton/perlite.',
      imageUrl: 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?auto=format&fit=crop&w=800&q=80',
      isLowLightTolerant: false,
      isFastHarvest: false,
      steps: [
        PlantGrowthStep(
          dayRange: 'Hari 1 - 10',
          title: 'Semai & Bibit',
          description:
              'Semai 1 benih per rockwool, rawat hingga berdaun 5-6 helai.',
          targetPpm: '500 - 800 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 11 - 35',
          title: 'Fase Vegetatif & Ajir',
          description:
              'Pindahkan ke Dutch Bucket. Pasang tali ajir penyangga batang.',
          targetPpm: '1400 - 1800 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 36 - 55',
          title: 'Fase Berbunga & Penyerbukan',
          description:
              'Bantu goyangkan bunga perlahan agar serbuk sari membuahi putik.',
          targetPpm: '1800 - 2200 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 56 - 80',
          title: 'Pematangan Buah & Panen',
          description:
              'Buah berubah dari hijau menjadi merah jingga manis berair.',
          targetPpm: '2000 - 2400 PPM',
        ),
      ],
      tips: [
        'Pangkas tunas air (sucker) di ketiak daun agar nutrisi fokus ke pembesaran buah.',
        'Kebutuhan air meningkat 2x lipat saat buah mulai membesar.',
      ],
    ),
    Plant(
      id: 'kemangi',
      name: 'Daun Kemangi (Basil)',
      latinName: 'Ocimum basilicum',
      category: PlantCategory.herbs,
      difficulty: PlantDifficulty.easy,
      harvestDaysMin: 30,
      harvestDaysMax: 40,
      phRange: '5.5 - 6.5',
      ppmRange: '700 - 1100',
      sunlightHours: '4 - 6 Jam/Hari',
      recommendedMethod: 'Wick System / Botol Kaca',
      shortDescription: 'Aroma khas penambah selera lalapan & masakan. Bisa dipetik berkali-kali!',
      fullDescription: 'Kemangi hidroponik memiliki daun yang lebih lebar, bersih tanpa pasir, dan aroma minyak atsiri yang sangat tajam. Sangat cocok diletakkan di dekat dapur atau jendela apartemen.',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAXjfdQJOV6dRgYSuOLnxGiYR4TgGqj9ntRCpwDqtLmhhicwIe74Ti86I&s=10',
      isLowLightTolerant: true,
      isFastHarvest: false,
      steps: [
        PlantGrowthStep(
          dayRange: 'Hari 1 - 7',
          title: 'Penyemaian Benih Aromatik',
          description: 'Benih kemangi akan mengeluarkan selaput lendir saat basah, ini normal.',
          targetPpm: 'Air Baku (0 PPM)',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 8 - 20',
          title: 'Fase Bibit & Pindah Tanam',
          description: 'Pindahkan ke sistem wick. Beri nutrisi bertahap.',
          targetPpm: '500 - 800 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 21 - 35',
          title: 'Pinch Pucuk (Topping)',
          description:
              'Petik pucuk teratas agar cabang samping tumbuh lebat rimbun.',
          targetPpm: '800 - 1000 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 36+',
          title: 'Panen Berulang',
          description: 'Petik daun sesuai kebutuhan dapur, tanaman akan terus bertunas baru.',
          targetPpm: '900 - 1100 PPM',
        ),
      ],
      tips: [
        'Segera pangkas kuncup bunga jika muncul agar daun tidak menjadi pahit.',
        'Aroma kemangi juga berfungsi sebagai pengusir serangga alami (natural repellent).',
      ],
    ),
    Plant(
      id: 'caisim',
      name: 'Sawi Caisim',
      latinName: 'Brassica juncea',
      category: PlantCategory.leafyGreens,
      difficulty: PlantDifficulty.beginner,
      harvestDaysMin: 25,
      harvestDaysMax: 30,
      phRange: '6.0 - 6.8',
      ppmRange: '1050 - 1400',
      sunlightHours: '5 - 6 Jam/Hari',
      recommendedMethod: 'Kratky / Wick / NFT',
      shortDescription: 'Sayuran kuah mie & capcay terfavorit. Tumbuh cepat dan sangat ramah pemula.',
      fullDescription: 'Sawi caisim sangat adaptif dengan iklim tropis perkotaan Indonesia. Tumbuh subur meski hanya dengan wadah stirofoam bekas buah anggur.',
      imageUrl: 'https://thesoundofcooking.com/wp-content/uploads/2025/03/choy-sum-guide-feature_The-Sound-of-Cooking-1.jpg',
      isLowLightTolerant: true,
      isFastHarvest: true,
      steps: [
        PlantGrowthStep(
          dayRange: 'Hari 1 - 3',
          title: 'Perkecambahan Cepat',
          description:
              'Benih caisim biasanya sudah berkecambah dalam 24-48 jam.',
          targetPpm: 'Air Baku (0 PPM)',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 4 - 10',
          title: 'Fase Bibit',
          description: 'Kenalkan sinar matahari pagi secara bertahap.',
          targetPpm: '600 - 800 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 11 - 22',
          title: 'Pertumbuhan Cepat',
          description: 'Daun melebar hijau cerah dengan tangkai renyah.',
          targetPpm: '1100 - 1300 PPM',
        ),
        PlantGrowthStep(
          dayRange: 'Hari 23 - 30',
          title: 'Panen Caisim',
          description: 'Potong pangkal tanaman atau cabut bersama akarnya.',
          targetPpm: '1200 - 1400 PPM',
        ),
      ],
      tips: [
        'Periksa kadar air di tandon setiap pagi karena caisim dewasa menyerap air cukup banyak.',
      ],
    ),
  ];
}

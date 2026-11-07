/// Model for compact educational micro-lessons.
class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullContent,
    required this.readTimeMinutes,
    required this.category,
    required this.author,
    required this.keyTakeaways,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String shortDescription;
  final String fullContent;
  final int readTimeMinutes;
  final String category;
  final String author;
  final List<String> keyTakeaways;
  final String imageUrl;
}

abstract final class SampleLessons {
  static const List<Lesson> lessons = [
    Lesson(
      id: 'lesson_ab_mix',
      title: 'Rahasia Melarutkan Nutrisi AB Mix yang Benar',
      shortDescription:
          'Jangan pernah mencampur pekatan A dan pekatan B secara langsung dalam keadaan kental!',
      fullContent:
          'Banyak pemula gagal karena mencampur cairan pekatan A dan B secara bersamaan ke wadah kecil. Ketika pekatan A (kalsium) bertemu dengan pekatan B (sulfat & fosfat) dalam konsentrasi tinggi, akan terjadi reaksi kimia pembentukan gipsum (endapan putih). Akibatnya kalsium dan fosfat mengkristal dan akar tanaman tidak bisa menyerapnya sama sekali!\n\nCara yang benar:\n1. Siapkan air baku di ember/tandon (misal 5 Liter).\n2. Tuang pekatan A sesuai dosis (misal 25 mL), aduk hingga rata sempurna.\n3. Baru tuangkan pekatan B (25 mL) ke dalam air yang sudah berbaur A, aduk kembali sampai jernih.\n4. Cek kepekatan menggunakan TDS Meter.',
      readTimeMinutes: 3,
      category: 'Nutrisi Tanaman',
      author: 'Tim Ahli Agronomi HydroGrow',
      keyTakeaways: [
        'Campur ke dalam air tandon satu per satu, jangan langsung A + B pekat.',
        'Aduk pekatan A hingga larut rata sebelum memasukkan pekatan B.',
        'Endapan putih di dasar wadah adalah tanda nutrisi gagal larut.',
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1585320806297-9794b3e4eeae?auto=format&fit=crop&w=800&q=80',
    ),
    Lesson(
      id: 'lesson_ph_importance',
      title: 'Mengapa Nilai pH Air Sangat Krusial?',
      shortDescription:
          'pH menentukan apakah akar tanaman mampu membuka mulutnya untuk menyerap unsur hara.',
      fullContent:
          'Meskipun nutrisi AB Mix Anda sangat mahal dan lengkap, bila pH air di atas 7.5 atau di bawah 5.0, unsur mikro seperti besi (Fe) dan mangan (Mn) akan terkunci secara kimiawi (nutrient lockout).\n\nRentang pH terbaik untuk sayuran daun hidroponik adalah 5.8 - 6.5. Pada rentang sedikit asam ini, semua nutrisi larut dalam bentuk ionik yang sangat mudah dihirup oleh bulu-bulu akar.',
      readTimeMinutes: 2,
      category: 'Kualitas Air',
      author: 'Dr. Tani Perkotaan',
      keyTakeaways: [
        'pH ideal sayuran daun: 5.8 - 6.5.',
        'Gunakan pH Down (asam fosfat/sitrat) bila air PDAM Anda terlalu basa.',
        'Cek pH minimal 2 kali seminggu.',
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1530836369250-ef72a3f5cda8?auto=format&fit=crop&w=800&q=80',
    ),
    Lesson(
      id: 'lesson_healthy_roots',
      title: 'Mengenali Ciri Akar Hidroponik yang Sehat',
      shortDescription:
          'Akar putih bersih seperti mie adalah tanda tanaman tumbuh super sehat!',
      fullContent:
          'Di dalam sistem hidroponik, akar adalah cerminan kesehatan tanaman. Akar yang sehat berwarna putih bersih, elastis, dan memiliki aroma segar seperti aroma rumput basah.\n\nBila akar berwarna kecokelatan, berlendir, dan berbau comberan, tanaman Anda mengalami Root Rot (busuk akar) akibat kurangnya oksigen terlarut atau suhu air tandon yang terlalu hangat karena terpapar sinar matahari langsung.',
      readTimeMinutes: 3,
      category: 'Kesehatan Tanaman',
      author: 'Komunitas Hidroponik Mandiri',
      keyTakeaways: [
        'Akar sehat berwarna putih gading/bersih dan tidak berbau.',
        'Lindungi wadah tandon dari panas langsung dengan cat putih atau aluminium foil.',
        'Beri ruang udara (1/3 bagian akar atas) agar akar tetap mendapat suplai oksigen.',
      ],
      imageUrl:
          'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?auto=format&fit=crop&w=800&q=80',
    ),
  ];
}

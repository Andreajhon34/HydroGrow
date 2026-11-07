/// Model representing symptom categories, decision questions, and final diagnosis
/// for the interactive visual flowchart troubleshooter.

enum ProblemSeverity {
  mild('Ringan', 0xFF24C46E),
  moderate('Sedang', 0xFFF59E0B),
  critical('Kritis', 0xFFEF4444);

  const ProblemSeverity(this.label, this.colorValue);
  final String label;
  final int colorValue;
}

class SymptomCategory {
  const SymptomCategory({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconName,
    required this.initialQuestionId,
    required this.sampleImageUrl,
  });

  final String id;
  final String title;
  final String subtitle;
  final String iconName;
  final String initialQuestionId;
  final String sampleImageUrl;
}

class TroubleshootQuestion {
  const TroubleshootQuestion({
    required this.id,
    required this.question,
    required this.guidance,
    required this.options,
  });

  final String id;
  final String question;
  final String guidance;
  final List<TroubleshootOption> options;
}

class TroubleshootOption {
  const TroubleshootOption({
    required this.label,
    required this.description,
    this.nextQuestionId,
    this.result,
  });

  final String label;
  final String description;
  final String? nextQuestionId;
  final DiagnosisResult? result;
}

class DiagnosisResult {
  const DiagnosisResult({
    required this.title,
    required this.subtitle,
    required this.severity,
    required this.cause,
    required this.solutions,
    required this.prevention,
    this.isNutrientRelated = false,
  });

  final String title;
  final String subtitle;
  final ProblemSeverity severity;
  final String cause;
  final List<String> solutions;
  final String prevention;
  final bool isNutrientRelated;
}

/// Curated expert dataset for common urban hydroponic problems.
abstract final class SampleTroubleshootData {
  static const List<SymptomCategory> categories = [
    SymptomCategory(
      id: 'yellow_leaves',
      title: 'Daun Menguning (Klorosis)',
      subtitle: 'Daun memudar hijau cerah menjadi kuning pucat.',
      iconName: 'eco',
      initialQuestionId: 'q_yellow_location',
      sampleImageUrl: 'assets/symptoms/daun-menguning.jpg',
    ),
    SymptomCategory(
      id: 'tip_burn',
      title: 'Ujung Daun Kering / Gosong',
      subtitle: 'Ujung tepi daun menghitam atau kering kecokelatan.',
      iconName: 'local_fire_department',
      initialQuestionId: 'q_burn_pattern',
      sampleImageUrl: 'assets/symptoms/daun-mengering.jpg',
    ),
    SymptomCategory(
      id: 'root_rot',
      title: 'Akar Cokelat & Berlendir',
      subtitle:
          'Akar tidak lagi putih bersih, berbau atau tanaman layu siang hari.',
      iconName: 'water_drop',
      initialQuestionId: 'q_root_smell',
      sampleImageUrl: 'assets/symptoms/akar-cokelat.png',
    ),
    SymptomCategory(
      id: 'etiolation',
      title: 'Batang Kutilang (Kurus Tinggi)',
      subtitle: 'Batang kurus, tinggi meliuk lemah, jarak antar daun renggang.',
      iconName: 'height',
      initialQuestionId: 'q_etiolation_light',
      sampleImageUrl: 'assets/symptoms/kutilang.jpg',
    ),
    SymptomCategory(
      id: 'pests',
      title: 'Hama Kutu Daun & Ulat',
      subtitle: 'Titik hitam/putih bergerak di bawah daun atau daun berlubang.',
      iconName: 'pest_control',
      initialQuestionId: 'q_pest_type',
      sampleImageUrl: 'assets/symptoms/hama.jpg',
    ),
  ];

  static const Map<String, TroubleshootQuestion> questions = {
    // ── Yellow Leaves Decision Tree ──
    'q_yellow_location': TroubleshootQuestion(
      id: 'q_yellow_location',
      question: 'Di bagian daun mana warna kuning paling dominan?',
      guidance: 'Perhatikan apakah daun bawah (tua) atau daun pucuk (muda) yang pertama kali menguning.',
      options: [
        TroubleshootOption(
          label: 'Daun bagian bawah (daun tua)',
          description:
              'Daun pucuk atas masih hijau, tapi daun bawah menguning merata.',
          nextQuestionId: 'q_yellow_veins_old',
        ),
        TroubleshootOption(
          label: 'Daun bagian atas / pucuk (daun muda)',
          description: 'Pucuk baru berwarna kuning pucat keputihan.',
          nextQuestionId: 'q_yellow_young',
        ),
        TroubleshootOption(
          label: 'Seluruh tanaman menguning merata',
          description:
              'Pertumbuhan kerdil lambat, warna hijau pupus di semua helai.',
          result: DiagnosisResult(
            title: 'Kekurangan Nutrisi Total (PPM Terlalu Rendah)',
            subtitle: 'Larutan nutrisi AB Mix terlalu encer atau air baku bertambah akibat hujan.',
            severity: ProblemSeverity.moderate,
            cause: 'Konsentrasi PPM di tandon di bawah 400 PPM sehingga tanaman kelaparan unsur hara makro (N-P-K).',
            solutions: [
              'Ukur PPM air tandon dengan TDS meter.',
              'Tambahkan larutan AB Mix dengan perbandingan 5 mL A + 5 mL B per Liter hingga mencapai 1000 - 1200 PPM.',
              'Ganti air tandon jika sudah lebih dari 2 minggu belum dikuras.',
            ],
            prevention: 'Rutin mengecek kepekatan PPM minimal 2 hari sekali terutama saat cuaca panas.',
            isNutrientRelated: true,
          ),
        ),
      ],
    ),
    'q_yellow_veins_old': TroubleshootQuestion(
      id: 'q_yellow_veins_old',
      question: 'Bagaimana pola menguning pada daun tua tersebut?',
      guidance: 'Amati urat daun (tulang daun). Apakah tulangnya tetap hijau atau ikut menguning?',
      options: [
        TroubleshootOption(
          label: 'Kuning merata ke seluruh helai daun',
          description: 'Daun tua perlahan layu dan rontok dari pangkal batang.',
          result: DiagnosisResult(
            title: 'Defisiensi Nitrogen (N)',
            subtitle:
                'Tanaman mengorbankan daun tua untuk memberi makan tunas baru.',
            severity: ProblemSeverity.mild,
            cause: 'Nitrogen bersifat mobile. Saat pasokan nitrogen di air kurang, tanaman menarik cadangan N dari daun tua ke pucuk.',
            solutions: [
              'Tingkatkan takaran nutrisi AB Mix sebesar 200 - 300 PPM.',
              'Pastikan suhu air tandon tidak di atas 30°C agar serapan hara lancar.',
              'Pangkas daun tua yang sudah menguning sempurna agar energi tidak terbuang.',
            ],
            prevention: 'Pastikan nutrisi AB Mix yang digunakan khusus Sayuran Daun dengan komposisi N tinggi.',
            isNutrientRelated: true,
          ),
        ),
        TroubleshootOption(
          label: 'Hanya di antara urat daun (Urat daun tetap hijau)',
          description: 'Ada motif garis-garis hijau tua, sedangkan daging daun menguning.',
          result: DiagnosisResult(
            title: 'Defisiensi Magnesium (Mg)',
            subtitle: 'Klorosis interveinal pada daun tua akibat serapan magnesium terganggu.',
            severity: ProblemSeverity.moderate,
            cause: 'Kadar magnesium kurang atau terhambat oleh kadar kalsium/kalium yang terlalu tinggi di air baku.',
            solutions: [
              'Periksa pH larutan nutrisi. Jaga pada rentang optimal 5.8 - 6.5.',
              'Semprotkan pupuk garam inggris (Epsom Salt / MgSO4) encer (1 gram / Liter) ke daun di pagi hari.',
              'Kuras dan buat larutan AB Mix baru yang seimbang.',
            ],
            prevention: 'Gunakan air baku rendah mineral (TDS air baku < 100 PPM) seperti air AC atau air RO.',
            isNutrientRelated: true,
          ),
        ),
      ],
    ),
    'q_yellow_young': TroubleshootQuestion(
      id: 'q_yellow_young',
      question: 'Apakah urat daun pucuk masih berwarna hijau?',
      guidance: 'Lihat daun muda yang baru mekar di bagian atas.',
      options: [
        TroubleshootOption(
          label: 'Urat daun tetap hijau, daging daun kuning pucat',
          description: 'Sangat kontras antara tulang daun hijau tajam dan helai daun kuning.',
          result: DiagnosisResult(
            title: 'Defisiensi Zat Besi (Iron Chlorosis - Fe)',
            subtitle: 'Zat besi terkunci secara kimiawi di larutan nutrisi.',
            severity: ProblemSeverity.moderate,
            cause: 'Paling sering disebabkan oleh pH air tandon terlalu tinggi (di atas 7.0). Besi mengendap dan tidak larut.',
            solutions: [
              'Segera ukur pH air tandon. Jika pH > 7.0, turunkan ke 6.0 menggunakan pH Down (asam sitrat/asam fosfat).',
              'Tambahkan Fe-EDDHA atau Fe-DTPA jika air sering terpapar sinar matahari.',
              'Pastikan larutan pekatan A dan B tidak dicampur langsung saat kental.',
            ],
            prevention: 'Cek pH air tandon setiap 3 hari sekali. Pertahankan pH di kisaran 5.8 - 6.5.',
            isNutrientRelated: true,
          ),
        ),
        TroubleshootOption(
          label: 'Pucuk menguning disertai daun berkerut kerdil',
          description: 'Ujung pucuk gagal berkembang normal dan rapuh.',
          result: DiagnosisResult(
            title: 'Defisiensi Kalsium (Ca) & Boron (B)',
            subtitle: 'Gangguan pembentukan dinding sel tunas muda.',
            severity: ProblemSeverity.moderate,
            cause: 'Transpirasi rendah (kelembapan udara terlalu tinggi/ruangan tidak berangin) atau serapan kalsium lambat.',
            solutions: [
              'Pastikan sirkulasi udara baik dengan ventilasi atau kipas mini di area balkon.',
              'Cek konsentrasi PPM larutan pekatan A (kalsium nitrat).',
              'Hindari suhu tandon yang terlalu dingin di malam hari.',
            ],
            prevention: 'Beri jarak tanam yang cukup agar tanaman tidak terlalu padat berdesakan.',
            isNutrientRelated: true,
          ),
        ),
      ],
    ),

    // ── Tip Burn Decision Tree ──
    'q_burn_pattern': TroubleshootQuestion(
      id: 'q_burn_pattern',
      question:
          'Berapa nilai PPM air tandon saat ini dan bagaimana cuaca sekitar?',
      guidance: 'Ujung daun gosong bisa karena nutrisi terlalu pekat atau kekurangan kalsium akibat terik ekstrem.',
      options: [
        TroubleshootOption(
          label: 'PPM sangat tinggi (> 1500 PPM) & cuaca terik',
          description: 'Ujung hampir semua daun melengkung dan mengering seperti terbakar.',
          result: DiagnosisResult(
            title: 'Over-Nutrition / Nutrient Burn (Terbakar Pupuk)',
            subtitle: 'Konsentrasi garam mineral terlalu pekat menyerap cairan dari sel daun.',
            severity: ProblemSeverity.critical,
            cause: 'Air tandon menguap cepat saat panas terik, menyebabkan konsentrasi garam AB Mix melonjak drastis.',
            solutions: [
              'Segera tambahkan air bersih/air baku ke tandon untuk mengencerkan PPM ke rentang 900 - 1100 PPM.',
              'Gunakan kalkulator dosis nutrisi untuk memverifikasi volume air.',
              'Beri jaring peneduh (paranet 50%) agar tanaman tidak terpapar terik matahari jam 12 siang langsung.',
            ],
            prevention: 'Saat musim panas terik, isi air baku lebih banyak karena penguapan air lebih cepat daripada serapan nutrisi.',
            isNutrientRelated: true,
          ),
        ),
        TroubleshootOption(
          label: 'PPM normal, tapi hanya pucuk selada muda yang pinggirannya gosong',
          description: 'Daun tua baik-baik saja, hanya daun dalam yang tepinya kering cokelat.',
          result: DiagnosisResult(
            title: 'Tip-Burn Fisiologis (Defisiensi Kalsium Lokal)',
            subtitle: 'Sering terjadi pada selada keriting saat pertumbuhan terlalu cepat.',
            severity: ProblemSeverity.mild,
            cause: 'Laju pertumbuhan sel daun melampaui kemampuan akar mengantarkan kalsium ke pinggir daun.',
            solutions: [
              'Tingkatkan sirkulasi angin di sekitar tanaman agar laju transpirasi lancar.',
              'Turunkan PPM sedikit (ke 600 - 700 PPM untuk selada).',
              'Hindari sinar matahari siang yang terlalu menyengat.',
            ],
            prevention: 'Pilih varietas selada yang tahan tip-burn untuk ditanam di dataran rendah perkotaan.',
            isNutrientRelated: true,
          ),
        ),
      ],
    ),

    // ── Root Rot Decision Tree ──
    'q_root_smell': TroubleshootQuestion(
      id: 'q_root_smell',
      question: 'Bagaimana kondisi fisik dan aroma dari air tandon?',
      guidance:
          'Buka wadah tandon hidroponik dan angkat netpot untuk melihat akar.',
      options: [
        TroubleshootOption(
          label: 'Akar cokelat gelap, licin berlendir, berbau busuk',
          description:
              'Tanaman tampak layu saat terik meskipun air tandon masih penuh.',
          result: DiagnosisResult(
            title: 'Busuk Akar (Pythium Root Rot)',
            subtitle: 'Infeksi jamur parasit anaerob akibat kekurangan oksigen dan suhu air panas.',
            severity: ProblemSeverity.critical,
            cause: 'Suhu air tandon melebihi 28-30°C sehingga oksigen terlarut anjlok dan jamur patogen berkembang biak.',
            solutions: [
              'Kuras total tandon, bersihkan wadah dengan sabun & bilas air bersih.',
              'Gunting bagian akar yang sudah cokelat busuk.',
              'Bilas akar yang tersisa dengan larutan H2O2 (Hidrogen Peroksida 3%) encer 5 mL per Liter.',
              'Isi air tandon baru dengan suhu sejuk dan lapisi tandon dengan aluminium foil agar tidak panas.',
            ],
            prevention: 'Beri ruang udara (1/3 akar atas jangan terendam) dan jauhkan wadah dari lantai dak beton yang panas.',
            isNutrientRelated: false,
          ),
        ),
        TroubleshootOption(
          label: 'Akar kecokelatan tapi tidak berbau & tidak berlendir',
          description: 'Hanya ada endapan nutrisi atau lumut yang menempel di serat akar.',
          result: DiagnosisResult(
            title: 'Pewarnaan Organik / Lumut Menempel (Algae Staining)',
            subtitle: 'Bukan penyakit jamur, melainkan lumut akibat tandon tembus cahaya.',
            severity: ProblemSeverity.mild,
            cause: 'Wadah tandon (misal botol bening) tidak dilapisi cat/lakban hitam sehingga sinar matahari memicu lumut hijau.',
            solutions: [
              'Bilas akar perlahan dengan air mengalir.',
              'Bungkus botol atau bak tandon dengan plastik hitam atau lakban agar cahaya tidak tembus sama sekali.',
              'Kuras tandon untuk membuang spora lumut.',
            ],
            prevention: 'Pastikan 100% bagian tandon air hidroponik kedap cahaya matahari.',
            isNutrientRelated: false,
          ),
        ),
      ],
    ),

    // ── Etiolation Decision Tree ──
    'q_etiolation_light': TroubleshootQuestion(
      id: 'q_etiolation_light',
      question:
          'Berapa jam tanaman Anda mendapat sinar matahari langsung per hari?',
      guidance: 'Tanaman kutilang disebabkan oleh naluri tanaman mencari sumber cahaya (etiolasi).',
      options: [
        TroubleshootOption(
          label: 'Kurang dari 3 jam atau hanya sinar pantulan indoor',
          description:
              'Tanaman diletakkan di dalam ruangan jauh dari jendela luar.',
          result: DiagnosisResult(
            title: 'Etiolasi Berat (Kurang Sinar Matahari)',
            subtitle: 'Tanaman memanjangkan batang mencari cahaya sehingga batang kurus dan rapuh.',
            severity: ProblemSeverity.moderate,
            cause: 'Hormon auksin di pucuk bekerja berlebihan memanjangkan sel batang karena ketiadaan sinar UV.',
            solutions: [
              'Pindahkan wadah ke area yang terkena minimal 4 - 6 jam sinar matahari langsung (misal jendela timur/selatan).',
              'Bila ruang indoor tanpa jendela, pasang lampu Full Spectrum LED Grow Light berjarak 20 cm di atas tanaman selama 12 jam/hari.',
              'Jika tanaman sudah terlalu roboh meliuk, tumpuk media rockwool atau semai ulang agar tumbuh kokoh.',
            ],
            prevention: 'Langsung jemur bibit ke matahari pagi sejak pertama kali benih pecah (sprout).',
            isNutrientRelated: false,
          ),
        ),
      ],
    ),

    // ── Pests Decision Tree ──
    'q_pest_type': TroubleshootQuestion(
      id: 'q_pest_type',
      question: 'Gejala hama apa yang Anda temukan di daun?',
      guidance:
          'Amati bagian balik daun menggunakan senter HP atau kaca pembesar.',
      options: [
        TroubleshootOption(
          label: 'Kutu kecil bergerombol (hijau, hitam, atau putih tepung)',
          description: 'Daun terasa lengket dan mengkerut ke dalam.',
          result: DiagnosisResult(
            title: 'Serangan Kutu Daun (Aphids) / Kutu Kebul (Whitefly)',
            subtitle: 'Menghisap cairan sel daun dan meninggalkan embun madu pemicu jamur jelaga.',
            severity: ProblemSeverity.moderate,
            cause: 'Hama terbang dari tanaman liar sekitar atau terbawa angin ke balkon apartemen.',
            solutions: [
              'Semprot bagian bawah daun dengan pestisida nabati: 1 sendok teh sabun cuci piring cair + 1 Liter air bersih.',
              'Bisa juga menggunakan larutan minyak nimba (Neem Oil) 5 mL/Liter + beberapa tetes sabun pengemulsi.',
              'Lakukan penyemprotan sore hari saat matahari tidak terik.',
            ],
            prevention: 'Tanam tanaman pendamping beraroma tajam seperti kemangi/basil di sekitar sayuran sebagai pengusir alami.',
            isNutrientRelated: false,
          ),
        ),
        TroubleshootOption(
          label: 'Daun berlubang besar atau robek compang-camping',
          description:
              'Ada butiran kotoran hitam kecil di atas permukaan daun.',
          result: DiagnosisResult(
            title: 'Ulat Daun (Caterpillar / Armyworm)',
            subtitle: 'Ulat memakan daun dengan cepat di malam hari.',
            severity: ProblemSeverity.moderate,
            cause: 'Kupu-kupu atau ngengat bertelur di daun beberapa hari sebelumnya.',
            solutions: [
              'Cari ulat secara manual di balik daun atau pangkal batang di pagi/sore hari, lalu singkirkan.',
              'Semprotkan bio-insektisida ramah lingkungan berbahan Bacillus thuringiensis (BT).',
              'Pangkas daun yang rusak parah.',
            ],
            prevention: 'Pasang kelambu serangga (insect net) di rak balkon apartemen Anda.',
            isNutrientRelated: false,
          ),
        ),
      ],
    ),
  };
}

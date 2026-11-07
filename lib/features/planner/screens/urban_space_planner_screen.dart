import 'package:flutter/material.dart';
import '../../../core/state/app_state.dart';
import '../../../core/theme/theme.dart';

/// Multi-step setup wizard for "Urban Space & DIY Setup Planner" (Proposed Page 2).
/// Helps apartment dwellers assess their available space, size, and experience
/// to recommend the optimal DIY hydroponic setup.
class UrbanSpacePlannerScreen extends StatefulWidget {
  const UrbanSpacePlannerScreen({super.key});

  @override
  State<UrbanSpacePlannerScreen> createState() =>
      _UrbanSpacePlannerScreenState();
}

class _UrbanSpacePlannerScreenState extends State<UrbanSpacePlannerScreen> {
  int _currentStep = 0; // 0, 1, 2, 3 (Result)

  // Selections
  int _selectedSpaceIndex = 0;
  int _selectedSizeIndex = 0;
  int _selectedExperienceIndex = 0;

  static const List<_OptionData> _spaces = [
    _OptionData(
      title: 'Ambang Jendela (Windowsill)',
      subtitle: 'Sinar matahari pagi langsung, ruang sempit horizontal.',
      icon: Icons.window_rounded,
    ),
    _OptionData(
      title: 'Balkon Apartemen',
      subtitle: 'Area terbuka vertikal/railing, ventilasi angin bagus.',
      icon: Icons.balcony_rounded,
    ),
    _OptionData(
      title: 'Sudut Ruangan Indoor',
      subtitle: 'Dekat dapur atau ruang tamu, perlu lampu grow light.',
      icon: Icons.meeting_room_outlined,
    ),
    _OptionData(
      title: 'Rooftop / Teras Atas',
      subtitle: 'Panas terik penuh, cocok untuk tanaman buah & sayur.',
      icon: Icons.roofing_rounded,
    ),
  ];

  static const List<_OptionData> _sizes = [
    _OptionData(
      title: 'Sangat Terbatas (< 0.5 m²)',
      subtitle: 'Cukup untuk 2-6 botol bekas atau toples kaca.',
      icon: Icons.crop_square_rounded,
    ),
    _OptionData(
      title: 'Sedang (1 - 2 m²)',
      subtitle: 'Cukup untuk 1-2 bak stirofoam atau rak susun 3 tingkat.',
      icon: Icons.grid_view_rounded,
    ),
    _OptionData(
      title: 'Cukup Luas (> 3 m²)',
      subtitle: 'Bisa dipasang modul pipa PVC 20-40 lubang tanam.',
      icon: Icons.view_quilt_rounded,
    ),
  ];

  static const List<_OptionData> _experiences = [
    _OptionData(
      title: 'Pemula Total (Modal Nol Rupiah)',
      subtitle: 'Ingin mencoba dengan botol mineral bekas & kain sumbu.',
      icon: Icons.savings_outlined,
    ),
    _OptionData(
      title: 'Pernah Coba (Starter Kit)',
      subtitle: 'Siap beli rockwool, netpot, dan bak tandon 10 Liter.',
      icon: Icons.handyman_outlined,
    ),
    _OptionData(
      title: 'Hobi Serius (Sistem Pompa/NFT)',
      subtitle: 'Ingin hasil panen mingguan rutin untuk keluarga.',
      icon: Icons.autorenew_rounded,
    ),
  ];

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.of(context).pop();
    }
  }

  // ── Recommendations based on selections ──
  _PlannerResult _calculateResult() {
    if (_selectedSpaceIndex == 0 || _selectedSizeIndex == 0) {
      // Windowsill or Tiny space
      return const _PlannerResult(
        systemName: 'Sistem Sumbu Botol Bekas (Wick System)',
        systemTagline: 'Paling hemat tempat, biaya Rp 0, dan tanpa listrik!',
        description:
            'Potong botol air mineral 1.5 Liter menjadi dua bagian. Bagian atas dibalik diisi kain flanel sebagai sumbu kapiler yang menyedot nutrisi dari dasar botol. Sangat pas diletakkan berjajar di ambang jendela apartemen.',
        suitablePlants: ['Kangkung Air', 'Pakcoy Hijau', 'Kemangi / Basil'],
        equipmentChecklist: [
          '4-6 Botol mineral bekas 1.5 Liter',
          'Kain flanel bekas (lebar 2 cm)',
          'Spons cuci piring atau rockwool',
          '1 Paket Nutrisi AB Mix Sayuran Daun',
          'Benih Kangkung / Pakcoy',
        ],
        estimatedYield: '500 - 800 gram sayur per 3 minggu',
        filterCategory: 'Pemula (Mudah)',
      );
    } else if (_selectedExperienceIndex == 2 || _selectedSizeIndex == 2) {
      // Advanced or Large space
      return const _PlannerResult(
        systemName: 'Modul Pipa PVC DFT Bertingkat (Vertical Rack)',
        systemTagline: 'Hasil panen maksimal dengan sirkulasi pompa otomatis!',
        description:
            'Memanfaatkan ketinggian dinding balkon dengan rak pipa PVC bertingkat 3 level. Air nutrisi dipompa bersirkulasi otomatis, memberikan oksigen melimpah pada akar untuk pertumbuhan 30% lebih cepat.',
        suitablePlants: ['Selada Keriting', 'Pakcoy Hijau', 'Sawi Caisim', 'Bayam Hijau'],
        equipmentChecklist: [
          '3 Batang pipa PVC 2.5 inch (masing-masing 1 meter)',
          'Pompa aquarium mini (15 Watt)',
          'Tandon air 20 Liter',
          'Netpot 5 cm (18-24 pcs)',
          'AB Mix Sayuran Daun & TDS Meter',
        ],
        estimatedYield: '2 - 3 kg sayuran segar per bulan',
        filterCategory: 'Sayuran Daun',
      );
    } else {
      // Medium Balcony / Box setup
      return const _PlannerResult(
        systemName: 'Sistem Kratky Bak Stirofoam (Rakit Apung)',
        systemTagline: 'Tanpa pompa listrik, air tandon awet hingga panen!',
        description:
            'Gunakan boks stirofoam bekas buah anggur berkapasitas 15 Liter. Tutup boks dilubangi 6-9 titik netpot. Air nutrisi diisi penuh saat semai, dan saat akar memanjang, permukaan air menyusut menyisakan ruang oksigen alami.',
        suitablePlants: ['Kangkung Air', 'Pakcoy Hijau', 'Selada Keriting'],
        equipmentChecklist: [
          '1 Box stirofoam bekas buah anggur + lakban hitam',
          'Plastik hitam pelapis tandon air',
          'Netpot & kain flanel (6-9 pcs)',
          'Rockwool media tanam',
          'AB Mix Nutrisi 250 gram',
        ],
        estimatedYield: '1 - 1.5 kg sayuran hijau per panen',
        filterCategory: 'Pemula (Mudah)',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.foregroundDark : AppColors.foregroundLight;
    final muted = isDark
        ? AppColors.mutedForegroundDark
        : AppColors.mutedForegroundLight;
    final cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rencana Setup Ruang & Wadah'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: _prevStep,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Step Progress Indicator ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _currentStep < 3
                            ? 'Langkah ${_currentStep + 1} dari 3'
                            : 'Hasil Rekomendasi Anda',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        _currentStep == 0
                            ? 'Pilih Ruang'
                            : _currentStep == 1
                                ? 'Pilih Ukuran'
                                : _currentStep == 2
                                    ? 'Pengalaman & Budget'
                                    : 'Selesai 🌱',
                        style: TextStyle(fontSize: 12, color: muted),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (_currentStep + 1) / 4,
                      minHeight: 5,
                      backgroundColor:
                          isDark ? AppColors.mutedDark : AppColors.mutedLight,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── Step Content ────────────────────────────────────────────────
            Expanded(
              child: _currentStep < 3
                  ? _buildStepQuestion(context, fg, muted, cardBg)
                  : _buildResultView(context, fg, muted, cardBg),
            ),

            // ── Bottom Navigation Buttons (for Steps 0-2) ───────────────────
            if (_currentStep < 3)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardBg,
                  border: Border(
                    top: BorderSide(
                      color: isDark ? AppColors.borderDark : AppColors.borderLight,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _prevStep,
                          child: const Text('Sebelumnya'),
                        ),
                      ),
                    if (_currentStep > 0) const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: _nextStep,
                        icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                        label: Text(
                          _currentStep == 2 ? 'Lihat Rekomendasi' : 'Lanjut',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ── Step Selector Widget ──
  Widget _buildStepQuestion(
    BuildContext context,
    Color fg,
    Color muted,
    Color cardBg,
  ) {
    late String title;
    late String subtitle;
    late List<_OptionData> options;
    late int selectedIndex;
    late void Function(int) onSelect;

    if (_currentStep == 0) {
      title = 'Di mana Anda berencana menanam?';
      subtitle = 'Pilih lokasi di rumah atau apartemen yang paling potensial.';
      options = _spaces;
      selectedIndex = _selectedSpaceIndex;
      onSelect = (i) => setState(() => _selectedSpaceIndex = i);
    } else if (_currentStep == 1) {
      title = 'Berapa perkiraan luas ruang yang tersedia?';
      subtitle = 'Kami akan mencocokkan kapasitas jumlah wadah lubang tanam.';
      options = _sizes;
      selectedIndex = _selectedSizeIndex;
      onSelect = (i) => setState(() => _selectedSizeIndex = i);
    } else {
      title = 'Apa tingkat pengalaman dan preferensi Anda?';
      subtitle = 'Pilih metode yang paling nyaman dengan waktu dan anggaran Anda.';
      options = _experiences;
      selectedIndex = _selectedExperienceIndex;
      onSelect = (i) => setState(() => _selectedExperienceIndex = i);
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: fg,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(fontSize: 13, color: muted, height: 1.4),
        ),
        const SizedBox(height: 20),
        ...List.generate(options.length, (idx) {
          final opt = options[idx];
          final isSelected = selectedIndex == idx;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => onSelect(idx),
              borderRadius: BorderRadius.circular(16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : (Theme.of(context).brightness == Brightness.dark
                            ? AppColors.borderDark
                            : AppColors.borderLight),
                    width: isSelected ? 2 : 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : (Theme.of(context).brightness == Brightness.dark
                                ? AppColors.mutedDark
                                : AppColors.mutedLight),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        opt.icon,
                        color: isSelected
                            ? AppColors.primaryForeground
                            : AppColors.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            opt.title,
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: fg,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            opt.subtitle,
                            style: TextStyle(fontSize: 11.5, color: muted),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : (Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.borderDark
                                  : AppColors.borderLight),
                          width: 2,
                        ),
                        color: isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Center(
                              child: Icon(
                                Icons.check_rounded,
                                size: 14,
                                color: AppColors.primaryForeground,
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // ── Result View Widget ──
  Widget _buildResultView(
    BuildContext context,
    Color fg,
    Color muted,
    Color cardBg,
  ) {
    final result = _calculateResult();
    final appState = AppStateScope.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      children: [
        // Trophy Badge
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_rounded, size: 16, color: AppColors.primary),
                SizedBox(width: 6),
                Text(
                  'Rekomendasi Terpilih untuk Anda',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // System Name Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF1B3D2B), AppColors.cardDark]
                  : [const Color(0xFFEDFAF1), AppColors.cardLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                result.systemName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: fg,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                result.systemTagline,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                result.description,
                style: TextStyle(fontSize: 13, color: muted, height: 1.5),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Icon(
                    Icons.scale_rounded,
                    size: 16,
                    color: Color(0xFF24C46E),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Estimasi Panen: ${result.estimatedYield}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF24C46E),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Suitable Plants
        Text(
          'Sayuran yang Paling Cocok',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: fg,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: result.suitablePlants.map((plantName) {
            return Chip(
              avatar: const Icon(
                Icons.eco_rounded,
                size: 15,
                color: AppColors.primary,
              ),
              label: Text(plantName),
              labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
              backgroundColor: cardBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Equipment Checklist
        Text(
          'Checklist Alat & Bahan Permulaan',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: fg,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: Column(
            children: result.equipmentChecklist.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 12.5, color: fg),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),

        // ── Action Buttons ──────────────────────────────────────────────────
        // Action 1: Browse Matching Plants -> Go to Explore
        ElevatedButton.icon(
          onPressed: () {
            appState.setExploreFilter(result.filterCategory);
            appState.setNavIndex(1); // Explore tab
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.search_rounded),
          label: const Text('Lihat Tanaman yang Cocok'),
        ),
        const SizedBox(height: 10),

        // Action 2: Find Supplies Nearby -> Navigates to Plant Care (Supply Map)
        OutlinedButton.icon(
          onPressed: () {
            appState.setNavIndex(2); // Plant Care tab
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.storefront_outlined),
          label: const Text('Cari Toko Bahan Terdekat'),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _OptionData {
  const _OptionData({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}

class _PlannerResult {
  const _PlannerResult({
    required this.systemName,
    required this.systemTagline,
    required this.description,
    required this.suitablePlants,
    required this.equipmentChecklist,
    required this.estimatedYield,
    required this.filterCategory,
  });

  final String systemName;
  final String systemTagline;
  final String description;
  final List<String> suitablePlants;
  final List<String> equipmentChecklist;
  final String estimatedYield;
  final String filterCategory;
}

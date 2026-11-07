import 'package:flutter/material.dart';
import '../../../core/models/plant_model.dart';
import '../../../core/state/app_state.dart';
import '../../../core/theme/theme.dart';
import '../widgets/plant_card.dart';
import '../widgets/space_planner_banner.dart';
import 'plant_detail_screen.dart';

/// Primary Explore & Catalogue screen.
/// Includes real-time search, category filter chips, the space planner banner,
/// and a responsive 2-column plant catalogue grid.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const List<String> _filters = [
    'Semua',
    'Pemula (Mudah)',
    'Panen Cepat (< 30 Hari)',
    'Minim Cahaya',
    'Sayuran Daun',
    'Tanaman Buah',
    'Herba & Rempah',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Plant> _getFilteredPlants(String selectedFilter) {
    return SamplePlants.plants.where((plant) {
      // Search matching
      final matchesQuery = _searchQuery.isEmpty ||
          plant.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          plant.latinName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          plant.shortDescription.toLowerCase().contains(_searchQuery.toLowerCase());

      if (!matchesQuery) return false;

      // Filter category matching
      switch (selectedFilter) {
        case 'Pemula (Mudah)':
          return plant.difficulty == PlantDifficulty.beginner ||
              plant.difficulty == PlantDifficulty.easy;
        case 'Panen Cepat (< 30 Hari)':
          return plant.isFastHarvest;
        case 'Minim Cahaya':
          return plant.isLowLightTolerant;
        case 'Sayuran Daun':
          return plant.category == PlantCategory.leafyGreens;
        case 'Tanaman Buah':
          return plant.category == PlantCategory.fruiting;
        case 'Herba & Rempah':
          return plant.category == PlantCategory.herbs;
        case 'Semua':
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.foregroundDark : AppColors.foregroundLight;
    final muted = isDark
        ? AppColors.mutedForegroundDark
        : AppColors.mutedForegroundLight;
    final cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final borderColor =
        isDark ? AppColors.borderDark : AppColors.borderLight;

    final appState = AppStateScope.of(context);
    final selectedFilter = appState.exploreFilter;
    final filteredPlants = _getFilteredPlants(selectedFilter);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Top Header ──────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 16,
                  bottom: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Katalog Tanaman',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: fg,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pilih sayuran atau buah yang pas untuk ruang & kebutuhanmu.',
                      style: TextStyle(fontSize: 13, color: muted),
                    ),
                    const SizedBox(height: 16),

                    // ── Search Bar ──────────────────────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor, width: 1.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: isDark ? 0.2 : 0.03,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) => setState(() => _searchQuery = val.trim()),
                        decoration: InputDecoration(
                          hintText: 'Cari kangkung, pakcoy, selada...',
                          hintStyle: TextStyle(fontSize: 13.5, color: muted),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.primary,
                            size: 22,
                          ),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear_rounded, size: 18),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() => _searchQuery = '');
                                  },
                                )
                              : null,
                          filled: false,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Filter Chips Horizontal Bar ─────────────────────────────────
            SliverToBoxAdapter(
              child: SizedBox(
                height: 46,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _filters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    final isSelected = filter == selectedFilter;

                    return FilterChip(
                      selected: isSelected,
                      label: Text(filter),
                      labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? AppColors.primaryForeground
                            : (isDark
                                ? AppColors.foregroundDark
                                : AppColors.foregroundLight),
                      ),
                      backgroundColor: cardBg,
                      selectedColor: AppColors.primary,
                      checkmarkColor: AppColors.primaryForeground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? AppColors.primary : borderColor,
                        ),
                      ),
                      onSelected: (_) {
                        appState.setExploreFilter(filter);
                      },
                    );
                  },
                ),
              ),
            ),

            // ── Urban Space Planner Promotional Banner ──────────────────────
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: SpacePlannerBanner(),
              ),
            ),

            // ── Section Title & Count ───────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pilihan Tanaman (${filteredPlants.length})',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: fg,
                      ),
                    ),
                    if (selectedFilter != 'Semua' || _searchQuery.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                          appState.setExploreFilter('Semua');
                        },
                        child: const Text(
                          'Reset Filter',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // ── Plants 2-Column Grid OR Empty Search ────────────────────────
            if (filteredPlants.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 100,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.76,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final plant = filteredPlants[index];
                      return PlantCard(
                        plant: plant,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PlantDetailScreen(plant: plant),
                            ),
                          );
                        },
                      );
                    },
                    childCount: filteredPlants.length,
                  ),
                ),
              )
            else
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 54,
                        color: muted,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Tidak ada tanaman yang cocok',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: fg,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Coba cari kata kunci lain atau pilih kategori "Semua".',
                        style: TextStyle(fontSize: 12.5, color: muted),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                          appState.setExploreFilter('Semua');
                        },
                        child: const Text('Tampilkan Semua Tanaman'),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

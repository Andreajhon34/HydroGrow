import 'package:flutter/material.dart';
import '../../../core/models/plant_model.dart';
import '../../../core/state/app_state.dart';
import '../../../core/theme/theme.dart';

/// Detailed planting guide screen for a specific plant.
/// Provides growing parameters, step-by-step stages, beginner tips,
/// and the primary "Mulai Tanam Sekarang" CTA button.
class PlantDetailScreen extends StatelessWidget {
  const PlantDetailScreen({
    super.key,
    required this.plant,
  });

  final Plant plant;

  void _onStartGrowing(BuildContext context) {
    final appState = AppStateScope.of(context);
    appState.addProjectFromPlant(plant);
    appState.setNavIndex(0); // Switch to My Garden tab

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '🎉 Proyek ${plant.name} berhasil ditambahkan ke "My Garden"!',
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    // Pop back to the main shell
    Navigator.of(context).pop();
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

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Sliver App Bar with Hero Image ────────────────────────────────
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    plant.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: isDark ? AppColors.mutedDark : AppColors.mutedLight,
                      child: const Center(
                        child: Icon(Icons.eco_rounded, size: 64, color: AppColors.primary),
                      ),
                    ),
                  ),
                  // Dark gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),
                  // Bottom title on image
                  Positioned(
                    bottom: 16,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            plant.category.label,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          plant.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          plant.latinName,
                          style: const TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Content Body ──────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Quick Info Grid ───────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: borderColor, width: 1.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _ParamItem(
                          icon: Icons.timer_outlined,
                          label: 'Estimasi Panen',
                          value: plant.harvestDuration,
                        ),
                        Container(width: 1, height: 36, color: borderColor),
                        _ParamItem(
                          icon: Icons.tune_rounded,
                          label: 'Tingkat Kesulitan',
                          value: plant.difficulty.label,
                        ),
                        Container(width: 1, height: 36, color: borderColor),
                        _ParamItem(
                          icon: Icons.wb_sunny_outlined,
                          label: 'Kebutuhan Sinar',
                          value: plant.sunlightHours,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Description ───────────────────────────────────────────
                  Text(
                    'Tentang Tanaman Ini',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: fg,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    plant.fullDescription,
                    style: TextStyle(fontSize: 13.5, color: muted, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // ── Growing Conditions Checklist ──────────────────────────
                  Text(
                    'Parameter Tumbuh Optimal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: fg,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: borderColor),
                    ),
                    child: Column(
                      children: [
                        _ConditionRow(
                          icon: Icons.science_outlined,
                          label: 'Kepekatan Nutrisi (PPM)',
                          value: plant.ppmRange,
                        ),
                        const Divider(height: 20),
                        _ConditionRow(
                          icon: Icons.water_drop_outlined,
                          label: 'Derajat Keasaman (pH)',
                          value: plant.phRange,
                        ),
                        const Divider(height: 20),
                        _ConditionRow(
                          icon: Icons.hardware_rounded,
                          label: 'Metode Rekomendasi',
                          value: plant.recommendedMethod,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Step-by-Step Growth Stages ────────────────────────────
                  Text(
                    'Tahapan & Panduan Menanam',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: fg,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(plant.steps.length, (idx) {
                    final step = plant.steps[idx];
                    final isLast = idx == plant.steps.length - 1;
                    return _StepTimelineTile(
                      stepNumber: idx + 1,
                      step: step,
                      isLast: isLast,
                    );
                  }),
                  const SizedBox(height: 24),

                  // ── Tips Box ──────────────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.tips_and_updates_rounded, color: AppColors.primary, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Tips Sukses Petani Perkotaan',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ...plant.tips.map((t) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('✓ ', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary)),
                                  Expanded(
                                    child: Text(
                                      t,
                                      style: TextStyle(fontSize: 12.5, color: fg, height: 1.4),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ── Primary Action CTA ────────────────────────────────────
                  ElevatedButton.icon(
                    onPressed: () => _onStartGrowing(context),
                    icon: const Icon(Icons.play_arrow_rounded, size: 22),
                    label: const Text('Mulai Tanam Sekarang'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 54),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParamItem extends StatelessWidget {
  const _ParamItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.mutedForegroundDark
                : AppColors.mutedForegroundLight,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ConditionRow extends StatelessWidget {
  const _ConditionRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).brightness == Brightness.dark
        ? AppColors.foregroundDark
        : AppColors.foregroundLight;
    final muted = Theme.of(context).brightness == Brightness.dark
        ? AppColors.mutedForegroundDark
        : AppColors.mutedForegroundLight;

    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 10),
        Text(label, style: TextStyle(fontSize: 12.5, color: muted)),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: fg,
          ),
        ),
      ],
    );
  }
}

class _StepTimelineTile extends StatelessWidget {
  const _StepTimelineTile({
    required this.stepNumber,
    required this.step,
    required this.isLast,
  });

  final int stepNumber;
  final PlantGrowthStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.foregroundDark : AppColors.foregroundLight;
    final muted = isDark
        ? AppColors.mutedForegroundDark
        : AppColors.mutedForegroundLight;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step indicator with vertical line
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$stepNumber',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryForeground,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.primary.withValues(alpha: 0.3),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          // Step details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        step.title,
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: fg,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.mutedDark : AppColors.mutedLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          step.dayRange,
                          style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: muted),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step.description,
                    style: TextStyle(fontSize: 12, color: muted, height: 1.4),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.opacity_rounded, size: 12, color: Color(0xFF38BDF8)),
                      const SizedBox(width: 4),
                      Text(
                        'Target: ${step.targetPpm}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF38BDF8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

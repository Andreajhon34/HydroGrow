import 'package:flutter/material.dart';
import '../../../core/state/app_state.dart';
import '../../../core/theme/theme.dart';
import '../../impact/widgets/create_surplus_dialog.dart';
import 'harvest_record_dialog.dart';
import 'nutrient_calculator_dialog.dart';

/// Central Quick Action Modal Bottom Sheet (inspired by OLIO's Add button).
/// Provides immediate access to the 4 essential hydroponic actions.
class QuickActionBottomSheet extends StatelessWidget {
  const QuickActionBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const QuickActionBottomSheet(),
    );
  }

  void _onShareSurplusTap(BuildContext context) {
    final appState = AppStateScope.of(context);
    Navigator.of(context).pop();
    appState.setNavIndex(3); // Switch to Impact tab
    CreateSurplusDialog.show(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final fg = isDark ? AppColors.foregroundDark : AppColors.foregroundLight;
    final appState = AppStateScope.of(context);

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.bolt_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Aksi Cepat Hidroponik',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: fg,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // ── Action 1: Start New Plant Batch ─────────────────────────────
            _ActionTile(
              icon: Icons.add_circle_outline_rounded,
              iconColor: AppColors.primary,
              title: 'Mulai Tanam Batch Baru',
              subtitle: 'Pilih tanaman dari katalog & panduan langkah demi langkah',
              onTap: () {
                Navigator.of(context).pop();
                appState.setNavIndex(1); // Switch to Explore
              },
            ),

            // ── Action 2: Calculate Nutrients / Log Water ───────────────────
            _ActionTile(
              icon: Icons.science_outlined,
              iconColor: const Color(0xFF38BDF8),
              title: 'Hitung Dosis Nutrisi & Cek Air',
              subtitle: 'Hitung takaran AB Mix presisi sesuai volume tandon air',
              onTap: () {
                Navigator.of(context).pop();
                NutrientCalculatorDialog.show(context);
              },
            ),

            // ── Action 3: Record a Harvest ──────────────────────────────────
            _ActionTile(
              icon: Icons.shopping_basket_outlined,
              iconColor: const Color(0xFF24C46E),
              title: 'Catat Hasil Panen',
              subtitle: 'Rekam berat panen & hitung penghematan belanja sayur',
              onTap: () {
                Navigator.of(context).pop();
                HarvestRecordDialog.show(context);
              },
            ),

            // ── Action 4: Share Surplus Seeds / Vegetables ───────────────────
            _ActionTile(
              icon: Icons.volunteer_activism_outlined,
              iconColor: const Color(0xFFF59E0B),
              title: 'Berbagi Bibit & Sayuran Berlebih',
              subtitle: 'Berbagi hasil kebun dengan sesama warga kota (SDG 2)',
              onTap: () => _onShareSurplusTap(context),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.foregroundDark : AppColors.foregroundLight;
    final muted = isDark
        ? AppColors.mutedForegroundDark
        : AppColors.mutedForegroundLight;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.mutedDark.withValues(alpha: 0.4)
                : AppColors.mutedLight.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: fg,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 11.5, color: muted),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

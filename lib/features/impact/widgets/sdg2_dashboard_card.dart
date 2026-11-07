import 'package:flutter/material.dart';

import '../../../core/state/app_state.dart';
import '../../../core/theme/theme.dart';

/// Hero Dashboard Card highlighting SDG 2 — Zero Hunger achievements,
/// food self-sufficiency percentage, and environmental savings.
class Sdg2DashboardCard extends StatelessWidget {
  const Sdg2DashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.foregroundDark : AppColors.foregroundLight;
    final muted = isDark
        ? AppColors.mutedForegroundDark
        : AppColors.mutedForegroundLight;
    final cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    final appState = AppStateScope.of(context);
    final totalGrams = appState.totalHarvestWeightGrams;
    final portions = appState.estimatedNutritiousPortions;
    final savings = appState.totalEstimatedSavingsRp;
    final co2 = appState.estimatedCo2SavedKg;
    final percent = appState.monthlySelfSufficiencyPercent;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top Header Row ────────────────────────────────────────────────
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(
                    0xFFDDA63A,
                  ), // UN SDG 2 Official Gold/Orange
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.public_rounded, size: 12, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'SDG 2 • ZERO HUNGER',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Text(
                'Mandiri Pangan Rumah',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Self-Sufficiency Ring & Intro ─────────────────────────────────
          Row(
            children: [
              SizedBox(
                width: 76,
                height: 76,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: CircularProgressIndicator(
                        value: percent / 100,
                        strokeWidth: 7,
                        backgroundColor: isDark
                            ? AppColors.mutedDark
                            : AppColors.mutedLight,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${percent.round()}%',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: fg,
                              height: 1.1,
                            ),
                          ),
                          Text(
                            'Tercapai',
                            style: TextStyle(
                              fontSize: 9,
                              color: muted,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Title and Explanation
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kemandirian Sayur Keluarga',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: fg,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Anda telah memproduksi ${percent.round()}% target kebutuhan sayur hijau bulanan dari kebun hidroponik sendiri.',
                      style: TextStyle(fontSize: 12, color: muted, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── 4 Metric Highlights ───────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? AppColors.mutedDark : AppColors.mutedLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MetricItem(
                  icon: Icons.scale_rounded,
                  iconColor: const Color(0xFF24C46E),
                  value: totalGrams >= 1000
                      ? '${(totalGrams / 1000).toStringAsFixed(1)} kg'
                      : '$totalGrams g',
                  label: 'Total Panen',
                ),
                Container(width: 1, height: 32, color: borderColor),
                _MetricItem(
                  icon: Icons.restaurant_rounded,
                  iconColor: const Color(0xFF38BDF8),
                  value: '$portions Porsi',
                  label: 'Gizi Sehat',
                ),
                Container(width: 1, height: 32, color: borderColor),
                _MetricItem(
                  icon: Icons.savings_outlined,
                  iconColor: const Color(0xFFF59E0B),
                  value: 'Rp ${(savings / 1000).toStringAsFixed(0)}k',
                  label: 'Hemat Belanja',
                ),
                Container(width: 1, height: 32, color: borderColor),
                _MetricItem(
                  icon: Icons.eco_outlined,
                  iconColor: AppColors.primary,
                  value: '${co2.toStringAsFixed(1)} kg',
                  label: 'CO2e Dipangkas',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  const _MetricItem({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).brightness == Brightness.dark
        ? AppColors.foregroundDark
        : AppColors.foregroundLight;
    final muted = Theme.of(context).brightness == Brightness.dark
        ? AppColors.mutedForegroundDark
        : AppColors.mutedForegroundLight;

    return Column(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: fg,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 10, color: muted)),
      ],
    );
  }
}

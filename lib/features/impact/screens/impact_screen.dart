import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import '../widgets/harvest_history_card.dart';
import '../widgets/sdg2_dashboard_card.dart';
import '../widgets/surplus_swap_feed.dart';

/// Primary Screen for "Impact" (Position 5 in Bottom Navigation Bar).
/// Focuses on SDG 2 — Zero Hunger, food self-sufficiency metrics,
/// personal harvest log, and the OLIO-inspired neighborhood surplus sharing feed.
class ImpactScreen extends StatelessWidget {
  const ImpactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.foregroundDark : AppColors.foregroundLight;
    final muted = isDark
        ? AppColors.mutedForegroundDark
        : AppColors.mutedForegroundLight;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: ListView(
            padding: const EdgeInsets.only(bottom: 100),
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children: [
              // ── Header ────────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 16,
                  bottom: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Dampak Mandiri Pangan',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: fg,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.eco_rounded,
                          color: AppColors.primary,
                          size: 24,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pencapaian mandiri pangan keluarga (SDG 2) & papan berbagi panen.',
                      style: TextStyle(fontSize: 13, color: muted),
                    ),
                  ],
                ),
              ),

              // ── 1. SDG 2 Impact Dashboard Card ─────────────────────────────
              const Sdg2DashboardCard(),

              // ── 2. Harvest History Log Card ────────────────────────────────
              const HarvestHistoryCard(),

              // ── 3. Community Surplus & Seedling Swap Feed (OLIO style) ─────
              const SurplusSwapFeed(),
            ],
          ),
        ),
      ),
    );
  }
}

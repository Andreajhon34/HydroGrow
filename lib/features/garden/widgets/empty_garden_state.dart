import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

/// Welcoming empty state for brand new users without active planting projects.
class EmptyGardenState extends StatelessWidget {
  const EmptyGardenState({
    super.key,
    required this.onExplorePlantsTap,
    required this.onPlanSpaceTap,
  });

  final VoidCallback onExplorePlantsTap;
  final VoidCallback onPlanSpaceTap;

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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(24),
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
        children: [
          // Graphic container
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.yard_outlined,
                    size: 44,
                    color: AppColors.primary.withValues(alpha: 0.4),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Icon(
                      Icons.eco_rounded,
                      size: 32,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Friendly Title
          Text(
            'Kebunmu Masih Siap Ditanami!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: fg,
              letterSpacing: -0.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            'Belum ada tanaman yang aktif. Mulai tanam sayuran pertamamu dan wujudkan kemandirian pangan keluarga (SDG 2).',
            style: TextStyle(fontSize: 13, color: muted, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // CTA 1: Explore Plants
          ElevatedButton.icon(
            onPressed: onExplorePlantsTap,
            icon: const Icon(Icons.search_rounded),
            label: const Text('Jelajahi Katalog Tanaman'),
          ),
          const SizedBox(height: 10),

          // CTA 2: Plan Space
          OutlinedButton.icon(
            onPressed: onPlanSpaceTap,
            icon: const Icon(Icons.architecture_rounded),
            label: const Text('Rencanakan Wadah & Ruangan'),
          ),
        ],
      ),
    );
  }
}

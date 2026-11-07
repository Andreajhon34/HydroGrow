import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';

/// Interactive modal bottom sheet providing quick AB Mix nutrient calculation
/// and water logging for daily maintenance.
class NutrientCalculatorDialog extends StatefulWidget {
  const NutrientCalculatorDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const NutrientCalculatorDialog(),
    );
  }

  @override
  State<NutrientCalculatorDialog> createState() =>
      _NutrientCalculatorDialogState();
}

class _NutrientCalculatorDialogState extends State<NutrientCalculatorDialog> {
  double _waterVolumeLiters = 5.0;
  String _plantType = 'Sayuran Daun (Pakcoy / Kangkung)';

  // Standard dosing: 5 mL of Stock A + 5 mL of Stock B per 1 Liter for ~1000-1200 PPM
  double get _stockAmountMl => _waterVolumeLiters * 5;
  int get _capCount => (_stockAmountMl / 5).round();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final fg = isDark ? AppColors.foregroundDark : AppColors.foregroundLight;
    final muted = isDark
        ? AppColors.mutedForegroundDark
        : AppColors.mutedForegroundLight;
    final borderColor =
        isDark ? AppColors.borderDark : AppColors.borderLight;

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
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

              // Title Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.science_outlined,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kalkulator Dosis Nutrisi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: fg,
                          ),
                        ),
                        Text(
                          'Formula standar AB Mix Sayuran Daun',
                          style: TextStyle(fontSize: 12, color: muted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Target Plant Category
              Text(
                'Kategori Tanaman',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.mutedDark : AppColors.mutedLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _plantType,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    dropdownColor: cardBg,
                    items: const [
                      DropdownMenuItem(
                        value: 'Sayuran Daun (Pakcoy / Kangkung)',
                        child: Text('Sayuran Daun (Pakcoy / Kangkung) — 1200 PPM'),
                      ),
                      DropdownMenuItem(
                        value: 'Selada Keriting (Ringan)',
                        child: Text('Selada Keriting (Ringan) — 600 - 800 PPM'),
                      ),
                      DropdownMenuItem(
                        value: 'Tanaman Buah (Tomat Cherry)',
                        child: Text('Tanaman Buah (Tomat Cherry) — 1800 PPM'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _plantType = val);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Volume Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Volume Air Tandon / Botol',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: fg,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${_waterVolumeLiters.toStringAsFixed(1)} Liter',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              Slider(
                value: _waterVolumeLiters,
                min: 1.0,
                max: 20.0,
                divisions: 19,
                activeColor: AppColors.primary,
                inactiveColor: isDark
                    ? AppColors.mutedDark
                    : AppColors.mutedLight,
                label: '${_waterVolumeLiters.toStringAsFixed(0)} L',
                onChanged: (val) => setState(() => _waterVolumeLiters = val),
              ),
              // Preset chips
              Wrap(
                spacing: 8,
                children: [1.5, 3.0, 5.0, 10.0].map((liters) {
                  final isSelected = _waterVolumeLiters == liters;
                  return ChoiceChip(
                    label: Text('${liters.toStringAsFixed(liters == 1.5 ? 1 : 0)} L'),
                    selected: isSelected,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primaryForeground
                          : (isDark ? AppColors.foregroundDark : AppColors.foregroundLight),
                    ),
                    onSelected: (_) => setState(() => _waterVolumeLiters = liters),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Calculation Result Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.15),
                      AppColors.accentLight.withValues(alpha: isDark ? 0.05 : 0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.4),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Resep Takaran Nutrisi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _DoseItem(
                          label: 'Pekatan A',
                          amount: '${_stockAmountMl.toStringAsFixed(0)} mL',
                          householdEquivalent: '$_capCount Tutup Botol',
                          color: const Color(0xFFEF4444),
                        ),
                        Container(
                          width: 1,
                          height: 36,
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                        _DoseItem(
                          label: 'Pekatan B',
                          amount: '${_stockAmountMl.toStringAsFixed(0)} mL',
                          householdEquivalent: '$_capCount Tutup Botol',
                          color: const Color(0xFF3B82F6),
                        ),
                        Container(
                          width: 1,
                          height: 36,
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                        _DoseItem(
                          label: 'Air Baku',
                          amount: '${_waterVolumeLiters.toStringAsFixed(1)} L',
                          householdEquivalent: 'Air Bersih',
                          color: const Color(0xFF10B981),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Save action
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '💧 Takaran ${_stockAmountMl.toStringAsFixed(0)} mL Nutrisi A & B berhasil diterapkan ke tandon!',
                      ),
                      backgroundColor: AppColors.primary,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle_outline_rounded),
                label: const Text('Terapkan Takaran Air'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoseItem extends StatelessWidget {
  const _DoseItem({
    required this.label,
    required this.amount,
    required this.householdEquivalent,
    required this.color,
  });

  final String label;
  final String amount;
  final String householdEquivalent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          householdEquivalent,
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.mutedForegroundDark
                : AppColors.mutedForegroundLight,
          ),
        ),
      ],
    );
  }
}

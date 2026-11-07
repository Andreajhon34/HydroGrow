import 'package:flutter/material.dart';
import '../../../core/models/harvest_record_model.dart';
import '../../../core/state/app_state.dart';
import '../../../core/theme/theme.dart';

/// Modal bottom sheet for recording a completed harvest.
/// Saves harvest record into [AppState] to calculate food self-sufficiency metrics.
class HarvestRecordDialog extends StatefulWidget {
  const HarvestRecordDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const HarvestRecordDialog(),
    );
  }

  @override
  State<HarvestRecordDialog> createState() => _HarvestRecordDialogState();
}

class _HarvestRecordDialogState extends State<HarvestRecordDialog> {
  final _weightController = TextEditingController(text: '350');
  final _notesController = TextEditingController();
  String _selectedPlant = 'Pakcoy Hijau';

  static const List<String> _plantOptions = [
    'Pakcoy Hijau',
    'Kangkung Air',
    'Selada Keriting',
    'Bayam Hijau',
    'Tomat Cherry',
    'Daun Kemangi',
    'Sawi Caisim',
  ];

  @override
  void dispose() {
    _weightController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onSaveHarvest() {
    final weight = int.tryParse(_weightController.text.trim()) ?? 0;
    if (weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap masukkan berat panen yang valid!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final appState = AppStateScope.of(context);
    final estimatedSavings = (weight * 35); // Approx Rp 35 per gram (~Rp 35.000/kg)

    final newRecord = HarvestRecord(
      id: 'harvest_${DateTime.now().millisecondsSinceEpoch}',
      plantName: _selectedPlant,
      weightGrams: weight,
      harvestDate: DateTime.now(),
      notes: _notesController.text.trim().isEmpty
          ? 'Panen segar kebun hidroponik mandiri'
          : _notesController.text.trim(),
      estimatedSavingsRp: estimatedSavings,
    );

    appState.addHarvestRecord(newRecord);
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '🎉 Berhasil mencatat panen $weight gram $_selectedPlant! Penghematan: Rp $estimatedSavings',
        ),
        backgroundColor: const Color(0xFF24C46E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

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

              // Title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF24C46E).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.shopping_basket_rounded,
                      color: Color(0xFF24C46E),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Catat Hasil Panen',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: fg,
                          ),
                        ),
                        Text(
                          'Kontribusi mandiri pangan keluarga (SDG 2)',
                          style: TextStyle(fontSize: 12, color: muted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Plant selector dropdown
              Text(
                'Tanaman yang Dipanen',
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
                    value: _selectedPlant,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    dropdownColor: cardBg,
                    items: _plantOptions.map((plant) {
                      return DropdownMenuItem(
                        value: plant,
                        child: Text(plant),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedPlant = val);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Harvest Weight input
              Text(
                'Berat Hasil Panen (Gram)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Contoh: 350',
                  suffixText: 'Gram',
                  prefixIcon: const Icon(Icons.scale_rounded, size: 20),
                  filled: true,
                  fillColor: isDark ? AppColors.mutedDark : AppColors.mutedLight,
                ),
              ),
              const SizedBox(height: 16),

              // Notes
              Text(
                'Catatan Tambahan (Opsional)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _notesController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Misal: Daun tebal, rasa manis tanpa pahit...',
                  filled: true,
                  fillColor: isDark ? AppColors.mutedDark : AppColors.mutedLight,
                ),
              ),
              const SizedBox(height: 24),

              // Save button
              ElevatedButton.icon(
                onPressed: _onSaveHarvest,
                icon: const Icon(Icons.check_circle_rounded),
                label: const Text('Simpan Rekor Panen'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF24C46E),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

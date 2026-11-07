import 'package:flutter/material.dart';
import '../../../core/models/surplus_item_model.dart';
import '../../../core/state/app_state.dart';
import '../../../core/theme/theme.dart';

/// Modal dialog allowing users to post their surplus seedlings or harvest
/// to the neighborhood feed (OLIO style, supporting SDG 2).
class CreateSurplusDialog extends StatefulWidget {
  const CreateSurplusDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CreateSurplusDialog(),
    );
  }

  @override
  State<CreateSurplusDialog> createState() => _CreateSurplusDialogState();
}

class _CreateSurplusDialogState extends State<CreateSurplusDialog> {
  final _titleController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController(text: 'Apartemen / Rumah Sendiri');

  SurplusType _selectedType = SurplusType.free;
  SurplusCategory _selectedCategory = SurplusCategory.seedlings;

  @override
  void dispose() {
    _titleController.dispose();
    _quantityController.dispose();
    _descController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Judul postingan tidak boleh kosong!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final newItem = SurplusItem(
      id: 'surplus_${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text.trim(),
      description: _descController.text.trim().isEmpty
          ? 'Hasil kebun hidroponik mandiri siap dibagikan ke tetangga.'
          : _descController.text.trim(),
      type: _selectedType,
      category: _selectedCategory,
      donorName: 'Urban Farmer (Anda)',
      donorLocation: _locationController.text.trim(),
      distanceKm: 0.1,
      quantity: _quantityController.text.trim().isEmpty
          ? '1 Paket'
          : _quantityController.text.trim(),
      postedTimeAgo: 'Baru saja',
      imageUrl: _selectedCategory == SurplusCategory.seedlings
          ? 'https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=600&q=80'
          : 'https://images.unsplash.com/photo-1622206151226-18ca2c9ab4a1?auto=format&fit=crop&w=600&q=80',
    );

    final appState = AppStateScope.of(context);
    appState.addSurplusItem(newItem);
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '🌱 Postingan "${newItem.title}" berhasil dibagikan ke komunitas tetangga!',
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.foregroundDark : AppColors.foregroundLight;
    final muted = isDark
        ? AppColors.mutedForegroundDark
        : AppColors.mutedForegroundLight;
    final cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;

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
              // Drag Handle
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
                      Icons.volunteer_activism_rounded,
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
                          'Bagikan Bibit / Panen Berlebih',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: fg,
                          ),
                        ),
                        Text(
                          'Bantu ketahanan pangan tetangga sekitar (SDG 2)',
                          style: TextStyle(fontSize: 12, color: muted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Type Selector: Gratis vs Barter
              Text(
                'Jenis Pembagian',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: fg),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('🎁 GRATIS (Sedekah Sayur)')),
                      selected: _selectedType == SurplusType.free,
                      selectedColor: const Color(0xFF24C46E),
                      labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _selectedType == SurplusType.free ? Colors.white : fg,
                      ),
                      onSelected: (_) => setState(() => _selectedType = SurplusType.free),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ChoiceChip(
                      label: const Center(child: Text('🔄 BARTER (Tukar Benih)')),
                      selected: _selectedType == SurplusType.barter,
                      selectedColor: const Color(0xFF3B82F6),
                      labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _selectedType == SurplusType.barter ? Colors.white : fg,
                      ),
                      onSelected: (_) => setState(() => _selectedType = SurplusType.barter),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                'Nama Barang / Bibit',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: fg),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Misal: 10 Semai Kangkung Siap Pindah',
                  fillColor: isDark ? AppColors.mutedDark : AppColors.mutedLight,
                ),
              ),
              const SizedBox(height: 14),

              // Quantity
              Text(
                'Jumlah / Porsi',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: fg),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(
                  hintText: 'Misal: 10 netpot / 500 gram',
                  fillColor: isDark ? AppColors.mutedDark : AppColors.mutedLight,
                ),
              ),
              const SizedBox(height: 14),

              // Description
              Text(
                'Deskripsi & Cara Pengambilan',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: fg),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _descController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Misal: Bisa diambil di lobi tower A bawa wadah sendiri...',
                  fillColor: isDark ? AppColors.mutedDark : AppColors.mutedLight,
                ),
              ),
              const SizedBox(height: 22),

              // Submit
              ElevatedButton.icon(
                onPressed: _onSubmit,
                icon: const Icon(Icons.send_rounded),
                label: const Text('Publikasikan ke Komunitas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

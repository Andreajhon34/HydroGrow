import 'package:flutter/material.dart';

import '../../../core/models/supply_store_model.dart';
import '../../../core/theme/theme.dart';

/// Interactive Local Supply Map view showcasing nearby urban farming stores.
/// Features a stylized urban vector map with interactive pins and store info cards.
class LocalSupplyMapView extends StatefulWidget {
  const LocalSupplyMapView({super.key});

  @override
  State<LocalSupplyMapView> createState() => _LocalSupplyMapViewState();
}

class _LocalSupplyMapViewState extends State<LocalSupplyMapView> {
  String _selectedCategory = 'Semua';
  int _selectedStoreIndex = 0;

  static const List<String> _categories = [
    'Semua',
    'Nutrisi & Media',
    'Peralatan & Modul DIY',
    'Bibit & Pupuk',
  ];

  List<SupplyStore> get _filteredStores {
    if (_selectedCategory == 'Semua') {
      return SampleSupplyStores.stores;
    }
    return SampleSupplyStores.stores.where((s) {
      if (_selectedCategory == 'Nutrisi & Media') {
        return s.category.contains('Nutrisi') || s.category.contains('Media');
      } else if (_selectedCategory == 'Peralatan & Modul DIY') {
        return s.category.contains('Peralatan') || s.category.contains('Wadah');
      } else {
        return s.category.contains('Bibit') || s.category.contains('Pupuk');
      }
    }).toList();
  }

  void _onContactStore(SupplyStore store) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(
              Icons.chat_bubble_outline_rounded,
              color: Color(0xFF24C46E),
            ),
            const SizedBox(width: 8),
            Text(store.name),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nomor WhatsApp Toko: ${store.phoneNumber}'),
            const SizedBox(height: 8),
            Text('Jam Operasional: ${store.openHours}'),
            const SizedBox(height: 12),
            const Text(
              'Anda dapat menanyakan ketersediaan stok AB Mix, benih, atau rockwool langsung ke penjual.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Membuka WhatsApp menuju ${store.name}...'),
                  backgroundColor: const Color(0xFF24C46E),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Buka WhatsApp'),
          ),
        ],
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
    final borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    final stores = _filteredStores;
    final activeStore = stores.isNotEmpty
        ? stores[_selectedStoreIndex.clamp(0, stores.length - 1)]
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Category Filter Bar ─────────────────────────────────────────────
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final cat = _categories[index];
              final isSelected = cat == _selectedCategory;
              return FilterChip(
                selected: isSelected,
                label: Text(cat),
                labelStyle: TextStyle(
                  fontSize: 11.5,
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
                  setState(() {
                    _selectedCategory = cat;
                    _selectedStoreIndex = 0;
                  });
                },
              );
            },
          ),
        ),
        const SizedBox(height: 12),

        // ── Stylized Interactive Vector Map Canvas ──────────────────────────
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 220,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF131D33) : const Color(0xFFE2E9F3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final mapWidth = constraints.maxWidth;
                final mapHeight = constraints.maxHeight;

                return Stack(
                  children: [
                    // Custom Map Painter (roads, canal, parks)
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _UrbanMapPainter(isDark: isDark),
                      ),
                    ),

                    // Radius Badge
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.radar_rounded,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Radius 3.5 km dari Anda',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // User Location Pin
                    Positioned(
                      left: (mapWidth * 0.42).clamp(10.0, mapWidth - 40.0),
                      top: (mapHeight * 0.45).clamp(10.0, mapHeight - 40.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF38BDF8),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF38BDF8)
                                      .withValues(alpha: 0.6),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.person_pin_circle_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Anda',
                              style: TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Store Pins on the Map
                    ...List.generate(stores.length, (idx) {
                      final store = stores[idx];
                      final isSelected = idx == _selectedStoreIndex;
                      final pinLeft = (store.mapXPercent * (mapWidth - 60))
                          .clamp(10.0, mapWidth - 70.0);
                      final pinTop = (store.mapYPercent * (mapHeight - 50))
                          .clamp(10.0, mapHeight - 60.0);

                      return Positioned(
                        left: pinLeft,
                        top: pinTop,
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedStoreIndex = idx),
                          child: AnimatedScale(
                            scale: isSelected ? 1.25 : 1.0,
                            duration: const Duration(milliseconds: 200),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : cardBg,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.black
                                          : AppColors.primary,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isSelected
                                            ? AppColors.primary.withValues(
                                                alpha: 0.5,
                                              )
                                            : Colors.black26,
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.store_mall_directory_rounded,
                                    size: 16,
                                    color: isSelected
                                        ? AppColors.primaryForeground
                                        : AppColors.primary,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 1.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.black.withValues(alpha: 0.75),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    store.name.split(' ').first,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ── Selected Store Details Card ─────────────────────────────────────
        if (activeStore != null)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primary, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        activeStore.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 60,
                          height: 60,
                          color: isDark
                              ? AppColors.mutedDark
                              : AppColors.mutedLight,
                          child: const Icon(
                            Icons.storefront,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  activeStore.name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: fg,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  activeStore.formattedDistance,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            activeStore.category,
                            style: TextStyle(fontSize: 11.5, color: muted),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 16,
                                color: Color(0xFFFBBF24),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${activeStore.rating}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                ' (${activeStore.reviewCount}) • ${activeStore.openHours}',
                                style: TextStyle(fontSize: 11, color: muted),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Address
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.place_outlined, size: 16, color: muted),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        activeStore.address,
                        style: TextStyle(fontSize: 12, color: fg),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // In-Stock Tags
                Text(
                  'Stok Tersedia di Toko Ini:',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: muted,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: activeStore.stockTags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.mutedDark
                            : AppColors.mutedLight,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: borderColor),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(fontSize: 10.5, color: fg),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Actions: Directions & WhatsApp
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '🗺️ Navigasi rute tercepat ke ${activeStore.name} (${activeStore.formattedDistance}).',
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.directions_rounded, size: 16),
                        label: const Text('Petunjuk Rute'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 42),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _onContactStore(activeStore),
                        icon: const Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: 16,
                        ),
                        label: const Text('Kontak Toko'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0, 42),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Custom painter generating an aesthetic urban map schematic background.
class _UrbanMapPainter extends CustomPainter {
  const _UrbanMapPainter({required this.isDark});

  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()
      ..color = isDark ? const Color(0xFF131D33) : const Color(0xFFE5ECF5);
    canvas.drawRect(Offset.zero & size, bgPaint);

    // Green Parks / Gardens
    final parkPaint = Paint()
      ..color = isDark
          ? const Color(0xFF193828).withValues(alpha: 0.6)
          : const Color(0xFFD4EBD9);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(15, 20, 60, 45),
        const Radius.circular(8),
      ),
      parkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width - 85, size.height - 70, 70, 50),
        const Radius.circular(8),
      ),
      parkPaint,
    );

    // River / Canal
    final waterPaint = Paint()
      ..color = isDark ? const Color(0xFF1E3A5F) : const Color(0xFFC7E1FB)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
        size.width * 0.4,
        size.height * 0.85,
        size.width * 0.7,
        size.height * 0.4,
      )
      ..lineTo(size.width, size.height * 0.2);
    canvas.drawPath(path, waterPaint);

    // Major Roads
    final roadPaint = Paint()
      ..color = isDark ? const Color(0xFF23324E) : Colors.white
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke;

    // Horizontal main boulevard
    canvas.drawLine(
      Offset(0, size.height * 0.45),
      Offset(size.width, size.height * 0.45),
      roadPaint,
    );

    // Vertical main avenues
    canvas.drawLine(
      Offset(size.width * 0.35, 0),
      Offset(size.width * 0.35, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, 0),
      Offset(size.width * 0.7, size.height),
      roadPaint,
    );

    // Diagonal street
    canvas.drawLine(
      Offset(size.width * 0.1, size.height),
      Offset(size.width * 0.5, 0),
      roadPaint..strokeWidth = 6,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

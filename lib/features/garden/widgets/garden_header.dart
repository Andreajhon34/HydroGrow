import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import 'profile_dialog.dart';

/// Top header for the "My Garden" dashboard screen.
/// Features a friendly time-sensitive greeting, notification bell,
/// and user CircleAvatar.
class GardenHeader extends StatelessWidget {
  const GardenHeader({super.key, this.userName = 'Urban Farmer'});

  final String userName;

  String _getTimeGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 11) return 'Selamat pagi';
    if (hour < 15) return 'Selamat siang';
    if (hour < 18) return 'Selamat sore';
    return 'Selamat malam';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.foregroundDark : AppColors.foregroundLight;
    final muted = isDark
        ? AppColors.mutedForegroundDark
        : AppColors.mutedForegroundLight;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Greeting text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: fg,
                      letterSpacing: -0.5,
                    ),
                    children: [
                      TextSpan(text: '${_getTimeGreeting()},\n'),
                      TextSpan(
                        text: userName,
                        style: const TextStyle(color: AppColors.primary),
                      ),
                      const TextSpan(text: ' 🌱'),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pantau & rawat kebun hidroponikmu hari ini.',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: muted, fontSize: 13),
                ),
              ],
            ),
          ),

          // Notification icon
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : AppColors.cardLight,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                width: 1,
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.notifications_none_rounded, size: 22),
              color: fg,
              tooltip: 'Notifikasi',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      '🔔 Belum ada notifikasi baru. Tanamanmu dalam kondisi prima!',
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),

          // User Profile CircleAvatar
          GestureDetector(
            onTap: () => ProfileDialog.show(context),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary,
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
